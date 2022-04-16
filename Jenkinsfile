pipeline{
agent any
  stages {
    stage ('checkout'){
      steps{
        git credentialsId: 'github-credentials', url: 'https://github.com/ROJAVEERA/icici-project.git'
      }
    }
    stage ('build'){
      steps{
       sh 'mvn clean install'
      }
    }
     stage ('Build Docker image'){
      steps{
       sh "docker build -t rojakumaridocker/icici-project-money-transfer:${params.getDockerTag} ."
      }
    }
    stage ('Push to Docker hub'){
      steps{
        withCredentials([string(credentialsId: 'rojadockerpwd', variable: 'Dockerpwd')]) {
          sh "docker login -u rojakumaridocker -p ${Dockerpwd}"
          sh "docker push rojakumaridocker/icici-project-money-transfer:${params.getDockerTag}"
        } 
      }
    }
    stage ('deploy on k8s'){
      steps{
       sh "chmod +x changeTag.sh"
       sh "./changeTag.sh ${params.getDockerTag}"
        sshagent(['kubernetes-machine']) {
          sh "scp -o StrictHostKeyChecking=no kubernetes-deploy.yml ubuntu@13.235.67.29:/home/ubuntu/"
          sh "ssh ubuntu@13.235.67.29 kubectl apply -f kubernetes-deploy.yml"
         // sh "ssh ubuntu@13.235.67.29 kubectl apply -f kubernetes-svc.yml"
       }       
      }
    }
  }
}
