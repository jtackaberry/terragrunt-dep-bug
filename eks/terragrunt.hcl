include "root" {
  path   = find_in_parent_folders("root.hcl")
  expose = true
}

dependency "vpc" {
  config_path = "${get_terragrunt_dir()}/../vpc"
}

locals {
  # This line causes the error "Could not convert include to the execution ctx to evaluate
  # additional locals in file"
  common = include.root.locals.common
}
