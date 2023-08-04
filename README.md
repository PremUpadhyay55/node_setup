# node_mgmt_docker

Repo for Docker compose file to run NMS docker application.

This repo contains the "docker-compose.yml" file which has instructions to run NMS application in a docker container.

This is a public repository so any user can clone and then just run the docker compose file which will then pull the image version mentioned in the docker compose file and run in a container.

To keep it updated just updated the version number in the line "image: asesha68/nms:v.v.v"

Clone the repository.

And run below command as root from the local where repo is cloned.

./start.sh
