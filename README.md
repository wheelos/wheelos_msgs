# wheelos_msgs

## Overview

`wheelos_msgs` is WheelOS's shared message-interface repository. It defines
Protocol Buffer schemas and Bazel targets for data exchanged by autonomous
driving modules.

The repository contains message packages for audio, basic data, chassis and
vehicle configuration, control, localization, maps, mission and routing,
monitoring, perception, planning, prediction, sensors, simulation, vehicle
drivers, transforms, V2X, and related runtime data. Bazel generates C++ and
Python protobuf targets from these schemas.

## Role in WheelOS

This repository provides the interface contracts that allow WheelOS modules to
integrate without sharing implementation code. It is a single Bazel module;
the message directories are Bazel packages within that module, not independent
modules.

```text
WheelOS
 |
+--- Runtime
     |
     +--- wheelos_msgs
```

The repository defines schemas and generated-language targets. It does not
contain autonomous-driving runtime nodes or algorithms.

## Architecture

```text
wheelos_msgs/<message_package>/*.proto
              |
              v
     proto_library (Bazel)
              |
       +------+------+
       |             |
       v             v
cc_proto_library  py_proto_library
       |             |
       v             v
 C++ generated    Python generated
 targets/headers  *_pb2 modules
       \             /
        \           /
         WheelOS module consumers
```

Each message package exposes package-level C++ and Python aggregate targets.
The root package also exposes `wheelos_msgs_cc_proto` and
`wheelos_msgs_py` aggregates for the complete repository.

## Installation

### Set up the build tools

The repository includes a script that installs the pinned Bazel version from
`.bazelversion` and Buildifier:

```shell
bash scripts/deploy/build.sh
```

### Build the generated message targets

```shell
bash scripts/build.sh
```

The equivalent direct Bazel command is:

```shell
bazel build //wheelos_msgs/...
```

### Build and install the Python wheel

Build the wheel with Bazel:

```shell
bazel build //:wheelos_msgs_wheel.dist
```

The wheel is written to `bazel-bin/wheelos_msgs_wheel_dist/`. Install the
published distribution with:

```shell
python3 -m pip install wheelos_msgs
```

The wheel requires Python 3.9 or newer and declares
`protobuf>=5.27.1,<6` as its runtime dependency.

## Examples

### Use generated targets from a Bazel consumer

In a consumer project's `MODULE.bazel`:

```starlark
bazel_dep(name = "wheelos_msgs", version = "0.1.5")
```

Depend on the public aggregate target in a `BUILD` file:

```starlark
cc_library(
    name = "demo_cc",
    deps = [
        "@wheelos_msgs//wheelos_msgs:audio_msgs_cc_proto",
    ],
)
```

For Python:

```starlark
py_library(
    name = "demo_py",
    deps = [
        "@wheelos_msgs//wheelos_msgs:audio_msgs_py",
    ],
)
```

### Import the installed Python package

```python
from wheelos_msgs.audio_msgs import audio_pb2
```

Individual generated targets are also available, for example
`@wheelos_msgs//wheelos_msgs/audio_msgs:audio_cc_proto` and
`@wheelos_msgs//wheelos_msgs/audio_msgs:audio_py_pb2`.

## Documentation

- [Bzlmod and Bazel design](docs/bzlmod-design.md): module layout, public
  targets, protobuf import paths, and compatibility guidance.
- [Python package and PyPI release](docs/python-release.md): wheel contents,
  local wheel inspection, versioning, and release workflow.
