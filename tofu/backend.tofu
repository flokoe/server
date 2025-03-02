terraform {
  backend "s3" {
    bucket   = "flokoe-server-tofu-state"
    endpoint = "https://nbg1.your-objectstorage.com"
    key      = "server.tfstate"

    region                      = "main" # this is required, but will be skipped!
    skip_credentials_validation = true   # this will skip AWS related validation
    skip_metadata_api_check     = true
    skip_region_validation      = true
  }
}
