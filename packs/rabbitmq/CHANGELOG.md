# Changelog

## 0.1.0

- Initial release: RabbitMQ (with the management plugin) as a host-networked Nomad
  service. Persistent named volume for /var/lib/rabbitmq, a pinned node name
  (rabbit@localhost) so the Mnesia data dir survives reschedules, configurable AMQP and
  management ports plus a bootstrap admin user via a rendered rabbitmq.conf, and Nomad
  service discovery for both endpoints.
