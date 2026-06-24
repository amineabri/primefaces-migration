# Assessment: PrimeFaces 14.0.0 To 15.0.16 Jakarta And EAP 8.1

Estimate the cost, time, effort, and risk for upgrading PrimeFaces from 14.0.0 to 15.0.16 with the Jakarta classifier and cutting over to JBoss EAP 8.1, Jakarta EE 10, and Java 21.

Do not change application files. The only allowed output is:

```text
aws-transform/eap-primefaces-modernization/reports/08-primefaces-15-jakarta-assessment.md
```

The report must include `## Estimate`, `## Cost`, `## QA Focus`, `## Risks And Blockers`, and `## Recommendation`.

Cost must use `AWS Transform cost = estimated agent minutes * 0.035`.

This is the only stage that should estimate JBoss, Jakarta, Java, Docker, descriptor, and namespace migration work.
