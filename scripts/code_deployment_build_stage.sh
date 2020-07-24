flag=0

## Checking if the HTML and PHP both language code is present 
if [ $(find . -type f \( -name "*.php" -a -name "*.html" \) | wc -l ) -gt 0 ]; then
	echo "PHP and HTML Code found"
    flag=$(( $flag+1 ))

## Checking if the only HTML language code is present
elif [ $(find . -type f  -name "*.html" | wc -l ) -gt 0 ]; then
	echo "HTML Code found"
    flag=$(( $flag+2 ))

fi


if [[ $flag -eq 1 ]]; then
  ## Cleaning up of old project container
	if docker ps -a | grep "web_php"; then
		docker rm -f web_php
    fi    
  
  ## Checking if the container network is present or not
	if ! docker network ls | grep "test_application"; then
     	docker network create --driver bridge application_external
    fi

  ## Launching new Apache and PHP container to deploy the code
	docker run --rm -dit --name web_php --network application_external \
        -v /opt/code/:/var/www/localhos/htdocs/ riteshsoni296/apache-php7:latest

elif [[ $flag -eq 2 ]]; then
  ## Cleaning up of old project container
	if  docker ps -a | grep "web"; then
    	docker rm -f web
	fi
    
    if ! docker network ls | grep "test_application"; then
       	docker network create --driver bridge application_external
    fi
   
   ## Launching new Apache container to deploy the code
    docker run --rm -dit --name web --network application_external \
        -v /opt/code:/usr/local/apache2/htdocs/ httpd:latest

fi

