# openclaw-youtube-transcribe

一个用于 **OpenClaw** 的小技能：把 YouTube 视频链接通过 `yt-dlp` + 本地 `Whisper CLI` 转成离线转写文本。

English version: [README.md](./README.md)

## 功能特点

- 下载单个 YouTube 视频的音频
- 提取/转码为 `m4a`
- 使用本地 Whisper 做语音转文字
- 一次保留 `txt`、`srt`、`vtt`、`tsv`、`json` 多种输出格式
- 每个视频独立存放到自己的目录
- 本质是一个简单 shell 脚本，脱离 OpenClaw 也能单独使用

## 默认输出目录

```text
${HOME}/Documents/youtube-transcripts
```

输出结构：

```text
${HOME}/Documents/youtube-transcripts/
  <标题> [id]/
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

## 依赖

脚本要求这些命令在 `PATH` 中可用：

- `yt-dlp`
- `ffmpeg`
- `whisper`
- `python3`

macOS + Homebrew 示例：

```bash
brew install yt-dlp ffmpeg openai-whisper
```

## 快速开始

直接运行：

```bash
./skills/youtube-transcribe/scripts/transcribe_youtube.sh "https://www.youtube.com/watch?v=..."
```

可选参数：

```bash
./skills/youtube-transcribe/scripts/transcribe_youtube.sh "<YOUTUBE_URL>" \
  --lang zh|auto \
  --task transcribe|translate \
  --model tiny|base|small|medium|large|turbo \
  --format txt|srt|vtt|json|tsv|all \
  --out-dir "/path/to/output"
```

默认值：

- `--lang zh`
- `--task transcribe`
- `--model small`
- `--format all`

## 作为 OpenClaw skill 使用

把 `skills/youtube-transcribe` 复制或软链接到 OpenClaw 工作区的 `skills/` 目录里。

示例：

```bash
mkdir -p /path/to/workspace/skills
cp -R ./skills/youtube-transcribe /path/to/workspace/skills/
```

然后重新开启一个新的 OpenClaw 会话，让 skill 被干净地加载进去。

## 示例命令

```bash
./skills/youtube-transcribe/scripts/transcribe_youtube.sh \
  "https://www.youtube.com/watch?v=vimU_EHAuAs" \
  --lang zh \
  --model small
```

可以直接看真实样例输出：

- [examples/example-output.md](./examples/example-output.md)
- [examples/example-output.zh-CN.md](./examples/example-output.zh-CN.md)

## 说明

- 脚本强制使用 `--no-playlist`，避免误下载整个播放列表。
- 如果视频语言不确定或中英混杂，建议使用 `--lang auto`。
- 第一次运行 Whisper 可能会比较慢，因为需要先下载模型。
- 纯 CPU 也能跑，只是速度会比 GPU 慢一些。
- 这个项目刻意保持简单、本地优先，而不是追求非常复杂的优化。

## 仓库结构

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
