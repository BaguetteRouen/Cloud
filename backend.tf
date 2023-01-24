terraform {
  backend "s3" {
    bucket = "mc_save"
    key    = "path/to/my/key"
    region = "us-east-1"
  }
}
