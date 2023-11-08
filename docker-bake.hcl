#IMAGE=$(REGISTRY)/$(ORGANIZATION)/$(REPOSITORY):$(TAG)
variable "TAG" {
  default = "T_TAG"
}
variable "REGISTRY" {
  default = "T_REGISTRY"
}
variable "ORGANIZATION" {
  default = "T_ORGANIZATION"
}
variable "REPOSITORY" {
  default = "T_REPOSITORY"
}

group "default" {
  targets = ["default"]
}

target "default" {
  dockerfile = "Dockerfile"
  tags = ["$(REGISTRY)/$(ORGANIZATION)/$(REPOSITORY):${TAG}"]
} 
