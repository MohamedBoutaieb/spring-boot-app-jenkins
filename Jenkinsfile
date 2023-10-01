pipeline {
    agent any
    tools{
        maven 'maven'
    }
    stages {
        stage('Build project') {
            steps {
               checkout scmGit(branches: [[name: '*/main']], extensions: [], userRemoteConfigs: [[url: 'https://github.com/MohamedBoutaieb/spring-boot-app-jenkins']])
                bat 'mvnw clean install'
            }
        }
        stage('Build docker image'){
            steps{
                script{
                   bat 'docker build -t medboutaieb/spring-boot-jenkins .'
                }
            }
        }
        stage('Push image to docker hub'){

            steps {
                script{
                withCredentials([string(credentialsId: 'dockerhubpwd', variable: 'dockerhubcreds')]){
                bat 'docker login'}

                }
            }

        }
    }
}
