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

install_terraform() {
sudo apt-get update && sudo apt-get install -y gnupg software-properties-common # -y needed here
wget -O- https://apt.releases.hashicorp.com/gpg | \
gpg --dearmor | \
sudo tee /usr/share/keyrings/hashicorp-archive-keyring.gpg
gpg --no-default-keyring \
--keyring /usr/share/keyrings/hashicorp-archive-keyring.gpg \
--fingerprint
echo "deb [signed-by=/usr/share/keyrings/hashicorp-archive-keyring.gpg] \
https://apt.releases.hashicorp.com $(lsb_release -cs) main" | \
sudo tee /etc/apt/sources.list.d/hashicorp.list
sudo apt update -y  # -y needed here
sudo apt-get install terraform  # -y not needed here, but you may choose to include it for consistency

}
install_git(){
# install git
sudo yum install git -y
}
install_kubectl() {
# install kubectl
sudo apt-get install curl -y
sudo  curl -LO https://storage.googleapis.com/kubernetes-release/release/v1.7.0/bin/linux/amd64/kubectl
sudo  chmod +x ./kubectl
sudo mkdir -p $HOME/bin && sudo cp ./kubectl $HOME/bin/kubectl && export PATH=$PATH:$HOME/bin }
# Call the functions to install the applications
install_java
install_docker
install_jenkins
install_terraform
install_git
install_kubectl