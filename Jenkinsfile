pipeline {
    agent {
        label 'jenkins-slave'
    }
    environment {
        DOCKERHUB_CREDENTIALS = credentials('devops-cred')
    }
    stages { 
        stage('SCM Checkout') {
            steps {
                git url: 'https://github.com/PSock7/S9-devops-project.git', branch: 'main'
            }
        }

        stage('Build docker image') {
            steps {  
                sh 'docker build -t efrei2023/golangwebapi:${BUILD_NUMBER} .'
            }
        }
        stage('Login to Docker Hub') {
            steps {
                withCredentials([usernamePassword(credentialsId: 'devops-cred', passwordVariable: 'DOCKERHUB_PSW', usernameVariable: 'DOCKERHUB_USR')]) {
                    sh 'echo $DOCKERHUB_PSW | docker login -u $DOCKERHUB_USR --password-stdin'
                }
            }
        }
        stage('Push image to Docker Hub') {
            steps {
                sh 'docker push efrei2023/golangwebapi:${BUILD_NUMBER}'
            }
        }
        stage('Deploy Go webapi  container to K8s'){
            steps{
                script{
                    sh 'kubectl apply -f ./Kubernetes/namespace.yaml'
                    sh 'kubectl apply -f ./Kubernetes/go.yaml'
                }
            }
        }
    }
    post {
        always {
            sh 'docker logout'
        }
    }
}
