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
        // Menggunakan blok docker bawaan Jenkins yang otomatis login dan push aman
        script {
          docker.withRegistry('https://index.docker.io/v1/', "${REGISTRY_CREDENTIALS}") {
            def customImage = docker.image("${IMAGE_NAME}:${BUILD_NUMBER}")
            customImage.push()
            customImage.push('latest')
          }
        }
      }
    }
  }
}
