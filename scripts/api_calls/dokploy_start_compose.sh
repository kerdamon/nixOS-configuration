curl -X POST "${DOKPLOY_URL}/api/compose.start" \
  -H "x-api-key: $(cat ${DOKPLOY_API_KEY_PATH})" \
  -H 'accept: application/json' \
  -H 'Content-Type: application/json' \
  -d "{\"composeId\": \"$1\"}"
