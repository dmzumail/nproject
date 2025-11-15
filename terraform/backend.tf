terraform {
  backend "s3" {
    bucket = "tfstate-nproject-site"
    key    = "terraform.tfstate"
    region = "ru-central1"

    endpoints = {
      s3 = "https://storage.yandexcloud.net"
    }

    skip_credentials_validation = true
    skip_metadata_api_check     = true
    skip_region_validation      = true
    skip_requesting_account_id  = true

    use_path_style = true  # 👈 ЗАМЕНИЛИ force_path_style на use_path_style
  }
}