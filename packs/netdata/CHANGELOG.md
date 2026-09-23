# Changelog

## 0.1.0

- Initial release: Netdata (real-time per-second monitoring) as a host-networked Nomad service with
  SYS_PTRACE + apparmor=unconfined, read-only host mounts (/proc, /sys, /etc/os-release,
  docker.sock), persistent config/lib/cache volumes, and Nomad service discovery.
