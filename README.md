# wheelos_msgs
wheelos_msgs defines the messages required by WheelOS, including
sensor messages and algorithms, etc.

Design and release documentation:

- [Bzlmod and Bazel design](docs/bzlmod-design.md)
- [Python package and PyPI release](docs/python-release.md)

# Bzlmod usage

In your consumer project's `MODULE.bazel`:

```starlark
bazel_dep(name = "wheelos_msgs", version = "0.1.0")
```

Each message directory is a normal Bazel package in the single
`wheelos_msgs`
module. Depend on targets directly in BUILD files, for example:

```starlark
cc_library(
    name = "demo_cc",
    deps = [
        "@wheelos_msgs//wheelos_msgs:audio_msgs_cc_proto",
    ],
)

py_library(
    name = "demo_py",
    deps = [
        "@wheelos_msgs//wheelos_msgs:audio_msgs_py",
    ],
)
```

Package-level aggregate targets are also available:

```text
@wheelos_msgs//wheelos_msgs:audio_msgs_cc_proto
@wheelos_msgs//wheelos_msgs:audio_msgs_py
@wheelos_msgs//wheelos_msgs:wheelos_msgs_cc_proto
@wheelos_msgs//wheelos_msgs:wheelos_msgs_py
```

For a message package, consumers can use either its aggregate targets or
individual generated targets:

```text
@wheelos_msgs//wheelos_msgs/audio_msgs:audio_msgs_cc_proto
@wheelos_msgs//wheelos_msgs/audio_msgs:audio_msgs_py
@wheelos_msgs//wheelos_msgs/audio_msgs:audio_cc_proto
@wheelos_msgs//wheelos_msgs/audio_msgs:audio_py_pb2
```

# Python wheel

The wheel contains all generated `*_pb2.py` files and installs them under the
`wheelos_msgs.*` import namespace. The Bazel module and PyPI distribution use
the same `wheelos_msgs` name:

```shell
bazel build //:wheelos_msgs_wheel.dist
```

The wheel is written to `bazel-bin/wheelos_msgs_wheel_dist/`. Install the
published package with:

```shell
python3 -m pip install wheelos_msgs
cd /tmp
python3 -c "from wheelos_msgs.audio_msgs import audio_pb2"
```

Publishing is performed by `.github/workflows/pypi-release.yml` for `v*` tags
using PyPI Trusted Publishing. Configure the repository's `pypi` environment
and trusted publisher in PyPI before creating a release tag.

# Quick start

## Environment
```shell
sudo bash scripts/deploy/build.sh
```

## Build
```shell
bash scripts/build.sh
```
