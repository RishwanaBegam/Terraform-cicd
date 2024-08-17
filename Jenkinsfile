pipeline{
  parameters{
     boolean (name:'Terraform_Init', defaultValue: false, description:'Initialize the terraform configuration')
     boolean (name:'Terraform_Plan', defaultValue: false, description:'Plan the terraform configuration')
     boolean (name:'Terraform_Apply', defaultValue: false, description:'Apply the terraform configuration')
     boolean (name:'Terraform_Destroy', defaultValue: false, description:'Destroy the terraform configuration')
  }
  agent any
  stages{
    stage(Checkout){
       steps {
                git branch: 'master', credentialsId: 'Terraform-login-private-key', url: 'https://github.com/RishwanaBegam/test.git'
            }
    }
    stage(Terraform Initialization){
      when {
        params.Terraform_Action
      }
      steps{
        sh 'terraform init' 
      }
    }
    stage(Terraform Plan){
      steps{
        sh 'terraform plan'
      }
    }
    stage(Terraform apply){
      steps{
        sh 'terraform apply'
      }
    }
    stage(Terraform destroy){
      steps{
        sh 'terraform destroy'
      }
    }
}
}
