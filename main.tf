module "xxxxx_project_factory" {
  source  = "app.terraform.io/xxxxx/xxxxx-project-factory/google"
  version = "1.2.27"

  project_name = "gcp-jenkins-test"
  folder_id = "xxxxx"
  billing_account = "xxxxxx"
  editors = "user:arshdeep.kalia@xxxx.com"
  bill-to = "xxx"
  cost-center = "xxxx"
  environment = "xxxx"
  business-owner = "xxxxx"
  product-owner = "xxxxx"
  operations-owner = "xxxxx"
    
}
