# solr

[Apache Solr](https://solr.apache.org) is a fast, mature open-source search
platform built on Apache Lucene. It powers full-text search, hit highlighting,
faceted navigation, geospatial search, clustering and rich-document indexing,
all administered through a clean web UI and a comprehensive REST API.

This pack runs a single Solr server as a host-networked Nomad service.

## Deploy

```bash
nomad-pack run solr --registry=nomploy
```

Open `http://<node-ip>:8983/solr/`. Create your first core from the UI or:

```bash
curl "http://<node-ip>:8983/solr/admin/cores?action=CREATE&name=mycore&configSet=_default"
```

## Configuration

| Variable      | Default      | Description                                  |
| ------------- | ------------ | -------------------------------------------- |
| `image`       | `solr:9`     | Container image (pin a tag in production).      |
| `port`        | `8983`       | Host port for the server / admin UI.          |
| `data_volume` | `solr_data`  | Volume for cores and index data (`/var/solr`).|
| `resources`   | 1000 MHz / 1024 MB | CPU and memory for the task.            |

Cores and index data persist in `data_volume`. For heavy indexing, raise the
memory and consider setting the Solr heap via `SOLR_HEAP`.
