docker pull ubuntu:14.04  # Target Container 
docker pull williamyeh/ansible:ubuntu14.04-onbuild  # Ansibile Master

docker network create mynetwork  

mkdir shared_volume  
cd shared_volume  

docker run -d --name ansible --rm --network mynetwork -v $(pwd):/shared_volume williamyeh/ansible:ubuntu14.04-onbuild /bin/bash -c 'while true; do sleep 60; echo keepalive; done'  
docker run -d --name target --rm --network mynetwork -v $(pwd):/shared_volume ubuntu:14.04 /bin/bash -c 'apt-get update; apt-get install -y openssh-server;service ssh start; while true; do sleep 60; echo keepalive; done'  
