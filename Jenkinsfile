pipeline{
  parameters{
     booleanParam (name:'Terraform_Init', defaultValue: false, description:'Initialize the terraform configuration')
     booleanParam (name:'Terraform_Plan', defaultValue: false, description:'Plan the terraform configuration')
     booleanParam (name:'Terraform_Apply', defaultValue: false, description:'Apply the terraform configuration')
     booleanParam (name:'Terraform_Destroy', defaultValue: false, description:'Destroy the terraform configuration')
  }
  agent any
  stages{
    stage(Checkout){
       steps {
                git branch: 'master', credentialsId: 'Terraform-login-private-key', url: 'https://github.com/RishwanaBegam/test.git'
            }
    }
    stage('Terraform Initialization'){
     when {
                expression { return params.Terraform_Init }
            }
            steps {
                echo 'Initializing Terraform...'
                 sh 'terraform init' 
            }
        }
    stage('Terraform Plan'){
      when {
                expression { return params.Terraform_Plan }
            }
      steps{
        echo 'Showing execution plan information...'
        sh 'terraform plan'
      }
    }
    stage('Terraform apply'){
      when {
                expression { return params.Terraform_Apply }
            }
      steps{
        sh 'terraform apply'
        echo 'Executing the configuration to create infrastructure in AWS :)'
      }
    }
    stage('Terraform destroy'){
      when {
                expression { return params.Terraform_Destroy }
            }
      steps{
        sh 'terraform destroy'
        echo ' Deleting the infrastructure in AWS !'
      }
    }
}
}
