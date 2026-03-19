# Example output

This page shows a real example of the skill running on a public YouTube video.

## Example command

```bash
./skills/youtube-transcribe/scripts/transcribe_youtube.sh \
  "https://www.youtube.com/watch?v=vimU_EHAuAs" \
  --lang zh \
  --model small
```

## Example output structure

```text
${HOME}/Documents/youtube-transcripts/
  比特币现在下结论看大跌为时过早，回踩依旧可能大 [vimU_EHAuAs]/
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

## Transcript excerpt

Excerpt from `audio.txt`:

> 大家好,我是依依,現在是新加坡時間早上的8點42分  
> 比特幣限價位於7萬1000多,這個價格區域位置  
> 在過去的行情當中,我們都是以看漲為主  
> 在昨天的視頻當中,我們明確說明了智力選擇性可能回調  
> 還是說智力繼續開始下跌  
> 我們要關注周限級別能否站穩這個通道之上  
> 但是也關鍵的要位於這個72800需求其實點跌破  
> 說明結構已經轉空,我們發現從昨天的7萬4000多跌下來

## Notes

- The first Whisper run can take longer because the model may need to be downloaded first.
- CPU-only machines work fine, but transcription is slower than on GPU-backed setups.
- The exact wording in transcripts can vary a bit with model choice and language settings.
