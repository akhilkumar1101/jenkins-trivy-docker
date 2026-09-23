pipeline {
    agent any

    environment {
        IMAGE_NAME = "docker-trivy-demo"
        IMAGE_TAG = "latest"
    }

    stages {

        stage('Checkout') {
            steps {
                checkout scm
            }
        }

        stage('Build Docker Image') {
            steps {
                sh '''
                    docker build -t ${IMAGE_NAME}:${IMAGE_TAG} .
                '''
            }
        }

        stage('Trivy Scan') {
            steps {
                sh '''
                    trivy image \
                    --severity HIGH,CRITICAL \
                    --exit-code 1 \
                    ${IMAGE_NAME}:${IMAGE_TAG}
                '''
            }
        }

        stage('Run Container') {
            steps {
                sh '''
                    docker run -d \
                    --name docker-trivy-demo \
                    -p 3000:3000 \
                    ${IMAGE_NAME}:${IMAGE_TAG}
                '''
            }
        }
    }

    post {
        always {
            sh '''
                docker rm -f docker-trivy-demo 2>/dev/null || true
            '''
        }

        success {
            echo 'Docker image built and Trivy scan passed!'
        }

        failure {
            echo 'Pipeline failed. Check the Trivy vulnerability report.'
        }
    }
}
