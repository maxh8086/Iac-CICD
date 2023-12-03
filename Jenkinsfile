pipeline {
    agent any

    // Define variable for Docker image
    environment {
        DOCKER_IMAGE = 'maxh8086/apache'
        DOCKER_TAG = "${BUILD_NUMBER}"
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
                        sh "docker build -t ${DOCKER_IMAGE}:${DOCKER_TAG} ."
                    }
                }
            }
        }

        stage('Docker Test') {
            steps {
                script {
                    // Run Docker container in detached mode and get the container ID
                    def container_id = sh(script: "docker run -d -p 8086:80 ${DOCKER_IMAGE}:${DOCKER_TAG}", returnStdout: true).trim()

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

                    // Stop the Docker container
                    sh "docker stop ${container_id}"
                    sh "docker rm ${container_id}"

                    if (status == '200') {
                        echo 'Application is running successfully'
                    // Log in to Docker Hub with Jenkins credentials
                        withDockerRegistry(credentialsId: 'dockerhub', url: 'https://index.docker.io/v1/') {
                            // Push Docker image
                            sh "docker push ${DOCKER_IMAGE}:${DOCKER_TAG}"
                        }
                    } else {
                        error "Application returned status code: ${status}"
                    }
                    // Log out from Docker Hub
                    sleep time: 30, unit: 'SECONDS'
                    sh 'docker logout'
                }
            }
        }
    }
}
