#!/usr/bin/env bash

set -e

haxe build.hxml

hl main.hl
