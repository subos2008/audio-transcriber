OPERATION_ID=$1
curl -H "Authorization: Bearer "$(gcloud auth application-default print-access-token) \
     -H "Content-Type: application/json; charset=utf-8" \
     "https://speech.googleapis.com/v1/operations/${OPERATION_ID}" > data.json

jq '.response.results[] | .alternatives[] | .transcript' data.json
