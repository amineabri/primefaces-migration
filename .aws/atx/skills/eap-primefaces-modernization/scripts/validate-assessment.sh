#!/usr/bin/env bash
set -euo pipefail

fail() {
  echo "ERROR: $1" >&2
  exit 1
}

if [ "$#" -eq 0 ]; then
  set -- "aws-transform/eap-primefaces-modernization/reports/assessment.md"
fi

for report in "$@"; do
  test -f "$report" || fail "assessment report was not created at $report"

  grep -q "## Estimate" "$report" || fail "estimate section missing in $report"
  grep -q "## Cost" "$report" || fail "cost section missing in $report"
  grep -q "0.035" "$report" || fail "agent-minute price missing in $report"
  grep -qi "agent minute" "$report" || fail "agent-minute cost explanation missing in $report"
  grep -q "## Risks And Blockers" "$report" || fail "risks section missing in $report"
done

echo "Assessment report validation checks passed."
