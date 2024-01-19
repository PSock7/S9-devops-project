pipeline {
    agent {
        label 'jenkins-slave'
    } 
    environment {
    DOCKERHUB_CREDENTIALS = credentials('devops-cred')
    }
    stages { 
        stage('SCM Checkout') {
            steps{
            git 'https://github.com/PSock7/S9-devops-project'
            }
        }

        stage('Build docker image') {
            steps {  
                sh 'docker build -t efrei2023/golangwebapi:$BUILD_NUMBER .'
            }
        }
        stage('login to dockerhub') {
            steps{
                sh 'echo $DOCKERHUB_CREDENTIALS_PSW | docker login -u $DOCKERHUB_CREDENTIALS_USR --password-stdin'
            }
        }
        stage('push image') {
            steps{
                sh 'docker push efrei2023/golangwebapi:$BUILD_NUMBER'
            }
        }
}
post {
        always {
            sh 'docker logout'
        }
    }
}

