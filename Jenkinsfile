pipeline {
    agent any
    
    tools {
      maven 'MavenBuild'
    }
    
    environment {
      DOCKER_TAG = getVersion()
    }
    
    stages {
        
        
        stage('SCM') {
            steps {
                //When we dont have master branch, we should mention the main branch, it is created newly
                git branch: 'main', credentialsId: 'github-access', 
                url: 'https://github.com/halilili/kubernetes-ansible-deployment/'
                
            }
        }
        
      
        stage('Build Our Code') {
            steps {
               sh "mvn clean package"
            }
        }
        
        
        stage('SonarQube Analysis') {
            steps{
                withSonarQubeEnv('sonarqube-8.5.1') { 
                  sh "mvn sonar:sonar"
                }
            }
        }
        
        
        stage('Jmeter Unit Testing') {
            steps{
                
                sh "/home/ubuntu/jmeter/apache-jmeter-5.4.3/bin/jmeter.sh -n -t /home/ubuntu/jmeter/apache-jmeter-5.4.3/bin/examples/CSVSample.jmx -l test.jtl"
            }
        }
        
         
        stage('Docker Build') {
            steps {
              sh "docker build . -t hassanali70826/myapp:${DOCKER_TAG}"
            }
        }
        
        
        stage('DockerHub Push') {
            steps {
                withCredentials([string(credentialsId: 'docker-password', variable: 'dockerHubPassword')]) {
                    sh "docker login -u hassanali70826 -p ${dockerHubPassword}"
                }
                
                sh "docker push hassanali70826/myapp:${DOCKER_TAG}"
            }
        }
        
               
       stage("Prepare Deployment Tag"){
           steps{
               sh "chmod +x changeTag.sh"
               sh "./changeTag.sh ${DOCKER_TAG}"
           }
       }
        
        stage('Ansible Deployment') {
            steps {
               
                //ansiblePlaybook credentialsId: 'aws-jenkins-server-aws-ssh-conn', disableHostKeyChecking: true,
                //extras: " -e DOCKER_TAG=${DOCKER_TAG}", installation: 'ansible', inventory: 'inventory.yaml', playbook: 'ansible-playbook-deployment.yml' 
               
                ansiblePlaybook credentialsId: 'aws-jenkins-server-aws-ssh-conn', disableHostKeyChecking: true,
                extras: " -e DOCKER_TAG=${DOCKER_TAG} -vvv", installation: 'ansible', inventory: 'inventory.yaml', playbook: 'ansible-playbook-deployment.yml' //ansible-deployment.yml
            }
        }
        
    }
}

def getVersion()
{
  def commitHash = sh label: '', returnStdout: true, script: 'git rev-parse --short HEAD'
  return commitHash
}
