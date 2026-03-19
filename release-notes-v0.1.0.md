## openclaw-youtube-transcribe v0.1.0

Initial public release of a small OpenClaw skill for turning a YouTube URL into local transcripts with `yt-dlp` + Whisper CLI.

### Included

- OpenClaw skill folder
- Local shell script for download + transcription
- Multi-format transcript outputs (`txt`, `srt`, `vtt`, `tsv`, `json`)
- English and Simplified Chinese documentation
- Example output pages
- SVG banner and social preview assets

### Defaults

- Language: `zh`
- Task: `transcribe`
- Model: `small`
- Output format: `all`
- Output root: `${HOME}/Documents/youtube-transcripts`

### Notes

- Uses `--no-playlist` to avoid accidental playlist downloads.
- First Whisper run may take longer due to model download.
- CPU-only runs are supported but slower than GPU-backed setups.
