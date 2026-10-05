Isso deployed as job "[[ var "job_name" . ]]" (host-networked on port [[ var "port" . ]]).

API:       http://<node-ip>:[[ var "port" . ]]
Discovery: Nomad service "[[ var "job_name" . ]]" (provider=nomad)

Isso stores comments in SQLite inside the isso_data volume. Set `host` to the URL of the
site where you embed comments — Isso only accepts comments whose referrer matches, so the
default (http://localhost) must be changed for a real site.

Embed on your pages with:
  <script data-isso="http://<node-ip>:[[ var "port" . ]]/" src="http://<node-ip>:[[ var "port" . ]]/js/embed.min.js"></script>
  <section id="isso-thread"></section>

Put Isso behind a reverse proxy on the same domain as your site for best results. See the
Isso docs for moderation, email notifications and admin login (set an admin password via
the [admin] section).
