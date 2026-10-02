app {
  url = "https://langfuse.com"
}

pack {
  name        = "langfuse"
  description = "Langfuse — open-source LLM engineering platform: tracing, evals, prompt management, and metrics for AI apps (an alternative to LangSmith). Deployed as an all-in-one host-networked Nomad job (PostgreSQL + ClickHouse + Redis + MinIO + web + worker). Needs a node with ~8 GB free RAM."
  url         = "https://github.com/Nomploy/nomad-packs/tree/main/packs/langfuse"
  version     = "0.1.0"
}
