git_repository(
    name = "io_bazel_rules_go",
    remote = "https://github.com/bazelbuild/rules_go.git",
    tag = "0.2.0",
)
load("@io_bazel_rules_go//go:def.bzl", "go_repositories")

go_repositories()

load("//prometheus:def.bzl", "prometheus_repositories")

prometheus_repositories()
