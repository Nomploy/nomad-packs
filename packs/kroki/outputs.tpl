Kroki deployed as job "[[ var "job_name" . ]]" (stateless, host-networked on port [[ var "port" . ]]).

API:       http://<node-ip>:[[ var "port" . ]]
Discovery: Nomad service "[[ var "job_name" . ]]" (provider=nomad)

Render a diagram (GET with a deflate+base64 payload, or POST the source):
  curl http://<node-ip>:[[ var "port" . ]]/graphviz/svg -d 'digraph { a -> b }'

Point your wiki/docs at this endpoint (docmost, wiki.js, hedgedoc all support a Kroki server URL).
The core image covers PlantUML, Graphviz, Mermaid, and more; some formats (BPMN, Excalidraw) need
their companion containers — add them if you use those. Stateless — no volume.
