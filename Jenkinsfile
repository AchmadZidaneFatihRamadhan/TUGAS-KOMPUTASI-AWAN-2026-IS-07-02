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
        withCredentials([string(credentialsId: REGISTRY_CREDENTIALS, variable: 'DOCKER_PASS')]) {
          bat '''
            echo %DOCKER_PASS% | docker login -u D4nndaD4nn --password-stdin
            docker push D4nndaD4nn/simple-app:%BUILD_NUMBER%
            docker tag D4nndaD4nn/simple-app:%BUILD_NUMBER% D4nndaD4nn/simple-app:latest
            docker push D4nndaD4nn/simple-app:latest
          '''
        }
      }
    }
  }
}
