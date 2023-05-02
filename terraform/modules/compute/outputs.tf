output "public_ip" {
   description = "The public IP address of the Jenkins server"
   value = aws_instance.jenkins_server.public_ip
} 


