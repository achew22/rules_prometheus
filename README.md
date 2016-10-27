# Rules Prometheus

## Overview

These rules should be considered experimental.

These rules support validating your Prometheus configuration. 

## Usage

Create an entry in your WORKSPACE for rules_prometheus:

```
git_repository(
    name = "com_github_achew22_rules_prometheus",
    remote = "https://github.com/achew22/rules_prometheus",
    commit = "1b0b5db578ed926d0b62f5666e1a2a7452e9fe10",
)

load("@com_github_achew22_rules_prometheus//prometheus:def.bzl", "prometheus_repositories")
prometheus_repositories()
```

Now you should be able to load `prometheus_alert_test` in your BUILD files.

```
load("@com_github_achew22_rules_prometheus//prometheus:def.bzl", "prometheus_alert_test")

prometheus_alert_test(
    name = "demo",
    srcs = ["demo.rules"],
)
```
