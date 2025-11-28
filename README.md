# Simple Python FastAPI app
This is a simple app built with python

## Requirements
1. Python 3.9

## Installation
1. Clone the repository
```
git clone https://github.com/riteshsingh07/python-fastapi-app
```

2. Build the app
```
docker build -t notes-app .
```

3. Run the app
```
docker run -d -p 5555:5555 notes-app:latest
```

## EC2 Instance 
1. Create 2 ec2 instances
   a. MasterCICD : for connecting to master jenkin.
   b. AgentCICD : Jenkins works on Master-Agent architecture, all the work are done under Agent.

## Jenkins Installation
SSH MasterCICD instance, install Java and jenkins.

```
sudo apt update
sudo apt install fontconfig openjdk-21-jre
java -version
```

Jenkins : Long Term Support release

```
sudo wget -O /etc/apt/keyrings/jenkins-keyring.asc \
  https://pkg.jenkins.io/debian-stable/jenkins.io-2023.key
echo "deb [signed-by=/etc/apt/keyrings/jenkins-keyring.asc]" \
  https://pkg.jenkins.io/debian-stable binary/ | sudo tee \
  /etc/apt/sources.list.d/jenkins.list > /dev/null
sudo apt update
sudo apt install jenkins
```

sudo systemctl start jenkins
sudo systemctl enable jenkins
sudo systemctl status jenkins

Note : No need of Jenkin installation is required on AgentCICD instance, only Java will be enough.

## Jenkins UI access 

Go to MasterCICD instance's security group and add a inbound rule and open port 8080 with Anywhere IPv4

http://public_ip_of_MasterCICD:port (mostly 8080)

## Jenkins connecting Master with Agent

1. Create private and public key on MasterCICD instance.
```
cd ~/.ssh
ssh-keygen
```
2. Paste the public key in the authorized_keys file.
```
cd ~/.ssh
vim authorized_keys
```
3. While creating an Agent on jenkins. Select the "SSH with Private Key" and provide the generated private key and public ip of AgentCICD.

## Installation of Docker and AWSCLI on AgentCICD

```
curl "https://awscli.amazonaws.com/awscli-exe-linux-x86_64.zip" -o "awscliv2.zip"
unzip awscliv2.zip
sudo ./aws/install
aws --version
```

```
sudo apt install docker.io
sudo usermod -aG docker jenkins
sudo systemctl start docker
sudo systemctl enable docker
sudo systemctl status docker
```
```
sudo apt-get install docker-compose-v2
```

After the installation perform a jenkins restart.
sudo systemctl restart jenkins

## Jenkins Pipeline Code

Before going for a Pipeline Code. Download the below plugin :
Click on Manage Jenkins -> Plugins
Select all the plugins at once and click on install. After Install, restart jenkins.
```
1. Pipeline : Stage View
2. AWS
3. AWS Steps
```

Create a Item with Declarative Pipeline

You can find the jenkins steps in file named "Jenkinsfile", available in this repository.
