dependency "tfstate" {
  config_path = find_in_parent_folders("tfstate/terragrunt.hcl")
}

remote_state {
  backend = "local"
  generate = {
    path      = "backend.tf"
    if_exists = "overwrite_terragrunt"
  }
  config = {
    path = "${dependency.tfstate.outputs.prefix}-${path_relative_to_include()}.tfstate"
  }
}

locals {
  common = {}
}
