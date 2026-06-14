# common_msgs
common_msgs defines the messages required by the wheel system, including sensor messages and algorithms, etc.

# Bzlmod usage

In your consumer project's `MODULE.bazel`:

```starlark
bazel_dep(name = "wheelos_common_msgs", version = "0.1.2")
```

Then depend on targets directly in BUILD files, for example:

```starlark
cc_library(
    name = "demo_cc",
    deps = [
        "@wheelos_common_msgs//common_msgs/basic_msgs:header_cc_proto",
    ],
)

py_library(
    name = "demo_py",
    deps = [
        "@wheelos_common_msgs//common_msgs/basic_msgs:header_py_pb2",
    ],
)
```

# Quick start

## Environment
```shell
sudo bash scripts/deploy/build.sh
```

## Build
```shell
bash scripts/build.sh
```
