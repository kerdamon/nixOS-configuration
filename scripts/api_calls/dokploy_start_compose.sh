echo "${DOKPLOY_URL}/api/compose.start"
echo "x-api-key: $(cat ${DOKPLOY_API_KEY_PATH})"
echo "{\"composeId\": \"$1\"}"