
terraform {
  backend "remote"{
    hostname = "app.terraform.io"
    organization = ""
    workspaces {
      name = var.project_name
    }
  }
}

terraform {
  required_providers {
    google = {
      source = "hashicorp/google"
      version = "4.9.0"
    }
  }
}

provider "google" {
  project = var.project_name
  credentials = file(var.it-tf-deploy-creds)
}
