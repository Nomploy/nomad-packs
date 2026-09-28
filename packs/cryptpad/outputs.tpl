CryptPad deployed as job "[[ var "job_name" . ]]" (host-networked).

Main app:  http://<node-ip>:[[ var "port" . ]]
Sandbox:   http://<node-ip>:[[ var "sandbox_port" . ]]   (must be a different origin)
Discovery: Nomad service "[[ var "job_name" . ]]" (provider=nomad)

The FIRST account you register can be made the instance admin (add its public key
under admin settings). For security CryptPad needs the sandbox on a DIFFERENT
origin from the main app — set main_domain and sandbox_domain to two distinct
hosts/ports and put both behind your proxy. Everything is end-to-end encrypted, so
the server only ever stores ciphertext. Data persists across the mounted volumes.
