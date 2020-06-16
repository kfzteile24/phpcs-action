#!/bin/sh

cp /action/problem-matcher.json /github/workflow/problem-matcher.json

echo "::add-matcher::${RUNNER_TEMP}/_github_workflow/problem-matcher.json"

pwd

if [ -z "${INPUT_ENABLE_WARNINGS}" ] || [ "${INPUT_ENABLE_WARNINGS}" = "false" ]; then
    echo "Check for warnings disabled"

    ${INPUT_PHPCS_BIN_PATH} ${INPUT_DIR} --standard=${INPUT_STANDARD} -n --report=checkstyle
else
    echo "Check for warnings enabled"

    ${INPUT_PHPCS_BIN_PATH} ${INPUT_DIR} --bootstrap=/github/workspace/customer/vendor/autoload.php --standard=${INPUT_STANDARD} --report=checkstyle
fi

status=$?

echo "::remove-matcher owner=phpcs::"

exit $status
