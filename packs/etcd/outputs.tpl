etcd deployed as job "[[ var "job_name" . ]]" (single node, host-networked).

Client API: http://<node-ip>:[[ var "client_port" . ]]  (advertised as [[ var "advertise_host" . ]]:[[ var "client_port" . ]])
Discovery:  Nomad service "[[ var "job_name" . ]]" (provider=nomad)

Use it with etcdctl (bundled in the image):
  nomad alloc exec -task etcd <alloc> etcdctl put mykey myvalue
  nomad alloc exec -task etcd <alloc> etcdctl get mykey

Set advertise_host to the node's IP for remote clients (127.0.0.1 only serves co-located clients).
This is a single node with no auth — restrict it to a trusted network. Data lives on the
[[ var "data_volume" . ]] volume (/etcd-data); pin the job to that node with the constraints variable.
