#!/bin/sh

HERE="$(dirname "$0")"

exec cargo run \
    --quiet \
    --release \
    --manifest-path="$HERE/Cargo.toml" \
    --target-dir="$TARGET_DIR" \
    -- "$@"
