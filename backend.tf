terraform {
  backend "s3" {
    bucket = "my-s3-bucket-for-tf-state-in-2026"
    key = "main"
    region = "us-east-2"
    use_lockfile = true
  }
}
