#!/bin/bash
# Wazuh active-response wrapper that records each trigger with the source IP
# and a verification probe result, so compute_metrics.py can count mitigation
# successes vs failures.
set -uo pipefail
LOG=/var/ossec/logs/bachsiem-ar.log
read -r INPUT
SRCIP=$(echo "$INPUT" | jq -r '.parameters.alert.data.srcip // empty')
RID=$(echo "$INPUT"   | jq -r '.parameters.alert.rule.id  // empty')
TS=$(date -u +%Y-%m-%dT%H:%M:%S.%3NZ)

# Probe: can we still reach SSH from the dropped IP? (timeout 3s)
if [ -n "$SRCIP" ]; then
  timeout 3 bash -c "</dev/tcp/$SRCIP/22" 2>/dev/null
  PROBE=$?
else
  PROBE=-1
fi

# probe rc != 0 means the drop is effective => mitigation success
if [ "$PROBE" -ne 0 ]; then SUCCESS=1; else SUCCESS=0; fi

echo "{\"ts\":\"$TS\",\"rule\":\"$RID\",\"srcip\":\"$SRCIP\",\"success\":$SUCCESS}" >> "$LOG"
exit 0
