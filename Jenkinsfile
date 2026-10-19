pipeline {
  agent any
  environment {
    // Menggunakan huruf kecil sesuai akun Docker Hub yang benar (dannd4dann)
    IMAGE_NAME = 'dannd4dann/simple-app'
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
        // Menggunakan block withDockerRegistry bawaan Jenkins yang aman dari error parsing Windows CLI
        withDockerRegistry(credentialsId: env.REGISTRY_CREDENTIALS, url: '') {
          bat '''
            docker push %IMAGE_NAME%:%BUILD_NUMBER%
            docker tag %IMAGE_NAME%:%BUILD_NUMBER% %IMAGE_NAME%:latest
            docker push %IMAGE_NAME%:latest
          '''
        }
      }
    }
  }
}
