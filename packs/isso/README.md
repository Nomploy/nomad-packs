# isso

[Isso](https://isso-comments.de) is a lightweight, self-hosted **commenting server** — a
Disqus alternative you embed on your blog or static site. Threaded comments, Markdown,
moderation and email notifications, with no tracking and no third parties.

This pack runs Isso as a single host-networked Nomad job with SQLite storage (in the
`isso_data` volume) and a seeded config — no external database is required.

## Quick start

```sh
nomad-pack run isso --registry=nomploy --var host=https://blog.example.com
```

Then embed it on your pages:

```html
<script data-isso="http://<node-ip>:8080/"
        src="http://<node-ip>:8080/js/embed.min.js"></script>
<section id="isso-thread"></section>
```

## Configuration

| Variable | Default | Notes |
|----------|---------|-------|
| `port` | `8080` | API host port |
| `host` | `http://localhost` | **Set this** to your site's URL — Isso only accepts comments from matching origins |
| `data_volume` | `isso_data` | SQLite comments database |

Set `host` to the public URL of the site where comments are embedded; the default won't
accept comments from a real site. For moderation, admin login and email notifications,
extend the rendered config per the [Isso docs](https://isso-comments.de/docs/).

Ideally serve Isso behind a reverse proxy on the same domain as your site.
