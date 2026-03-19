# openclaw-youtube-transcribe

An OpenClaw skill for turning a YouTube URL into local transcripts with `yt-dlp` + OpenAI Whisper CLI.

简体中文说明见：[README.zh-CN.md](./README.zh-CN.md)

## Features

- Download audio from a single YouTube video
- Transcode/extract to `m4a`
- Run local Whisper transcription
- Keep `txt`, `srt`, `vtt`, `tsv`, and `json` outputs together
- Store each video in its own folder
- Use a simple shell script that also works outside OpenClaw

## Default output

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

## Quick start

Run directly:

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

Defaults:

- `--lang zh`
- `--task transcribe`
- `--model small`
- `--format all`

## Use as an OpenClaw skill

Copy or symlink `skills/youtube-transcribe` into an OpenClaw workspace `skills/` directory.

Example:

```bash
mkdir -p /path/to/workspace/skills
cp -R ./skills/youtube-transcribe /path/to/workspace/skills/
```

Then start a new OpenClaw session so the skill is picked up cleanly.

## Example

```bash
./skills/youtube-transcribe/scripts/transcribe_youtube.sh \
  "https://www.youtube.com/watch?v=vimU_EHAuAs" \
  --lang zh \
  --model small
```

See a real sample run and transcript excerpt:

- [examples/example-output.md](./examples/example-output.md)
- [examples/example-output.zh-CN.md](./examples/example-output.zh-CN.md)

## Notes

- `--no-playlist` is enforced to avoid accidental playlist downloads.
- Use `--lang auto` when the language is mixed or unknown.
- The first Whisper run can be slow because the model may need to be downloaded.
- CPU-only runs work fine, but they are slower than GPU-backed runs.
- The script is intentionally simple and local-first rather than highly optimized.

## Repo contents

```text
README.md
README.zh-CN.md
skills/
  youtube-transcribe/
    SKILL.md
    scripts/
      transcribe_youtube.sh
```

## License

MIT
