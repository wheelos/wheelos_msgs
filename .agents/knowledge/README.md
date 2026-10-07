# Repository Knowledge

## Scope

`wheelos_msgs` owns shared protobuf schemas and generated C++/Python targets,
not runtime algorithms. Message directories are Bazel packages in one module.
Preserve schema compatibility and public consumer labels during changes.

## Evidence

- `MODULE.bazel`: module identity and protobuf/toolchain dependencies.
- `README.md`: schema ownership, aggregate targets, and packaging.
- `wheelos_msgs/`: schemas and their nearest BUILD declarations.

Add narrow, source-backed topics here and index them in this file. Procedures
belong in `../skills/`; unverified investigations belong in ignored `../notes/`.
Revisit these facts when module boundaries or generated-language targets change.
