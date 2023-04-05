variable "gitea_url" {
  type = string
  default = "https://gitea.sh4ke.rocks"
}

variable "gitea_token" {
  type = string
  sensitive = true
}
