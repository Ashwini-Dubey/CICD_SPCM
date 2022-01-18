pipeline{
    agent any
    environment{
        AWS_ACCOUNT_ID="788051511621"
        AWS_DEFAULT_REGION="us-east-1" 
        IMAGE_REPO_NAME="course-project-node-app"
        IMAGE_TAG="node-app"
        REPOSITORY_URI = "${AWS_ACCOUNT_ID}.dkr.ecr.${AWS_DEFAULT_REGION}.amazonaws.com/${IMAGE_REPO_NAME}" 
        }
    stages{

        //Checking out the code from Git Repo
        stage('Code Checkout'){
            steps{
                git branch: 'dev', credentialsId: '77f8c069-e2c6-4140-9a90-7b0148c96842', url: 'git@github.com:Ashwini-Dubey/Course_Project.git'
            }
        }

        // Building Docker Image for Node-App
        stage('Build'){
            steps{
                script {
                    dockerImage = docker.build "${IMAGE_REPO_NAME}:${IMAGE_TAG}"
                }
            }
        }

        //Login to AWS ECR
        stage('Logging into AWS ECR') {
            steps {
                script {
                sh "aws ecr get-login-password --region ${AWS_DEFAULT_REGION} | docker login --username AWS --password-stdin ${AWS_ACCOUNT_ID}.dkr.ecr.${AWS_DEFAULT_REGION}.amazonaws.com"
                }
                 
            }
        }

        // Uploading Docker images into AWS ECR
        stage('Pushing to ECR') {
            steps{  
                script {
                    sh "docker tag ${IMAGE_REPO_NAME}:${IMAGE_TAG} ${REPOSITORY_URI}:$IMAGE_TAG"
                    sh "docker push ${AWS_ACCOUNT_ID}.dkr.ecr.${AWS_DEFAULT_REGION}.amazonaws.com/${IMAGE_REPO_NAME}:${IMAGE_TAG}"
                }
            }
        }

        //Deployment to App Host
        stage('Deployment to app host'){
            steps{
                script{
                    sh "ssh ubuntu@10.0.3.39 && aws ecr get-login-password --region ${AWS_DEFAULT_REGION} | docker login --username AWS --password-stdin ${AWS_ACCOUNT_ID}.dkr.ecr.${AWS_DEFAULT_REGION}.amazonaws.com && docker pull ${AWS_ACCOUNT_ID}.dkr.ecr.${AWS_DEFAULT_REGION}.amazonaws.com/${IMAGE_REPO_NAME}:${IMAGE_TAG} && docker run -d -p 8080 ${IMAGE_REPO_NAME}:${IMAGE_TAG}"
                }
            }
        }
    }
        
}

