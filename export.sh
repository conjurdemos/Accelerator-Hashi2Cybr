#!/usr/bin/env bash

export EXPORT_DATA_FILE="$1"

if [ -z "$EXPORT_DATA_FILE" ]; then
    echo "Usage: $(basename $0) FILE_PATH"
    echo "       FILE_PATH - absolute file path where to save exported data"
    exit 1
fi

read -s -p "Enter HC Vault Token: " VAULT_TOKEN
export VAULT_TOKEN

set -o allexport
source /tmp/local.env 

safe target -k $VAULT_ADDR myvault
printf "$VAULT_TOKEN" | safe auth token
safe -T myvault export secret > $EXPORT_DATA_FILE

# __END__

