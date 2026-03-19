# 示例输出

这一页展示的是一个**脱敏后的示例**，用于说明这个 skill 的输出结构，以及转写文本大概会长什么样。

## 示例命令

```bash
./skills/youtube-transcribe/scripts/transcribe_youtube.sh \
  "https://www.youtube.com/watch?v=EXAMPLE_ID" \
  --lang zh \
  --model small
```

## 示例输出结构

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

## 示例转写片段

摘自 `audio.txt`（仅为示意，不对应真实已处理视频内容）：

> 大家好，欢迎回来。  
> 这一段内容主要是按步骤说明核心观点。  
> 先回顾当前情况和几个关键前提。  
> 然后比较几种可能的走向以及它们各自的取舍。  
> 最后总结更实用的下一步行动。

## 说明

- 第一次运行 Whisper 可能会更慢，因为需要先下载模型。
- 纯 CPU 机器也能正常运行，只是速度会比 GPU 慢。
- 实际转写内容会随着视频、模型和语言参数不同而变化。
- 这里使用的是脱敏示例，而不是之前处理过的真实视频转写片段。
