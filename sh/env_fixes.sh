#!/bin/bash
set -e

# Set watches rather high
echo fs.inotify.max_user_watches=524288 | tee -a /etc/sysctl.conf && sysctl -p
