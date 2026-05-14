# Homelab

Self-hosted services running on Docker Compose, reverse-proxied by Caddy with Cloudflare DNS-01 TLS.

## Services

| Service | URL | Purpose |
|---------|-----|---------|
| Caddy | — | Reverse proxy + automatic TLS via Cloudflare |
| Paperless-ngx | `paperless.home.adrianromberg.com` | Document management |
| ownCloud Infinite Scale | `owncloud.home.adrianromberg.com` | Cloud storage |
| Gramps Web | `famtree.home.adrianromberg.com` | Family tree |
| InfluxDB | `influx.home.adrianromberg.com` | Time-series database |
| Grafana | `grafana.home.adrianromberg.com` | Metrics dashboards |
| Jellyfin | `jellyfin.home.adrianromberg.com` | Media server |
| Radarr | `radarr.home.adrianromberg.com` | Movie management |
| Sonarr | `sonarr.home.adrianromberg.com` | TV management |
| Prowlarr | `prowlarr.home.adrianromberg.com` | Indexer management |
| Bazarr | `bazarr.home.adrianromberg.com` | Subtitle management |
| qBittorrent | `qbit.home.adrianromberg.com` | Torrent client (via Gluetun VPN) |
| macrofactor-influx | — | Syncs MacroFactor data to InfluxDB |

## Backups

Paperless and OCIS have systemd timer-based backup scripts (`backup.sh` + `.service`/`.timer`).
