#!/bin/sh

cp /action/problem-matcher.json /github/workflow/problem-matcher.json

echo "/github/workspace/customer/vendor/kfzteile24/php-coding-standard/Kfz24"
find /github/workspace/customer/vendor/kfzteile24/php-coding-standard/Kfz24 -print

echo "::add-matcher::${RUNNER_TEMP}/_github_workflow/problem-matcher.json"

if [ -n "${INPUT_INSTALLED_PATHS}" ]; then
    ${INPUT_PHPCS_BIN_PATH} --config-set installed_paths "${INPUT_INSTALLED_PATHS}"
fi

echo "${INPUT_PHPCS_BIN_PATH} AND ${INPUT_DIR} AND ${INPUT_STANDARD} AND ${INPUT_INSTALLED_PATHS}"

if [ -z "${INPUT_ENABLE_WARNINGS}" ] || [ "${INPUT_ENABLE_WARNINGS}" = "false" ]; then
    echo "Check for warnings disabled"

    ${INPUT_PHPCS_BIN_PATH} ${INPUT_DIR} --standard=${INPUT_STANDARD} -n --report=checkstyle
else
    echo "Check for warnings enabled"

    ${INPUT_PHPCS_BIN_PATH} ${INPUT_DIR} --standard=${INPUT_STANDARD} --report=checkstyle
fi

status=$?

echo "::remove-matcher owner=phpcs::"

exit $status
