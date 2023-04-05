terraform {
  backend "s3" {
    endpoint = "https://minio.sh4ke.rocks"
    bucket = "terraform-state"
    key    = "gitea.tfstate"
    region = "eu-central-1"
    skip_credentials_validation = true
    skip_metadata_api_check     = true
    skip_region_validation      = true
    force_path_style            = true
  }

  required_providers {
    gitea = {
      source = "Lerentis/gitea"
      version = "0.12.2"
    }
  }
}

provider "gitea" {
  base_url = var.gitea_url
  token    = var.gitea_token
}
