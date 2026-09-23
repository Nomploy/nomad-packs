app {
  url = "https://docs.litellm.ai"
}

pack {
  name        = "litellm"
  description = "LiteLLM — an LLM gateway/proxy that exposes 100+ providers (OpenAI, Anthropic, Ollama, and more) behind one OpenAI-compatible API, with a master key, routing, and usage tracking. Deployed as a stateless host-networked Nomad service with a rendered config; pre-wired to the ollama pack."
  url         = "https://github.com/Nomploy/nomad-packs/tree/main/packs/litellm"
  version     = "0.1.0"
}
