#IMAGE=$(REGISTRY)/$(ORGANIZATION)/$(REPOSITORY):$(TAG)
variable "TAG" {
  default = "latest"
}
variable "REGISTRY" {
  default = "lcr.loongnix.cn"
}
variable "ORGANIZATION" {
  default = "library"
}
variable "REPOSITORY" {
  default = "template"
}

group "default" {
  targets = ["default"]
}

target "default" {
  dockerfile = "Dockerfile"
  tags = ["$(REGISTRY)/$(ORGANIZATION)/$(REPOSITORY):${TAG}"]
} 
