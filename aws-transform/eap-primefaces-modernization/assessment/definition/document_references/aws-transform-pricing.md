# AWS Transform Pricing Reference

Use this reference for the Phase 1 assessment cost section.

As of 2026-06-24, AWS Transform custom transformation pricing is:

```text
USD 0.035 per agent minute
```

Source:

```text
https://aws.amazon.com/transform/pricing/
```

Agent minutes represent active agent work during transformation tasks. Local builds, local file reads, and user idle time are not charged as agent minutes.

The assessment report must estimate Phase 2 migration cost with this formula:

```text
estimated migration cost = estimated Phase 2 migration agent minutes * 0.035
```

If AWS publishes a different price during execution, use the current published AWS price and note the date checked.
