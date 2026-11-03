# AWS Transform Repository Artifact Inventory

## Assessment Result

The repository contains nine prior Markdown assessment/report files. These are treated as the primary output-format and estimate references. No prior HTML, JSON, CSV, XLSX, log, or assessment execution metadata file was found under the repository. Files under assessment/migration definitions and configuration directories are workflow inputs, not evidence that a transformation was executed. No original AWS Transform artefact was modified.

## Prior Assessment Output Reports

| Artifact | Type | Assessment use |
|---|---|---|
| `aws-transform/eap-primefaces-modernization/reports/01-primefaces-7-assessment.md` | Stage assessment Markdown | Section ordering, scope, estimate, cost, risk/blocker, QA focus, recommendation |
| `aws-transform/eap-primefaces-modernization/reports/02-primefaces-8-assessment.md` | Stage assessment Markdown | Stage profile, agent-work breakdown, estimate and QA |
| `aws-transform/eap-primefaces-modernization/reports/03-primefaces-10-assessment.md` | Stage assessment Markdown | Project profile, rationale, risk, QA and recommendation |
| `aws-transform/eap-primefaces-modernization/reports/04-primefaces-11-assessment.md` | Stage assessment Markdown | Estimate, risk, QA and recommendation |
| `aws-transform/eap-primefaces-modernization/reports/05-primefaces-12-assessment.md` | Stage assessment Markdown | Estimate, component impact, risks and QA |
| `aws-transform/eap-primefaces-modernization/reports/06-primefaces-13-assessment.md` | Stage assessment Markdown | Project inventory, breaking/deprecated changes, effort and blockers |
| `aws-transform/eap-primefaces-modernization/reports/07-primefaces-14-assessment.md` | Stage assessment Markdown | Component inventory, repository-specific changes, agent/human/QA/calendar effort |
| `aws-transform/eap-primefaces-modernization/reports/08-primefaces-15-jakarta-assessment.md` | Stage assessment Markdown | Jakarta, EAP, Java and PF target changes; risk, blockers, effort and QA |
| `aws-transform/eap-primefaces-modernization/reports/product-delivery-assessment.md` | Aggregate delivery Markdown | Aggregate best/expected/high estimates, stage breakdown, duration and QA plan |

These reports were inspected before preparing the new artefacts. Their structural conventions and numerical estimates informed this assessment, but claims were checked against present source files and are identified as historic estimates where appropriate.

## Workflow Inputs and Supporting Assets

The following 39 substantive non-report files are also present under `aws-transform/`. They describe the assessment/migration workflow, configuration, target facts and transformation instructions; they are not generated execution output.

| Group | Inventory |
|---|---|
| Workflow documentation | `aws-transform/eap-primefaces-modernization/README.md`; `aws-transform/eap-primefaces-modernization/assessment/README.md`; `aws-transform/eap-primefaces-modernization/migration/README.md` |
| Consolidated assessment | `aws-transform/eap-primefaces-modernization/assessment/config.yaml`; `aws-transform/eap-primefaces-modernization/assessment/definition/transformation_definition.md`; `aws-transform/eap-primefaces-modernization/assessment/definition/document_references/aws-transform-pricing.md`; `aws-transform/eap-primefaces-modernization/assessment/definition/document_references/current-project-facts.md` |
| Eight staged assessment configs | `assessment/01-primefaces-7/config.yaml`; `assessment/02-primefaces-8/config.yaml`; `assessment/03-primefaces-10/config.yaml`; `assessment/04-primefaces-11/config.yaml`; `assessment/05-primefaces-12/config.yaml`; `assessment/06-primefaces-13/config.yaml`; `assessment/07-primefaces-14/config.yaml`; `assessment/08-primefaces-15-jakarta/config.yaml` (all paths are relative to `aws-transform/eap-primefaces-modernization/`) |
| Eight staged assessment definitions | `assessment/01-primefaces-7/definition/transformation_definition.md`; `assessment/02-primefaces-8/definition/transformation_definition.md`; `assessment/03-primefaces-10/definition/transformation_definition.md`; `assessment/04-primefaces-11/definition/transformation_definition.md`; `assessment/05-primefaces-12/definition/transformation_definition.md`; `assessment/06-primefaces-13/definition/transformation_definition.md`; `assessment/07-primefaces-14/definition/transformation_definition.md`; `assessment/08-primefaces-15-jakarta/definition/transformation_definition.md` |
| Eight staged migration configs | `migration/01-primefaces-7/config.yaml`; `migration/02-primefaces-8/config.yaml`; `migration/03-primefaces-10/config.yaml`; `migration/04-primefaces-11/config.yaml`; `migration/05-primefaces-12/config.yaml`; `migration/06-primefaces-13/config.yaml`; `migration/07-primefaces-14/config.yaml`; `migration/08-primefaces-15-jakarta/config.yaml` |
| Eight staged migration definitions | `migration/01-primefaces-7/definition/transformation_definition.md`; `migration/02-primefaces-8/definition/transformation_definition.md`; `migration/03-primefaces-10/definition/transformation_definition.md`; `migration/04-primefaces-11/definition/transformation_definition.md`; `migration/05-primefaces-12/definition/transformation_definition.md`; `migration/06-primefaces-13/definition/transformation_definition.md`; `migration/07-primefaces-14/definition/transformation_definition.md`; `migration/08-primefaces-15-jakarta/definition/transformation_definition.md` |

The ten entries in the reports directory consist of the nine Markdown reports above plus `.gitkeep`. Total files under `aws-transform/` at inventory time: **49** (39 workflow/support files, 9 Markdown reports, and 1 `.gitkeep`).

## Assessment Reference Conventions Applied

The prior reports commonly order content as scope/project profile → estimate/rationale → cost → risks/blockers → QA focus → recommendation. The new primary report retains an executive summary and inventory while adding the requested compatibility/API/namespace/runtime/readiness sections. The effort report distinguishes human engineering, agent minutes, and calendar days, instead of treating them as one measure. Older findings were not accepted without rechecking repository evidence.
