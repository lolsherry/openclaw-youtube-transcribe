# openclaw-youtube-transcribe

A small OpenClaw skill for turning a YouTube URL into local transcripts with `yt-dlp` + OpenAI Whisper CLI.

## What it does

- downloads audio from a single YouTube video
- converts/transcodes to `m4a`
- runs local Whisper transcription
- keeps `txt`, `srt`, `vtt`, `tsv`, and `json` outputs together
- stores each video in its own folder

Default output root:

```text
${HOME}/Documents/youtube-transcripts
```

Output layout:

```text
${HOME}/Documents/youtube-transcripts/
  <title> [id]/
    audio/
      audio.m4a
      audio.info.json
    transcript/
      audio.txt
      audio.srt
      audio.vtt
      audio.tsv
      audio.json
```

## Requirements

The script expects these binaries on `PATH`:

- `yt-dlp`
- `ffmpeg`
- `whisper`
- `python3`

Example on macOS with Homebrew:

```bash
brew install yt-dlp ffmpeg openai-whisper
```

## Run directly

```bash
./skills/youtube-transcribe/scripts/transcribe_youtube.sh "https://www.youtube.com/watch?v=..."
```

Optional flags:

```bash
./skills/youtube-transcribe/scripts/transcribe_youtube.sh "<YOUTUBE_URL>" \
  --lang zh|auto \
  --task transcribe|translate \
  --model tiny|base|small|medium|large|turbo \
  --format txt|srt|vtt|json|tsv|all \
  --out-dir "/path/to/output"
```

## Use as an OpenClaw workspace skill

Copy or symlink `skills/youtube-transcribe` into an OpenClaw workspace `skills/` directory, or install it through your preferred skill workflow.

## Notes

- `--no-playlist` is enforced to avoid accidental playlist downloads.
- The default language is `zh`; use `--lang auto` for mixed/unknown language videos.
- The script is designed to be simple and local-first rather than highly optimized.
