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
      source = "go-gitea/gitea"
      version = "0.1.0"
    }
  }
}

provider "gitea" {
  base_url = var.gitea_url # optionally use GITEA_BASE_URL env var
  token    = var.gitea_token # optionally use GITEA_TOKEN env var
}
