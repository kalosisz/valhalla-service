#!/usr/bin/env bash
set -e

valhalla_service "/custom_files/valhalla.json" ${N_THREADS}

# Keep docker running easy
exec "$@"
