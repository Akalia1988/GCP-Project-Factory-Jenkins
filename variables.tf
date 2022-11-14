
variable "it-tf-deploy-creds" {
   description = "Path to terraform credential file"
   type = string
} 

variable "random_project_id" {
  description = "Adds a suffix of 4 random characters to the `project_id`"
  type        = bool
  default     = false
}

variable "org_id" {
  description = "The organization ID."
  type        = string
  default     = "organization/123456"
}

variable "project_name" {
  description = "The name for the project"
  type        = string
}

variable "project_id" {
  description = "The ID to give the project. If not provided, the `name` will be used."
  type        = string
  default     = ""
}

variable "billing_account" {
  description = "The ID of the billing account to associate this project with"
  type        = string
}

variable "folder_id" {
  description = "The ID of a folder to host this project"
  type        = string
  default     = ""
}

variable "editors" {
  description = "project editor"
  type        = string
  default     = ""
}


variable "labels" {
  description = "Map of labels for project"
  type        = map(string)
  default     = {}
}

variable "auto_create_network" {
  description = "Create the default network"
  type        = bool
  default     = false
}
