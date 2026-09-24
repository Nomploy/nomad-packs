app {
  url = "https://github.com/kieraneglin/pinchflat"
}

pack {
  name        = "pinchflat"
  description = "Pinchflat — a self-hosted YouTube media manager: subscribe to channels or playlists and it automatically downloads new videos with yt-dlp, organizes them, and can serve podcast-style RSS feeds. Deployed as a host-networked Nomad service using SQLite with config and downloads volumes."
  url         = "https://github.com/Nomploy/nomad-packs/tree/main/packs/pinchflat"
  version     = "0.1.0"
}
