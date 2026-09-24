app {
  url = "https://owntracks.org"
}

pack {
  name        = "owntracks-recorder"
  description = "OwnTracks Recorder — a self-hosted store and web map for your location history. The OwnTracks phone apps publish your positions to it (over HTTP), and you keep a private timeline of where you've been, queryable via a REST API and a built-in map. Deployed as a host-networked Nomad service (HTTP mode, no MQTT broker required) with a persistent data volume."
  url         = "https://github.com/Nomploy/nomad-packs/tree/main/packs/owntracks-recorder"
  version     = "0.1.0"
}
