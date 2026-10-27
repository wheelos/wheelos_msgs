load("@rules_python//python:packaging.bzl", "py_package", "py_wheel")

alias(
    name = "buildifier",
    actual = "@buildifier_prebuilt//:buildifier",
)

py_package(
    name = "wheelos_msgs_python_package",
    packages = ["wheelos_msgs"],
    deps = ["//wheelos_msgs:wheelos_msgs_py"],
)

py_wheel(
    name = "wheelos_msgs_wheel",
    abi = "none",
    distribution = "wheelos_msgs",
    platform = "any",
    python_requires = ">=3.9",
    python_tag = "py3",
    requires = ["protobuf>=5.27.1,<6"],
    version = "0.1.6",
    deps = [":wheelos_msgs_python_package"],
)
