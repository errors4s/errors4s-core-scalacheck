#!/usr/bin/env bash

set -e

source sbt-shell-release/src/bash/functions.sh

export SBT_TASKS='+test;+test:doc;docs/mdoc --check;++2.13.6;scalafixAll --check;scalafmtSbtCheck;scalafmtCheckAll'
readonly SBT_TASKS

sbt_release
