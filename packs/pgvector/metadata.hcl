app {
  url = "https://github.com/pgvector/pgvector"
}

pack {
  name        = "pgvector"
  description = "PostgreSQL + pgvector — a ready-to-use PostgreSQL server with the pgvector extension for storing embeddings and running vector similarity search right in your relational database. Ideal as the retrieval store for RAG and semantic search. Deployed as a host-networked Nomad service with a persistent data volume."
  url         = "https://github.com/Nomploy/nomad-packs/tree/main/packs/pgvector"
  version     = "0.1.0"
}
