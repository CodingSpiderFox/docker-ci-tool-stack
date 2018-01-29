Added Makefile to start/stop/rm compose
Added front nginx to reverse proxy all services and provide one url for all services
Added nexus docker registry on nexus:19081
Todo add nexus config via curl API
Todo add gitlab config via ENV or curl API
Todo add jenkins config via ENV, groovy or curl API
Todo add tools in jenkins build (jenkins-job-builder,...)
Todo add light-weight HTTP/HTTPS proxy daemon, to provide single output point for all services
Todo add ELK/syslog services
Todo add syslog redirect to elk
Todo add smtp services
Todo add docker host install and config script
Todo add docker-compose via systemd start script
Todo add prepare services working dir (data, logs, config for /opt/gitlab, nexus, ...) on docker host

| *Tool* | *Public URL* *Back Link* | *Credentials* |
| ------------- | ------------- | ------------- |
| start URL | http://ip | proxy | |
| GitLab | http://ip | http://localhost | root/5iveL!fe |
| Jenkins | http://ip/jenkins | http://localhost:18080/ | no login required |
| Nexus | http://ip/nexus/ | http://localhost:18081/ | admin/admin123 |
| Docker registry Nexus | http://ip/ | http://localhost:19081/ | admin/admin123 |

Custo docker-compose.yml with ENV

nginx:
https://blog.docker.com/2015/04/tips-for-deploying-nginx-official-image-with-docker/
jenkins
https://github.com/jenkinsci/docker/blob/master/README.md
gitlab
https://docs.gitlab.com/omnibus/docker/README.html

nexus:
https://github.com/sonatype/docker-nexus3
nexus-repository: config
https://github.com/sonatype/nexus-book-examples/tree/nexus-3.x/scripting
https://github.com/sonatype-nexus-community/docker-nginx-nexus-repository/blob/master/nexus.sh

https://github.com/savoirfairelinux/ansible-nexus3-oss/tree/master/files/groovy
