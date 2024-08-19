pipeline{
  parameters{
     booleanParam (name:'Terraform_Init', defaultValue: true, description:'Initialize the terraform configuration')
     booleanParam (name:'Terraform_Plan', defaultValue: true, description:'Plan the terraform configuration')
     booleanParam (name:'Terraform_Apply', defaultValue: true, description:'Apply the terraform configuration')
     booleanParam (name:'Terraform_Destroy', defaultValue: false, description:'Destroy the terraform configuration')
  }
  agent any
   environment {
       AWS_CREDS = credentials('aws-access-key-secret-ID')
          AWS_REGION = 'us-east-1'
    }
  stages{
    stage(Checkout){
       steps {
         //checkout scm         
         git branch: 'master', credentialsId: 'terraform-login-private-key', url: 'https://github.com/RishwanaBegam/test.git'
            }
    }
    stage('Check Terraform Version') {
            steps {
                sh 'terraform version'
            }
        }
    
    stage('Terraform Initialization'){
     when {
                expression { return params.Terraform_Init }
            }
            steps {
                echo 'Initializing your Terraform configuration...'
                sh ''' terraform -chdir=Terraform/ init '''
            }
        }
    stage('Terraform Plan'){
      when {
                expression { return params.Terraform_Plan }
            }
      steps{

       script {
                   withAWS(region: "${AWS_REGION}", credentials: 'aws-access-key-secret-ID'){
                   echo 'Showing your execution plan for infra creation...'
                   sh 'terraform -chdir=Terraform/ plan'
            }
        }
      }
    }
    stage('Terraform apply'){
      when {
                expression { return params.Terraform_Apply }
            }
      steps{
        script{
        withAWS(region: "${AWS_REGION}", credentials: "${AWS_CREDS}"){
           echo 'Executing the configuration to create infrastructure in AWS :)'
         sh 'terraform -chdir=Terraform/ apply -auto-approve'
        echo '------------------Completed the infrastructure creation---------------------'
      }
    }
      }
    }
    stage('Terraform destroy'){
      when {
                expression { return params.Terraform_Destroy }
            }
      steps{
        script{
        withAWS(region: "${AWS_REGION}", credentials: "${AWS_CREDS}"){
        sh 'terraform -chdir=Terraform/ init'
        sh 'terraform -chdir=Terraform/ destroy -auto-approve'
        echo '------------------------------Deleted the infrastructure in AWS--------------------------'
      }
        }
      }
    }
}
  post {
        always {
          echo 'cleaning up the workspace'
            cleanWs()
        }
    }
}
