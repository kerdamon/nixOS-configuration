# curl -X POST "${DOKPLOY_URL}/api/compose.stop" \
#   -H "x-api-key: $(cat ${DOKPLOY_API_KEY_PATH})" \
#   -H 'accept: application/json' \
#   -H 'Content-Type: application/json' \
#   -d "{\"composeId\": \"$1\"}"

echo "${DOKPLOY_URL}/api/compose.stop" >> ~/tmp/borg-test
echo "x-api-key: $(cat ${DOKPLOY_API_KEY_PATH})" 
echo "{\"composeId\": \"$1\"}"