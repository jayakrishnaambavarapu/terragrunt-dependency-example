generate "provider" {
  path = "provider.tf"
  if_exists = "overwrite_terragrunt"
  contents = <<EOF
provider "aws" {
  profile = "jayakrishna-trusted-user"
  region = "eu-north-1"
  assume_role {
    role_arn = "arn:aws:iam::976806633434:role/terragrunt-role" 

  }

}
EOF
}
