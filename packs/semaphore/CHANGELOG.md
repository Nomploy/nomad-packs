# Changelog

## 0.1.0

- Initial release: Semaphore UI (web UI for Ansible/Terraform/OpenTofu/scripts) as a host-networked
  Nomad service using the embedded BoltDB with persistent data (/var/lib/semaphore) and config
  (/etc/semaphore) volumes, admin bootstrap + access-key encryption via env, and Nomad service discovery.
