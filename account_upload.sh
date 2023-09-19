#!/usr/bin/env bash

export JSONFILE="$1"

if [ ! -f "$JSONFILE" ]; then
	echo "Usage: $(basename $0) DATA_JSONFILE"
	exit 1
fi

set -o allexport
source /tmp/local.env 

read -p "Enter PAS User: " PAS_USER
export PAS_USER

export OUTFILE="${JSONFILE}.txt"


# Convert JSON to cybr cli params

jq -r --arg q "'" 'to_entries|map("-u \(.key|gsub("/"; "_")) -c \($q)\(.value|tostring)\($q)") |.[]' $JSONFILE > $OUTFILE

export CMD="cybr accounts add -s Pending -p MigrationPlatform -t password -a none"

cybr logon --concurrent -i -a cyberark -u $PAS_USER -b $PAS_ENDPOINT
while IFS="" read -r p || [ -n "$p" ]
do
  printf '%s %s\n' "$CMD" "$p" 
  eval $CMD $p
done < $OUTFILE

# __END__

