# Example output

This page shows a **sanitized example** of how the skill organizes files and what a transcript output may look like.

## Example command

```bash
./skills/youtube-transcribe/scripts/transcribe_youtube.sh \
  "https://www.youtube.com/watch?v=EXAMPLE_ID" \
  --lang zh \
  --model small
```

## Example output structure

```text
${HOME}/Documents/youtube-transcripts/
  Example Video Title [EXAMPLE_ID]/
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

## Example transcript excerpt

Excerpt from `audio.txt` (illustrative only):

> Hello everyone, welcome back.  
> In this video we walk through the main idea step by step.  
> First, let's review the current situation and key assumptions.  
> Then we compare a few possible outcomes and their trade-offs.  
> Finally, we summarize the most practical next actions.

## Notes

- The first Whisper run can take longer because the model may need to be downloaded first.
- CPU-only machines work fine, but transcription is slower than on GPU-backed setups.
- Exact wording varies by video, model, and language settings.
- This page uses a sanitized sample instead of a real transcript excerpt from a previously processed video.
