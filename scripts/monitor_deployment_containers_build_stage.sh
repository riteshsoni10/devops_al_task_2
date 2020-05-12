## Assuming only one type of application container runs at a time

if docker ps  -f status=exited | grep "web_php" >/dev/null; then
	if !docker start  web_php; then
    	# In case the conatiner fails to start, Launch new container
    	docker run -dit --name web_php --network application_external \
        -v /opt/code/:/var/www/localhos/htdocs/ riteshsoni296/apache-php7:latest
	fi
    
elif docker ps  -f status=exited | grep "web" >/dev/null; then
	
    if ! docker start web; then
    	# In case the conatiner fails to start, Launch new container
    	docker run -dit --name web --network application_external \
        -v /opt/code:/usr/local/apache2/htdocs/ httpd:latest
    fi

fi
