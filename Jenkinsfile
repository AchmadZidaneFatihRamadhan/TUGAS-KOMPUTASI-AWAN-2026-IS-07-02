pipeline {
  agent any
  environment {
    IMAGE_NAME = 'dannd4dann/simple-app'
    REGISTRY_CREDENTIALS = 'dockerhub-credentials'
    // Kunci utama untuk Windows Service: memaksa Docker melewati pencarian context "desktop-linux" yang error
    DOCKER_HOST = 'npipe:////./pipe/docker_engine'
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
