#!/usr/bin/env bash
set -euo pipefail

report="aws-transform/eap-primefaces-modernization/reports/assessment.md"

fail() {
  echo "ERROR: $1" >&2
  exit 1
}

test -f "$report" || fail "assessment report was not created at $report"

grep -q "# EAP And PrimeFaces Modernization Assessment" "$report" || fail "assessment report title missing"
grep -q "## Estimate" "$report" || fail "estimate section missing"
grep -q "## Cost" "$report" || fail "cost section missing"
grep -q "## Risks And Blockers" "$report" || fail "risks section missing"
grep -q "## Go / No-Go" "$report" || fail "go/no-go section missing"

echo "Assessment report validation checks passed."
