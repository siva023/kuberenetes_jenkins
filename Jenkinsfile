pipeline {
    agent any

    environment {
        DOCKER_HOST_IP = "ip-172-31-11-78"
        DOCKER_USER = "ubuntu"
        IMAGE_NAME = "photogenic-app"
        CONTAINER_NAME = "photogenic-container"
        CONTAINER_PORT = "5000"
        HOST_PORT = "80"
    }

    stages {
        stage('Clone Repo') {
            steps {
                checkout scm
            }
        }

        stage('Build Docker Image on Remote EC2') {
            steps {
                sshagent(['docker-remote-key']) {
                    sh """
                    scp -o StrictHostKeyChecking=no -r . ${DOCKER_USER}@${DOCKER_HOST_IP}:/tmp/app
                    ssh ${DOCKER_USER}@${DOCKER_HOST_IP} 'docker build -t ${IMAGE_NAME}:latest /tmp/app'
                    """
                }
            }
        }

        stage('Run Container on Remote EC2') {
            steps {
                sshagent(['docker-remote-key']) {
                    sh """
                    ssh ${DOCKER_USER}@${DOCKER_HOST_IP} 'docker rm -f ${CONTAINER_NAME} || true'
                    ssh ${DOCKER_USER}@${DOCKER_HOST_IP} 'docker run -d --name ${CONTAINER_NAME} -p ${HOST_PORT}:${CONTAINER_PORT} ${IMAGE_NAME}:latest'
                    """
                }
            }
        }
    }
}

