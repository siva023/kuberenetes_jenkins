pipeline {
    agent any

    environment {
        DOCKER_HOST_IP = "${params.DOCKER_HOST_IP}"
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

        stage('Copy App to Remote EC2') {
            steps {
                sshagent(['docker-remote-key']) {
                    sh """
                    ssh ${DOCKER_USER}@${DOCKER_HOST_IP} 'rm -rf /tmp/app'
                    scp -o StrictHostKeyChecking=no -r . ${DOCKER_USER}@${DOCKER_HOST_IP}:/tmp/app
                    """
                }
            }
        }

        stage('Build Docker Image on Remote EC2') {
            steps {
                sshagent(['docker-remote-key']) {
                    sh """
                    ssh ${DOCKER_USER}@${DOCKER_HOST_IP} 'cd /tmp/app && docker build -t ${IMAGE_NAME}:latest .'
                    """
                }
            }
        }

        stage('Run Container on Remote EC2') {
            steps {
                sshagent(['docker-remote-key']) {
                    sh """
                    ssh ${DOCKER_USER}@${DOCKER_HOST_IP} 'docker rm -f ${CONTAINER_NAME} || true'
		    ssh ${DOCKER_USER}@${DOCKER_HOST_IP} 'docker run -d --name ${CONTAINER_NAME} -p 80:80 ${IMAGE_NAME}:latest'
		    """
                }
            }
        }
    }
}

