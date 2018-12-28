# Rules Prometheus

## Overview

These rules should be considered experimental.

These rules support validating your Prometheus configuration. 

## Usage

First load this repo in the 

```
git_repository(
    name = "com_github_achew22_rules_prometheus",
    remote = "https://github.com/achew22/rules_prometheus",
    commit = "6e4c1d2df198f83ea87222e3e158e649573623d5",
)

load("@com_github_achew22_rules_prometheus//prometheus:def.bzl", "prometheus_repositories")
prometheus_repositories()
# OR specify a version with a prometheus git tag of your choosing:
prometheus_repositories(prometheus_version = "v2.6.0")
```

OR (do not do both) you can include a specific 

Now you should be able to load `prometheus_alert_test` in your BUILD files.

```
load("@com_github_achew22_rules_prometheus//prometheus:def.bzl", "prometheus_alert_test")

prometheus_alert_test(
    name = "demo",
    srcs = ["demo.rules"],
)
```
