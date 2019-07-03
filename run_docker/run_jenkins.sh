#!/bin/bash
docker run -itd --name myjenkins --restart always -p 8080:8080 -p 50000:50000 -v /var/jenkins_home jenkins
