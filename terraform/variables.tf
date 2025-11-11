variable "yc_token" {
  description = "IAM secret key (from service account)"
  type        = string
}

variable "yc_cloud_id" {
  description = "Yandex Cloud ID"
  type        = string
}

variable "yc_folder_id" {
  description = "Yandex Folder ID"
  type        = string
}

variable "domain" {
  description = "Your domain name, e.g. example.com"
  type        = string
}

/*
variable "public_ip" {
  description = "Public IPv4 address to point domain to"
  type        = string
  default     = ""
}
*/