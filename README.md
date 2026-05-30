# bachsiem — SIEM Lab Evidence Bundle

Reproduzierbarkeits- und Integritäts-Bundle zum IU-Projektbericht **DLBCSEEISC02_D —
„Angriffs- und Einbruchserkennung mit SIEM-Systemen"** (Open-Source-SIEM aus Wazuh 4.9.2,
Suricata 7.0.15, Wazuh Indexer/Dashboard; 5 Angriffsszenarien, 21 Replays).

Lab-Session: `2026-05-15T102848Z` · UTC-Versuchsfenster `10:29:39Z`–`11:47:12Z`.
Die Artefakte stammen unverändert aus dem Lab; dieses Repository ist die im Bericht
referenzierte, öffentlich nachprüfbare Evidenz.

## Struktur

- `dashboards/` — 10 Wazuh-Dashboard-Screenshots (Security-Overview, Alerts-by-Rule,
  Top-Source-IPs, MITRE-ATT&CK-Heatmap, Alert-Timelines S1/S3/S5, Suricata-SIDs,
  Active-Response-Log, Agent-Overview).
- `data/` — Roh-/Auszugs-Artefakte:
  - Mess-Auswertung: `metrics.json`, `metrics.csv` (TP-Alerts, FPR, MTTD, AR-Quote, n=21)
  - Regeln/Config: `local_rules.xml`, `bachsiem.rules`, `ossec.conf.ar-snippet.xml`,
    `suricata.yaml.diff`, `docker-compose.yml`
  - Active Response: `bachsiem-ar-log.sh`, `active-responses.first8-triggers.log`,
    `active-responses.head200.log`
  - Roh-Auszüge (head): `wazuh-archives.head3.pretty.json` / `…head200.json`,
    `suricata-eve.head3.pretty.json` / `…head200.json`, `baseline.json`
  - `wordlist.txt` — Hydra-Brute-Force-Wortliste (S1; `weakpass` an Position 150)
- `evidence.sha256` — SHA-256-Prüfsummen aller Dateien (`sha256sum -c evidence.sha256`).

## Integrität prüfen

```bash
sha256sum -c evidence.sha256
```

Die im PDF (Anhang A.21) gelisteten SHA-256-Werte entsprechen den Dateien in diesem Repo.

## Hinweis

Die vollständigen Roh-Archive der Lab-Session (Wazuh-Archives ~210 MB, Suricata-EVE ~30 MB,
Active-Response-Log ~50 MB) werden aus Größengründen als repräsentative `head`-Auszüge
bereitgestellt; die Kennzahlen in `metrics.json`/`metrics.csv` sind aus den Vollständen
berechnet (`compute_metrics.py`). Keine personenbezogenen Daten; IPs sind RFC-1918-Lab-Adressen.
