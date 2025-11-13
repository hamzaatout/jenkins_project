#!/bin/bash
set -euo pipefail

VENV_PATH=${1:-venv}
PROJECT_ROOT=$(cd "$(dirname "$0")" && pwd)

if [ -d "${PROJECT_ROOT}/${VENV_PATH}" ]; then
    # shellcheck disable=SC1091
    source "${PROJECT_ROOT}/${VENV_PATH}/bin/activate"
fi

python "${PROJECT_ROOT}/app.py" > "${PROJECT_ROOT}/deployment_output.txt"
echo "Application deployed locally. Output saved to deployment_output.txt"
