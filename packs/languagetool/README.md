# languagetool

[LanguageTool](https://languagetool.org/) — a self-hosted **grammar, style and spell checker** for 25+ languages.
Run your own API endpoint and point the browser extensions, mobile keyboards, and editor integrations (LibreOffice,
Obsidian, Joplin, Nextcloud, …) at it, so your text never leaves your server.

Single **stateless** host-networked Nomad service (no volume). Exposes the LanguageTool HTTP API on `/v2/check`.

## Deploy

```sh
nomad-pack registry add nomploy https://github.com/Nomploy/nomad-packs
nomad-pack run languagetool --registry=nomploy
```

## Configure

| Variable | Default | Description |
| --- | --- | --- |
| `port` | `8010` | HTTP API port. Fixed at `8010` inside the image. |
| `java_xms` | `256m` | JVM initial heap size (`Java_Xms`). |
| `java_xmx` | `512m` | JVM maximum heap size (`Java_Xmx`). Keep below the task memory limit. |
| `image` | `erikvl87/languagetool:latest` | Container image. Pin a tag in production. |
| `resources` | `{ cpu = 500, memory = 768 }` | Task resources. The JVM needs headroom above `java_xmx`. |

> **Better suggestions (optional):** mount an [n-gram dataset](https://dev.languagetool.org/finding-errors-using-n-gram-data)
> at `/ngrams` and set `langtool_languageModel=/ngrams` to catch confused words (there/their). This needs several GB of
> disk — add the volume and env to the task if you want it. The base service is stateless and needs no storage.
