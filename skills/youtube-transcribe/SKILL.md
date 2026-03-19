---
name: youtube-transcribe
description: Transcribe YouTube videos locally by downloading audio with yt-dlp and running Whisper. Use when the user provides a YouTube URL and wants offline transcripts (txt/srt/vtt/tsv/json) saved on disk.
metadata: {"openclaw":{"emoji":"🎧","requires":{"bins":["yt-dlp","ffmpeg","whisper","python3"]}}}
---

# YouTube Transcribe (Local)

## Overview

Download a YouTube video’s audio with `yt-dlp`, then run the Whisper CLI to produce transcripts. By default, outputs are organized per-video under:

`${HOME}/Documents/youtube-transcripts/<title> [id]/`

## Quick Start

```bash
{baseDir}/scripts/transcribe_youtube.sh "<YOUTUBE_URL>"
```

Defaults:

- Language: `zh`
- Task: `transcribe`
- Model: `small`
- Output format: `all`
- Output root: `${HOME}/Documents/youtube-transcripts`

## Options

```bash
{baseDir}/scripts/transcribe_youtube.sh "<YOUTUBE_URL>" \
  --lang zh|auto \
  --task transcribe|translate \
  --model tiny|base|small|medium|large|turbo \
  --format txt|srt|vtt|json|tsv|all \
  --out-dir "/path/to/output"
```

## Output Layout

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

## Notes

- Force `--no-playlist` to avoid downloading entire playlists by accident.
- Use `--lang auto` when the language is mixed or unknown.
- Default output is `all`, so Whisper keeps txt/srt/vtt/tsv/json together.
- Require `yt-dlp`, `ffmpeg`, `whisper`, and `python3` on `PATH`.

## Resources

### scripts/

- `transcribe_youtube.sh` — end-to-end download + transcribe pipeline.
