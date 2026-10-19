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
          // Menggunakan PowerShell untuk menghindari korupsi token password di Windows cmd
          powershell '''
            $user = $env:DOCKER_USER.Trim()
            $pass = $env:DOCKER_PASS.Trim()

            # Login Docker Hub menggunakan password-stdin via PowerShell
            $pass | docker login -u $user --password-stdin

            # Push dan Tag Image ke Docker Hub
            docker push "${env:IMAGE_NAME}:${env:BUILD_NUMBER}"
            docker tag "${env:IMAGE_NAME}:${env:BUILD_NUMBER}" "${env:IMAGE_NAME}:latest"
            docker push "${env:IMAGE_NAME}:latest"
          '''
        }
      }
    }
  }
}
