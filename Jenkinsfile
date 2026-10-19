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
        // Menggunakan withCredentials standar untuk menghindari context "desktop-linux" error
        withCredentials([usernamePassword(credentialsId: env.REGISTRY_CREDENTIALS,
            usernameVariable: 'DOCKER_USER', passwordVariable: 'DOCKER_PASS')]) {
          bat '''
            REM Menyimpan password ke file sementara agar terhindar dari korupsi format cmd
            echo %DOCKER_PASS%> docker_token.txt
            
            REM Login Docker Hub langsung ke registry utama
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
