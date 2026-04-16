#!/usr/bin/env bash

set -euo pipefail

SCRIPT_DIR=$(cd -- "$(dirname -- "${BASH_SOURCE[0]}")" && pwd)
WORKSPACE_ROOT=$(cd -- "$SCRIPT_DIR/.." && pwd)
DEVCONTAINER_CONFIG="$WORKSPACE_ROOT/.devcontainer/devcontainer.json"

CONTAINER=$(docker container ls \
	--filter "label=devcontainer.local_folder=$WORKSPACE_ROOT" \
	--filter "label=devcontainer.config_file=$DEVCONTAINER_CONFIG" \
	--format '{{.ID}}' \
	| head -n 1)

if [[ -z "$CONTAINER" ]]; then
	echo "No running devcontainer found for $WORKSPACE_ROOT" >&2
	exit 1
fi

docker container exec -it "$CONTAINER" /entrypoint.sh tmux
