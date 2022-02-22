sed "s/DOCKER_TAG/$1/g" ansible-playbook-deployment.yml > ansible-playbook-deployment-tagged.yml
