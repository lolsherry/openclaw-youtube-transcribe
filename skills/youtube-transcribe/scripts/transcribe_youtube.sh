#!/usr/bin/env bash
set -euo pipefail

usage() {
  cat <<'EOF'
Usage: transcribe_youtube.sh <YOUTUBE_URL> [--lang zh|auto] [--task transcribe|translate] [--model tiny|base|small|medium|large|turbo] [--format txt|srt|vtt|json|tsv|all] [--out-dir /path/to/output]
EOF
}

log() {
  printf '[INFO] %s\n' "$*"
}

if [ $# -lt 1 ]; then
  usage >&2
  exit 1
fi

URL="$1"
shift

LANG="zh"
TASK="transcribe"
MODEL="small"
FORMAT="all"
OUT_DIR="${HOME}/Documents/youtube-transcripts"

while [ $# -gt 0 ]; do
  case "$1" in
    --lang)
      LANG="$2"; shift 2 ;;
    --task)
      TASK="$2"; shift 2 ;;
    --model)
      MODEL="$2"; shift 2 ;;
    --format)
      FORMAT="$2"; shift 2 ;;
    --out-dir)
      OUT_DIR="$2"; shift 2 ;;
    -h|--help)
      usage; exit 0 ;;
    *)
      echo "Unknown arg: $1" >&2; exit 1 ;;
  esac
done

for bin in yt-dlp ffmpeg whisper python3; do
  if ! command -v "$bin" >/dev/null 2>&1; then
    echo "[ERROR] $bin not found" >&2
    exit 1
  fi
done

mkdir -p "$OUT_DIR"

log "Resolving video metadata..."
TITLE=$(yt-dlp --no-playlist --print '%(title)s' "$URL" 2>/dev/null | head -n 1 || true)
VID=$(yt-dlp --no-playlist --print '%(id)s' "$URL" 2>/dev/null | head -n 1 || true)

TITLE=$(python3 -c 'import re,sys; t=sys.argv[1] if len(sys.argv)>1 else "video"; safe=re.sub(r"[\\/:*?\"<>|\n\r\t]","_", t).strip(); print((safe[:120] or "video"))' "$TITLE")
if [ -z "$VID" ]; then
  VID="unknown"
fi

VIDEO_DIR="$OUT_DIR/${TITLE} [${VID}]"
AUDIO_DIR="$VIDEO_DIR/audio"
TX_DIR="$VIDEO_DIR/transcript"
mkdir -p "$AUDIO_DIR" "$TX_DIR"

AUDIO_PATH="$AUDIO_DIR/audio.m4a"
INFO_PATH="$AUDIO_DIR/audio.info.json"

log "Video: $TITLE [$VID]"
log "Output directory: $VIDEO_DIR"
log "Downloading audio with yt-dlp..."
yt-dlp --no-playlist -x --audio-format m4a \
  -o "$AUDIO_PATH" \
  --write-info-json --output-na-placeholder "unknown" \
  --print "after_move:filepath" \
  "$URL" >/dev/null

FOUND_INFO=$(ls "$AUDIO_DIR"/*.info.json 2>/dev/null | head -n 1 || true)
if [ -n "$FOUND_INFO" ] && [ "$FOUND_INFO" != "$INFO_PATH" ]; then
  mv -f "$FOUND_INFO" "$INFO_PATH"
fi

if [ -f "$AUDIO_PATH" ]; then
  find "$AUDIO_DIR" -maxdepth 1 -type f \( -name 'audio.webm' -o -name 'audio.mp4' -o -name 'audio.opus' \) -delete
fi

log "Running Whisper (model=$MODEL, lang=$LANG, task=$TASK, format=$FORMAT)..."
WHISPER_ARGS=("$AUDIO_PATH" --task "$TASK" --model "$MODEL" --output_dir "$TX_DIR" --output_format "$FORMAT")
if [ "$LANG" != "auto" ]; then
  WHISPER_ARGS+=(--language "$LANG")
fi

whisper "${WHISPER_ARGS[@]}"

log "Done. Transcript directory: $TX_DIR"
log "Audio file: $AUDIO_PATH"
if [ -f "$INFO_PATH" ]; then
  log "Metadata file: $INFO_PATH"
fi
log "Transcript files:"
find "$TX_DIR" -maxdepth 1 -type f | sed 's/^/[INFO]   - /'
