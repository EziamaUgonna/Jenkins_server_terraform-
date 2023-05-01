#!/bin/bash
# Install Java
install_java() {
sudo apt update
sudo apt install openjdk-11-jre -y
}
# Install Docker
install_docker() {
  # Commands to install Docker
  sudo apt-get update
  sudo apt-get install docker.io -y
  sudo chmod 666 /var/run/docker.sock
  sudo systemctl start docker
  sudo systemctl enable docker

  # Check if Docker is installed
  docker_version=$(docker -v)
  if [[ $docker_version == *"command not found"* ]]; then
    echo "Docker installation failed"
    exit 1
  else
    echo "Docker installed successfully"
  fi
}

# Install Jenkins
install_jenkins() {
sudo apt install curl
curl -fsSL https://pkg.jenkins.io/debian/jenkins.io-2023.key | sudo tee \
/usr/share/keyrings/jenkins-keyring.asc > /dev/null
echo deb [signed-by=/usr/share/keyrings/jenkins-keyring.asc] \
https://pkg.jenkins.io/debian binary/ | sudo tee \
/etc/apt/sources.list.d/jenkins.list > /dev/null
sudo apt-get update
sudo apt-get install jenkins -y
sudo systemctl start jenkins
sudo cat /var/lib/jenkins/secrets/initialAdminPassword
}

# Call the functions to install the applications
install_java
install_docker
install_jenkins
