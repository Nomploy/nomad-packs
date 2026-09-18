Excalidraw deployed as job "[[ var "job_name" . ]]" (host-networked on port [[ var "port" . ]]).

Open:      http://<node-ip>:[[ var "port" . ]]
Discovery: Nomad service "[[ var "job_name" . ]]" (provider=nomad)

Stateless — no volume. Drawings live in your browser's local storage (or export them). This
is the standalone whiteboard only; real-time collaboration needs the separate excalidraw
room/storage backends.
