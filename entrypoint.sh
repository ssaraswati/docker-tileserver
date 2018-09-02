#!/usr/bin/env bash

sh /scripts/compile_style.sh

echo "Starting renderer"
sh /scripts/run_render.sh
