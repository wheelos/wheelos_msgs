---
name: schema-development
description: Change WheelOS protobuf schemas and validate generated C++/Python targets without breaking consumer contracts.
---

# Schema Development

## When and prerequisites

Use for schema or generated-target changes. Read `AGENTS.md`, affected proto
and BUILD files, and consumer usage. Preserve local work.

## Steps

1. Inspect field numbers, types, package names, and compatibility expectations.
   Never reuse removed field numbers; reserve removed names/numbers when needed.
2. Update schemas and explicit target dependencies, not generated outputs.
3. Build the affected declared targets in the approved environment. For a
   repository-wide generated-target check, use `bazel build //wheelos_msgs/...`.
4. Validate affected consumers and compatibility expectations. For packaging
   changes, build `bazel build //:wheelos_msgs_wheel.dist`.

## Acceptance and failures

Required generated-language targets build, and affected consumers retain their
contracts. Build success alone is not wire-compatibility evidence.
Stop on the first actionable error; ask before introducing incompatible schema
changes, changing versions, installing tools, or publishing artifacts.
