pipeline {
    agent any

    environment {
        // Define your Docker registry credentials
        DOCKER_REGISTRY_CREDENTIALS = credentials('dockerhub')
        DOCKER_IMAGE_NAME = "maxh8086/apache:${BUILD_NUMBER}"
    }

    stages {
        stage('Docker Build') {
            steps {
                script {
                    // Clean workspace before cloning
                    deleteDir()

                    // Clone the repository
                    sh 'git clone https://github.com/maxh8086/Iac-CICD.git'

                    // Navigate to the cloned directory
                    dir('Iac-CICD') {
                        // Build Docker image
                        sh "docker build -t $DOCKER_IMAGE_NAME ."
                    }
                }
            }
        }

        stage('Docker Test') {
            steps {
                script {
                    // Run Docker container in detached mode and get the container ID
                    def container_id = sh(script: "docker run -d -p 8086:80 $DOCKER_IMAGE_NAME", returnStdout: true).trim()

                    // Introduce a delay to allow the application to start
                    sleep time: 10, unit: 'SECONDS'

                    // Test if the application is running
                    def curlOutput = sh(script: "curl -o - -s -w \"%{http_code}\" http://localhost:8086", returnStdout: true).trim()

                    // Extract HTTP status code from the curl output
                    def status = curlOutput =~ /(\d+)$/
                    if (status) {
                        status = status[0][0]
                    }

                    echo "HTTP Status Code: ${status}"

                    // Stop and remove the Docker container
                    sh "docker stop ${container_id}"
                    sh "docker rm ${container_id}"

                    if (status == '200') {
                        echo 'Application is running successfully'

                        // Push Docker image to the registry using withDockerRegistry
                        withDockerRegistry(credentialsId: 'dockerhub', url: 'https://index.docker.io/v1/') {
                            sh "docker push $DOCKER_IMAGE_NAME"
                        }
                    } else {
                        error "Application returned status code: ${status}"
                    }
                    // Log out from Docker Hub
                    sh 'docker logout'
                }
            }
        }
    }
}
