pipeline {
    agent {label "ritesh"}
    
     environment {
        AWS_DEFAULT_REGION = "us-east-1"
        AWS_ACCOUNT_ID = "705307574472"
        ECR_REPOSIRORY = "notes-app-ecr-image"
        ECR_URL = "705307574472.dkr.ecr.us-east-1.amazonaws.com/notes-app-ecr-image"
     }
     
    stages {
        stage ("Code") {
            steps {
                echo "Cloning Code"
                git url : "https://github.com/riteshsingh07/python-fastapi-app.git" , branch : "main"
                 echo "Cloning Done"
            }
        }
        stage ("Build Image") {
            steps {
              echo "Building Image"
              sh "docker build -t python-app:latest ."
              echo "Image Done"
          }
        }
        stage ("Pushing to DockerHub") {
          steps {
              echo "DockerHub Login"
              withCredentials([
                  usernamePassword(credentialsId: "DockerHubCred", 
                  passwordVariable: "DockerHubPass", 
                  usernameVariable: "DockerHubUser")]) {
                
              sh "docker login -u ${env.DockerHubUser} -p ${env.DockerHubPass}"
              echo "Taging Image"
              sh "docker tag python-app:latest ${env.DockerHubUser}/python-app:latest"
              sh "docker push ${env.DockerHubUser}/python-app:latest"
              echo "Image Pushed"
            }
          }
        }
        stage ("Logging to AWS ECR") {
          steps {
              echo "AWS ECR Login"
              withAWS(credentials: 'AWSCred', region: "${AWS_DEFAULT_REGION}") {
                  sh """
                  echo "Logging to ECR"
                  
                  aws ecr get-login-password --region ${AWS_DEFAULT_REGION} | \
                  docker login --username AWS --password-stdin ${ECR_URL}
                  
                  echo "Logging Done"
                  """
              }
          }
        }
        stage ("Pushing to AWS ECR") {
          steps {
              echo "Taging Image"
              sh "docker tag python-app:latest ${ECR_URL}:latest"
              sh "docker push ${ECR_URL}:latest"
              echo "Image Pushed"
          }
        }
        stage ("Deploy") {
          steps {
              echo "Deploying the Code"
              sh "docker run -d -p5555:5555 python-app:latest"
              echo "Deployed"
          }
        }
    }
}
