#!/usr/bin/env bash

# Usage:
#   REQUIREMENTS:
#    - populate "local.env" with Vault and PAS vars
#
#      # CyberArk PAS vars
#      PAS_ENDPOINT="https://pasvault.example.com" # Do NOT append "/PasswordVault/"
#      PAS_USER="administrator"
#      PAS_PASS="user password"
#      
#      
#      # HC Vault vars
#      VAULT_ADDR="https://hcvault.example.com:8200"
#      VAULT_SKIP_VERIFY=false   # Use only if using self-signed certificate
#      VAULT_TOKEN="api token"

set -o allexport

if [ -f local.env ]; then
    source local.env
elif [ -f /tmp/local.env ]; then
    source /tmp/local.env
fi


if [ -z "$PAS_ENDPOINT" ]; then
    echo "ERROR: please ensure env var PAS_ENDPOINT is set."
    exit 1
fi
if [ -z "$VAULT_ADDR" -o -z "$VAULT_SKIP_VERIFY" ]; then
    echo "ERROR: please ensure env vars are set: VAULT_ADDR, VAULT_SKIP_VERIFY."
    exit 2
fi

if ! command -v safe >/dev/null 2>&1; then
    echo "ERROR: command not found: safe."
    exit 3
fi
if ! command -v cybr >/dev/null 2>&1; then
    echo "ERROR: command not found: cybr."
    exit 3
fi

tmpdir=$(mktemp -d --tmpdir=/data)
export JSONFILE="${tmpdir}/fromvault.json"

/bin/export.sh $JSONFILE
/bin/account_upload.sh $JSONFILE

# __END__

