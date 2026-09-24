Whisper ASR Webservice deployed as job "[[ var "job_name" . ]]" (host-networked on port [[ var "port" . ]]).

API docs:  http://<node-ip>:[[ var "port" . ]]/docs
Transcribe: curl -F "audio_file=@sample.mp3" "http://<node-ip>:[[ var "port" . ]]/asr?output=txt"
Discovery: Nomad service "[[ var "job_name" . ]]" (provider=nomad)
Cache:     Docker volume "[[ var "cache_volume" . ]]" (/root/.cache) — downloaded model

First boot downloads the "[[ var "asr_model" . ]]" model (needs internet). Larger models are far more
accurate but much heavier — size the resources accordingly, and use a GPU image/runtime for real speed.
Runs fully on your hardware. The API is unauthenticated — keep it internal or front it with a proxy.
