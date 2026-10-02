# wekan

[WeKan](https://wekan.github.io) is an open-source kanban board — a self-hosted
alternative to Trello. It offers boards with swimlanes and lists, cards with
checklists, labels, due dates, attachments and comments, role-based sharing,
rules/automation, and import from Trello, all running on your own server.

This pack deploys WeKan **all-in-one** as a single host-networked Nomad job:
**MongoDB** (bundled as a prestart sidecar) plus the WeKan app.

## Deploy

```bash
nomad-pack run wekan --registry=nomploy --var root_url=https://boards.example.com
```

Open `http://<node-ip>:8080` and register the first account.

## Configuration

| Variable      | Default                    | Description                                   |
| ------------- | -------------------------- | --------------------------------------------- |
| `image`       | `ghcr.io/wekan/wekan:latest`| App image (pin a tag in production).            |
| `mongo_image` | `mongo:7.0`                | Bundled MongoDB (needs AVX for 5.0+).          |
| `port`        | `8080`                     | Host port for the web UI.                      |
| `mongo_port`  | `27017`                    | Host port for MongoDB.                         |
| `root_url`    | `http://localhost:8080`    | **Public URL** used in generated links/emails. |
| `data_volume` | `wekan_data`               | Volume for uploads/attachments (`/data`).      |
| `resources`   | 1000 MHz / 1536 MB         | App resources (Meteor/Node wants memory).      |

Boards and data persist in MongoDB (`mongo_data_volume`); uploaded files in
`data_volume`. Set `root_url` to the exact address users reach WeKan at.
