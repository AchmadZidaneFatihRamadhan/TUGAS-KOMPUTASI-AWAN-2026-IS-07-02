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
        withCredentials([usernamePassword(credentialsId: REGISTRY_CREDENTIALS,
            usernameVariable: 'DOCKER_USER', passwordVariable: 'DOCKER_PASS')]) {
          powershell '''
            # Membersihkan spasi/newline pada password dan melakukan login langsung
            $pass = $env:DOCKER_PASS.Trim()
            & docker login -u "$env:DOCKER_USER" -p "$pass"
            
            # Melakukan push dan tag image
            docker push "${env:IMAGE_NAME}:${env:BUILD_NUMBER}"
            docker tag "${env:IMAGE_NAME}:${env:BUILD_NUMBER}" "${env:IMAGE_NAME}:latest"
            docker push "${env:IMAGE_NAME}:latest"
          '''
        }
      }
    }
  }
}
