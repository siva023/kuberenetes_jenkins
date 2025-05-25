pipeline {
    agent any
    environment {
        IMAGE_NAME = 'photogenic-app'
    }
    stages {
        stage('Clone Repo') {
            steps {
                git 'https://github.com/siva023/kuberenetes_jenkins.git'
            }
        }
        stage('Build Docker Image') {
            steps {
                sh 'docker build -t $IMAGE_NAME:latest .'
            }
        }
        stage('Run Container') {
            steps {
                sh '''
                docker rm -f photogenic-container || true
                docker run -d --name photogenic-container -p 80:5000 $IMAGE_NAME:latest
                '''
            }
        }
    }
}

