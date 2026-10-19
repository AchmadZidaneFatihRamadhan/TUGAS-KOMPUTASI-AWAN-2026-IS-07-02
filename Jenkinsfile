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
            # Membersihkan spasi atau karakter tersembunyi dari kredensial
            $user = $env:DOCKER_USER.Trim()
            $pass = $env:DOCKER_PASS.Trim()

            # Melakukan login langsung via argumen -u dan -p di PowerShell
            docker login -u "$user" -p "$pass"

            # Melakukan Push dan Tag Image
            docker push "${env:IMAGE_NAME}:${env:BUILD_NUMBER}"
            docker tag "${env:IMAGE_NAME}:${env:BUILD_NUMBER}" "${env:IMAGE_NAME}:latest"
            docker push "${env:IMAGE_NAME}:latest"
          '''
        }
      }
    }
  }
}
