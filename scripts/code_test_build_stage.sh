if docker ps |  grep "web_php"; then
	ip_address=$(docker container inspect --format "{{ .NetworkSettings.Networks.application_external.IPAddress }}" web_php)
	code_status=$(curl -s -w "%{http_code}" -o /dev/null http://$ip_address)
    
elif docker ps | grep "web"; then
	ip_address=$(docker container inspect --format "{{ .NetworkSettings.Networks.application_external.IPAddress }}" web)
	code_status=$(curl -s -w "%{http_code}" -o /dev/null http://$ip_address)

fi

if [[ $code_status -ne 200 ]]; then
	exit 1
else
	exit 0
fi
