variable "project-name" {
  default = "workshop1"
}

variable "project-tags" {
  type = map(any)
  default = {
    "purpose" : "workshop1"
    "project" : "fcj-workshop"
    "author" : "pthach_terraform"
  }
}