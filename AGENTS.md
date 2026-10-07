# Agent Guide

## Rules

- Read relevant schemas, BUILD targets, and consumers before editing.
- Preserve protobuf field numbers, package names, and public target contracts.
- Keep changes scoped and preserve unrelated local work.
- Use existing Bazel targets and the approved build environment; do not install
  dependencies or change release versions without authorization.

## Entry points

- Workflows: [`.agents/skills/README.md`](.agents/skills/README.md)
- Durable knowledge: [`.agents/knowledge/README.md`](.agents/knowledge/README.md)
- Temporary investigations: [`.agents/notes/README.md`](.agents/notes/README.md)
- `.github/` owns CI and GitHub governance; keep shared agent rules here.

## Commands

- Build generated targets: `bazel build //wheelos_msgs/...`
- Build Python distribution: `bazel build //:wheelos_msgs_wheel.dist`

Run only the smallest relevant command. A build does not prove wire
compatibility or downstream acceptance.
