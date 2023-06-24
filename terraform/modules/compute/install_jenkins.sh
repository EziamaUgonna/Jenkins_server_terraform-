#!/bin/bash
# Install Java

sudo apt update
sudo apt install openjdk-11-jre -y

# Install Docker

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


# Install Jenkins

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


# install git
sudo yum install git -y


# install kubectl
sudo apt-get install curl -y
sudo  curl -LO https://storage.googleapis.com/kubernetes-release/release/v1.7.0/bin/linux/amd64/kubectl
sudo  chmod +x ./kubectl
sudo mkdir -p $HOME/bin && sudo cp ./kubectl $HOME/bin/kubectl && export PATH=$PATH:$HOME/bin 




/*
#!/bin/bash

# Install Java
sudo apt update
sudo apt install openjdk-11-jre -y

# Install Docker
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

# Pull Jenkins Docker image
sudo docker pull jenkins/jenkins

# Run Jenkins Docker container
sudo docker run -d -p 8080:8080 -v jenkins_home:/var/jenkins_home -v /var/run/docker.sock:/var/run/docker.sock --name jenkins jenkins/jenkins

# Install kubectl inside Jenkins container
sudo docker exec -it jenkins bash -c "apt-get update && apt-get install curl -y"
sudo docker exec -it jenkins bash -c "curl -LO https://storage.googleapis.com/kubernetes-release/release/v1.7.0/bin/linux/amd64/kubectl"
sudo docker exec -it jenkins bash -c "chmod +x ./kubectl"
sudo docker exec -it jenkins bash -c "mkdir -p $HOME/bin && cp ./kubectl $HOME/bin/kubectl && export PATH=$PATH:$HOME/bin"

# Install AWS IAM Authenticator inside Jenkins container
sudo docker exec -it jenkins bash -c "curl -o aws-iam-authenticator https://amazon-eks.s3.us-west-2.amazonaws.com/1.21.2/2021-07-05/bin/linux/amd64/aws-iam-authenticator"
sudo docker exec -it jenkins bash -c "chmod +x ./aws-iam-authenticator"
sudo docker exec -it jenkins bash -c "mkdir -p $HOME/bin && cp ./aws-iam-authenticator $HOME/bin/aws-iam-authenticator && export PATH=$PATH:$HOME/bin"

# Restart Jenkins container for changes to take effect
sudo docker restart jenkins
*/
