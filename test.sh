#!/usr/bin/env bash

STAGE_N="$1"
if [ -n "$STAGE_N" ] && ! [[ "$STAGE_N" =~ ^[[:space:]]*[0-9]+[[:space:]]*$ ]]; then
    echo "Error: argument must be a number: $STAGE_N" >&2
    exit 1
fi

TEST_CASES_JSON="$(jq --compact-output --arg stage_n "$STAGE_N" '
    def stage_num: $stage_n | tonumber;
    def to_stage_num: .[6:] | tonumber;
    def include_stage: ($stage_n | length == 0) or (.tester_log_prefix | to_stage_num) <= stage_num;
    map(select(include_stage))
' "$TEST_CASES_FILE")"

CODECRAFTERS_SUBMISSION_DIR="$TEST_DIR" \
CODECRAFTERS_TEST_CASES_JSON="$TEST_CASES_JSON" \
exec "$TEST_RUNNER"
