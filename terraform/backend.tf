terraform {
  #  required_providers {
  #    yandex = {
  #      source = "yandex-cloud/yandex"
  #    }
  #  }

  backend "s3" {
    endpoints = {
      s3 = "https://storage.yandexcloud.net"
    }
    bucket = "dembucket"
    region = "ru-central1"
    key    = "devops3-remote-state"
    #    key    = "test-state.tfstate"
    skip_region_validation      = true
    skip_credentials_validation = true
    skip_requesting_account_id  = true
    skip_s3_checksum            = true
  }
}
