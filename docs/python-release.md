# Python package and PyPI release

## Package naming

The Bazel module is named `wheelos_msgs`. The PyPI distribution and
generated Python import namespace are named `wheelos_msgs`:

```shell
python -m pip install wheelos_msgs
```

```python
from wheelos_msgs.audio_msgs import audio_pb2
```

The Bazel source package paths, protobuf import namespace, generated language
paths, and wheel package all use `wheelos_msgs`. No staging or path-mapping
rule is required.

## Build graph

`py_proto_library` generates Python protobuf code. Each message package has a
Python aggregate target, and `//wheelos_msgs:wheelos_msgs_py` collects every
message package. The root `BUILD` file uses `py_package` to select the
`wheelos_msgs` package and `py_wheel` to produce a pure-Python wheel.

The wheel declares the protobuf runtime requirement:

```text
protobuf>=5.27.1,<6
```

Because the protobuf import namespace changed from `common_msgs/...` to
`wheelos_msgs/...`, generated C++ headers also use `wheelos_msgs/...`. C++
consumers that include generated headers directly must update those include
paths and Bazel labels move to `@wheelos_msgs//wheelos_msgs:<target>`.

Do not commit generated `*_pb2.py` files. They are generated inputs to the
wheel and should be reproducible from the `.proto` sources and pinned Bazel
dependencies.

## Local build and inspection

Build the wheel:

```shell
bazel build //:wheelos_msgs_wheel.dist
```

The result is written to:

```text
bazel-bin/wheelos_msgs_wheel_dist/
```

Inspect metadata:

```shell
python -m pip install twine
twine check bazel-bin/wheelos_msgs_wheel_dist/*.whl
```

Install into a clean environment and test imports from outside the repository
root. Running from the repository root can accidentally import the source
directory instead of the installed wheel:

```shell
python -m venv /tmp/wheelos-common-msgs-venv
/tmp/wheelos-common-msgs-venv/bin/pip install \
  bazel-bin/wheelos_msgs_wheel_dist/*.whl
cd /tmp  # Leave the repository so its source tree cannot shadow the wheel.
/tmp/wheelos-common-msgs-venv/bin/python -c \
  "from wheelos_msgs.audio_msgs import audio_pb2; print(audio_pb2.AudioDetection)"
```

## Versioning

The release version currently appears in both `MODULE.bazel` and the root
`BUILD` wheel rule. A release tag must match both values:

```text
MODULE.bazel: version = "0.1.0"
BUILD:        version = "0.1.0"
Git tag:      v0.1.0
```

The release workflow rejects a tag when these versions differ. Update all
three locations together, then create the tag.

Use a patch/minor release only for compatible schema and API changes. Treat
removed proto files, removed fields, changed field semantics, changed import
paths, or removed public Bazel targets as a breaking release requiring an
explicit migration plan.

## Trusted Publishing

`.github/workflows/pypi-release.yml` publishes only for `v*` tags. It:

1. Checks out the repository.
2. Installs Bazelisk and Python.
3. Verifies the Git tag, module version, and wheel version match.
4. Builds all message targets and the wheel.
5. Runs `twine check`.
6. Publishes the wheel with `pypa/gh-action-pypi-publish` using OIDC.

Configure PyPI before the first release:

1. Create the `wheelos_msgs` project.
2. Add a Trusted Publisher for this GitHub repository and workflow file.
3. Configure the GitHub `pypi` environment.
4. Keep `id-token: write` enabled in the workflow.
5. Do not add a PyPI token to repository secrets or source files.

Release:

```shell
git tag v0.1.0
git push origin v0.1.0
```

For a dry run, build locally and upload to TestPyPI using a temporary
credential before publishing to the production index.
