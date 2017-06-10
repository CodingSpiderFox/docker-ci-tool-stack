#/!bin/bash

read -s -p "Enter Admin Password: " ADMIN_PASSWORD
echo
read -s -p "Enter DS-Password: " DS_PASSWORD
echo
read -p "Enter realm name (e.g. EXAMPLE.ORG): " REALM
read -p "Enter IPA server FQDN (e.g. ipa.example.org): " IPA_SERVER_NAME
echo
echo "------------------------------------------------"
echo "Admin password : $ADMIN_PASSWORD"
echo "DS password    : $DS_PASSWORD"
echo "Realm : $REALM"
echo "FQDN  : $IPA_SERVER_NAME"
echo 
read -p "Are these values correct (n/y)?: " ANSWER
if [[ $ANSWER != "y" ]]; then
    echo "Exiting..."
    exit -1
fi

if docker network inspect pgestreamInfrastructure 2>&1 | grep -q 'No such network'; then
  echo "docker network pgestreamInfrastructure not existing. Creating ..."
  docker network create pgestreamInfrastructure
fi

mkdir -p /var/docker-data/freeipa-server

docker run --name freeipa-server-container -ti \
   --net pgestreamInfrastructure \
   -h ipa.example.test \
   -e IPA_SERVER_IP=10.0.0.1 \
   -p 53:53/udp -p 53:53 \
   -p 80:80 -p 443:443 -p 389:389 -p 636:636 -p 88:88 -p 464:464 \
   -p 88:88/udp -p 464:464/udp -p 123:123/udp -p 7389:7389 \
   -p 9443:9443 -p 9444:9444 -p 9445:9445  \
   -v /sys/fs/cgroup:/sys/fs/cgroup:ro \
   --tmpfs /run --tmpfs /tmp \
   --cap-add SYS_ADMIN \
   -v /var/docker-data/ipa-server:/data:Z freeipa/freeipa-server \
   --realm=EXAMPLE.TEST \
   --ds-password=password123123 \
   --admin-password=adminPassword123 \
   --unattended