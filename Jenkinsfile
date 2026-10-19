pipeline {
  agent any
  environment {
    IMAGE_NAME = 'dannd4dann/simple-app'
    REGISTRY_CREDENTIALS = 'dockerhub-credentials'
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
        withCredentials([usernamePassword(credentialsId: env.REGISTRY_CREDENTIALS,
            usernameVariable: 'DOCKER_USER', passwordVariable: 'DOCKER_PASS')]) {
          bat '''
            REM Menulis token password ke file tanpa newline/carriage return
            <nul set /p=%DOCKER_PASS%> docker_token.txt

            REM Login Docker Hub menggunakan --password-stdin yang aman dari malformed header
            docker login -u %DOCKER_USER% --password-stdin < docker_token.txt

            REM Hapus file token demi keamanan
            del docker_token.txt

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
