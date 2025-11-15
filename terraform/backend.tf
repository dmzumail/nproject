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
    skip_s3_checksum            = true  # ← ЭТО КЛЮЧЕВОЙ ПАРАМЕТР ДЛЯ 1.6+
    use_path_style              = true
  }
}
