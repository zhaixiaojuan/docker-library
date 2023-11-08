variable "TAG" {
  default = "master"
}
variable "REGISTRY" {
  default = "lcr.loongnix.cn"
}
variable "ORGANIZATION" {
  default = "docker"
}
variable "REPOSITORY" {
  default = "dockerfile-upstream"
}

group "default" {
  targets = ["default"]
}

target "default" {
  dockerfile = "Dockerfile"
  tags = ["${REGISTRY}/${ORGANIZATION}/${REPOSITORY}:${TAG}"]
} 
