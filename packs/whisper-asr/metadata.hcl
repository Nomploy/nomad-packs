app {
  url = "https://ahmetoner.com/whisper-asr-webservice/"
}

pack {
  name        = "whisper-asr"
  description = "Whisper ASR Webservice — a self-hosted speech-to-text API powered by OpenAI's Whisper. Transcribe or translate audio to text over a simple HTTP endpoint, entirely on your own hardware. Deployed as a host-networked Nomad service with a persistent model-cache volume."
  url         = "https://github.com/Nomploy/nomad-packs/tree/main/packs/whisper-asr"
  version     = "0.1.0"
}
