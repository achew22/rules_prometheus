load("@bazel_gazelle//:deps.bzl", "go_repository")

BASH_TEMPLATE = """
#! /usr/bin/env bash

exec {promtool} check-rules {rules_paths} $@ """

def prometheus_alert_test_impl(ctx):
    # Arguments to call the test with.
    args = [f.path for f in ctx.files.srcs]

    promtool = ctx.executable._promtool

    ctx.file_action(
        content = BASH_TEMPLATE.format(
            # TODO: If you use .short_path here then it works when bazel
            # testing. If you use .path then it works when you blaze build and
            # then execute it from the command line. There must be a way to
            # satisfy both but I can't figure it out right now.
            promtool = promtool.short_path,
            rules_paths = " ".join(args),
        ),
        executable = True,
        output = ctx.outputs.executable,
    )

    return struct(
        runfiles = ctx.runfiles(
            files = [promtool] + ctx.files.srcs,
        )
    )

"""Test that an alert is valid prometheus syntax.

Args:
  name: String; The name of the target
  srcs: Array<Label>; The list of targets to use as input
"""

prometheus_alert_test = rule(
    attrs = {
        "srcs": attr.label_list(allow_files = True),
        "_promtool": attr.label(
            executable = True,
            allow_files = True,
            cfg = "host",
            default = Label("@com_github_prometheus_prometheus//cmd/promtool"),
        ),
    },
    test = True,
    implementation = prometheus_alert_test_impl,
)

def prometheus_repositories():
    go_repository(
        name = "com_github_prometheus_prometheus",
        importpath = "github.com/prometheus/prometheus",
        tag = "v1.4.1"
    )

    go_repository(
        name = "com_github_prometheus_common",
        importpath = "github.com/prometheus/common",
        commit = "85637ea67b04b5c3bb25e671dacded2977f8f9f6"
    )

    go_repository(
        name = "com_github_prometheus_client_model",
        importpath = "github.com/prometheus/client_model",
        commit = "fa8ad6fec33561be4280a8f0514318c79d7f6cb6"
    )

    go_repository(
        name = "com_github_prometheus_client_golang",
        importpath = "github.com/prometheus/client_golang",
        tag = "v0.8.0"
    )

    go_repository(
        name = "com_github_prometheus_procfs",
        importpath = "github.com/prometheus/procfs",
        commit = "abf152e5f3e97f2fafac028d2cc06c1feb87ffa5"
    )

    go_repository(
        name = "org_golang_x_net",
        importpath = "golang.org/x/net",
        commit = "65dfc08770ce66f74becfdff5f8ab01caef4e946"
    )

    go_repository(
        name = "in_gopkg_yaml_v2",
        importpath = "gopkg.in/yaml.v2",
        commit = "a5b47d31c556af34a302ce5d659e6fea44d90de0"
    )

    go_repository(
        name = "com_github_Sirupsen_logrus",
        importpath = "github.com/Sirupsen/logrus",
        commit = "3ec0642a7fb6488f65b06f9040adc67e3990296a"
    )

    go_repository(
        name = "com_github_golang_protobuf",
        importpath = "github.com/golang/protobuf",
        commit = "98fa357170587e470c5f27d3c3ea0947b71eb455"
    )

    go_repository(
        name = "com_github_beorn7_perks",
        importpath = "github.com/beorn7/perks",
        commit = "4c0e84591b9aa9e6dcfdf3e020114cd81f89d5f9"
    )

    go_repository(
        name = "com_github_matttproud_golang_protobuf_extensions",
        importpath = "github.com/matttproud/golang_protobuf_extensions",
        commit = "c12348ce28de40eed0136aa2b644d0ee0650e56c"
    )

    go_repository(
        name = "com_github_syndtr_goleveldb",
        importpath = "github.com/syndtr/goleveldb",
        commit = "6b4daa5362b502898ddf367c5c11deb9e7a5c727"
    )

    go_repository(
        name = "com_github_golang_snappy",
        importpath = "github.com/golang/snappy",
        commit = "d9eb7a3d35ec988b8585d4a0068e462c27d28380"
    )
