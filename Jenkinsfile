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
          // Menggunakan blok powershell murni dengan fungsi .Trim() untuk membersihkan spasi/newline tersembunyi
          powershell '''
            $user = "$env:DOCKER_USER".Trim()
            $pass = "$env:DOCKER_PASS".Trim()

            # Lakukan login dengan token yang sudah dibersihkan
            $pass | docker login -u $user --password-stdin

            # Jalankan tag dan push image ke Docker Hub
            docker push "${env:IMAGE_NAME}:${env:BUILD_NUMBER}"
            docker tag "${env:IMAGE_NAME}:${env:BUILD_NUMBER}" "${env:IMAGE_NAME}:latest"
            docker push "${env:IMAGE_NAME}:latest"
          '''
        }
      }
    }
  }
}
