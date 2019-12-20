load("@bazel_gazelle//:deps.bzl", "go_repository")

BASH_TEMPLATE = """
#! /usr/bin/env bash

exec {promtool} {command} {rules_paths} $@"""

def prometheus_alert_test_impl(ctx):
    # Arguments to call the test with.
    args = [f.path for f in ctx.files.srcs]

    promtool = ctx.executable._promtool

    ctx.actions.write(
        content = BASH_TEMPLATE.format(
            # TODO: If you use .short_path here then it works when bazel
            # testing. If you use .path then it works when you blaze build and
            # then execute it from the command line. There must be a way to
            # satisfy both but I can't figure it out right now.
            promtool = promtool.short_path,
            rules_paths = " ".join(args),
            command = ctx.attr.command,
        ),
        is_executable = True,
        output = ctx.outputs.executable,
    )

    return struct(
        runfiles = ctx.runfiles(
            files = [promtool] + ctx.files.srcs,
        ),
    )

"""Test that an alert is valid prometheus syntax.

Args:
  name: String; The name of the target
  srcs: Array<Label>; The list of targets to use as input
"""

promtool_command_test = rule(
    attrs = {
        "srcs": attr.label_list(allow_files = True),
        "_promtool": attr.label(
            executable = True,
            allow_files = True,
            cfg = "host",
            default = Label("@com_github_prometheus_prometheus//cmd/promtool"),
        ),
        "command": attr.string(default = "check rules"),
    },
    test = True,
    implementation = prometheus_alert_test_impl,
)

def prometheus_alert_test(name, srcs, **kwargs):
    promtool_command_test(
        name = name,
        srcs = srcs,
        **kwargs
    )

def prometheus_repositories(prometheus_version = "v2.6.0"):
    go_repository(
        name = "com_github_prometheus_prometheus",
        importpath = "github.com/prometheus/prometheus",
        tag = prometheus_version,
    )
