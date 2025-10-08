#!/bin/bash

usage() {
	cat <<EOF
Usage: $0 <NIP> [CID]

Downloads CEIDG data using the provided NIP. Optionally, pass a CID to look up a specific company record.
EOF
}

if [ $# -lt 1 ]; then
	usage
	exit 1
fi

export NIP="$1"
export CID="$2"

echo "Downloading CEIDG data..."
echo "JWT: "$JWT
echo "----------------------------------------"
echo "Searching by NIP..."
echo "----------------------------------------"
curl -i -sS -X GET "https://dane.biznes.gov.pl/api/ceidg/v3/firmy?nip=$NIP" -H "Authorization: Bearer $JWT"
curl -sS -X GET "https://dane.biznes.gov.pl/api/ceidg/v3/firmy?nip=$NIP" -H "Authorization: Bearer $JWT" | jq
if [ -n "$CID" ]; then
	echo "----------------------------------------"
	echo "By CID"
	echo "----------------------------------------"
	curl -i -sS -X GET "https://dane.biznes.gov.pl/api/ceidg/v3/firma/$CID" -H "Authorization: Bearer $JWT"
	curl -sS -X GET "https://dane.biznes.gov.pl/api/ceidg/v3/firma/$CID" -H "Authorization: Bearer $JWT" | jq
fi
