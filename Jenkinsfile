pipeline {
  agent any
  environment {
    IMAGE_NAME = 'D4nndaD4nn/simple-app'
    REGISTRY_CREDENTIALS = 'dockerhub-credentials'
  }
  stages {
    stage('Checkout') { 
      steps { checkout scm } 
    }
    stage('Build') { 
      steps { bat 'echo "Build di Windows"' } 
    }
    stage('Build Docker Image') {
      steps { 
        bat "docker build -t %IMAGE_NAME%:%BUILD_NUMBER% ." 
      }
    }
    stage('Push Docker Image') {
      steps {
        withCredentials([usernamePassword(credentialsId: env.REGISTRY_CREDENTIALS,
            usernameVariable: 'DOCKER_USER', passwordVariable: 'DOCKER_PASS')]) {
          bat '''
            REM Menulis autentikasi langsung ke config.json Docker untuk menghindari malformed header CLI Windows
            mkdir "%USERPROFILE%\\.docker" 2>nul
            powershell -Command "$auth = [Convert]::ToBase64String([Text.Encoding]::ASCII.GetBytes(\"$env:DOCKER_USER:$env:DOCKER_PASS\")); $config = '{\"auths\": {\"https://index.docker.io/v1/\": {\"auth\": \"' + $auth + '\"}}}'; Set-Content -Path \"$env:USERPROFILE\\.docker\\config.json\" -Value $config"

            REM Push dan Tag Image ke Docker Hub
            docker push %IMAGE_NAME%:%BUILD_NUMBER%
            docker tag %IMAGE_NAME%:%BUILD_NUMBER% %IMAGE_NAME%:latest
            docker push %IMAGE_NAME%:latest
          '''
        }
      }
    }
  }
}
