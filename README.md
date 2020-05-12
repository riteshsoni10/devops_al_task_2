# Automated Deployment and Testing



### Tasks

#### Jenkins Image using Dockerfile

The Dockerfile is created from the `alpine:latest` linux image minimising the storage required to run the jenkins container. The image contains the docker cli to launch the docker containers in the following tasks. 

The dockerfile extract is as follows :

```
FROM alpine:latest

RUN apk --update add jenkins docker openrc -X http://dl-cdn.alpinelinux.org/alpine/edge/community

RUN rc-update add docker boot

ARG http_port=8080

ARG HOME=/var/lib/jenkins

ENV JENKINS_HOME ${HOME}

ENV USER jenkins

EXPOSE ${http_port}

CMD ["java","-jar","/usr/share/webapps/jenkins/jenkins.war"]

```

The dockerfile should always start with `FROM` instruction. The FROM instruction specifies the Parent Image from which we are building. The `RUN` instruction is used to execute the shell commands during the build creation. The `ENV` instruction is used to set environment variables for the image. The `EXPOSE` instruction is used to perform Port Address Translation in the container i.e; exposing a service to the outside world. The `CMD` instructions are executed at the run time i.e during the container creation. 


The image can be easily created using  dockerfile using `docker build` command. 

```
mkdir /opt/jenkins
cd /opt/jenkins

# Create file name Dockerfile with the earlier mentioned steps

docker build -t jenkins:v1 /opt/jenkins/ --network=host
```

*-t* parameter denotes the tag for the image

*/opt/jenkins* represents the directory that consists Dockerfile.



Initialising a container using image

```
 docker run -it -v jenkins_data:/var/lib/jenkins -v /var/run/docker.sock:/var/run/docker.sock \
         --name jenkins -p 8080:8080 riteshsoni296/jenkins:latest
```

The jenkins container data directory `/var/lib.jenkins` is mounted on docker volume for data persistency during unavoidable circumstances.
The docker dameon socket is mounted to enable docker cli from inside the jenkins container.

