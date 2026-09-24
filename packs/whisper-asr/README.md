# whisper-asr

[Whisper ASR Webservice](https://ahmetoner.com/whisper-asr-webservice/) — a self-hosted speech-to-text API
powered by OpenAI's **Whisper**. Transcribe or translate audio to text over a simple HTTP endpoint, running
entirely on your own hardware (great for subtitles, voice notes, and pipelines that shouldn't leave your
network).

Single host-networked Nomad service with a persistent model-cache volume.

## Deploy

```sh
nomad-pack registry add nomploy https://github.com/Nomploy/nomad-packs
nomad-pack run whisper-asr --registry=nomploy
```

## Configure

| Variable | Default | Description |
| --- | --- | --- |
| `port` | `9000` | HTTP API port. The container listens on 9000. |
| `asr_model` | `base` | Whisper model (`ASR_MODEL`): `tiny`/`base`/`small`/`medium`/`large-v3`. Bigger = more accurate, slower, heavier. |
| `asr_engine` | `faster_whisper` | Engine (`ASR_ENGINE`): `openai_whisper`, `faster_whisper`, `whisperx`. |
| `cache_volume` | `whisper_cache` | `/root/.cache` — downloaded model cache. |
| `image` | `onerahmet/openai-whisper-asr-webservice:latest` | Container image. Pin a tag in production. |
| `resources` | `{ cpu = 2000, memory = 2048 }` | Task resources. Larger models need much more. |

Transcribe with `curl -F "audio_file=@sample.mp3" "http://<node-ip>:9000/asr?output=txt"`; interactive docs
at `/docs`. **First boot downloads the model** (needs internet). For real-time speed on big models use a
GPU image/runtime. The API is unauthenticated — keep it internal or front it with a proxy. Pin the job to
the node holding the volume with `constraints`.
