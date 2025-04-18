# In either case we declare this dependency and reference an output from this dependency
# in the generate block.
#
# This does not cause any problems.
dependency "tfstate" {
  config_path = find_in_parent_folders("tfstate/terragrunt.hcl")
}

generate "test" {
  path      = "test.tf"
  if_exists = "overwrite"
  contents  = <<-EOT
    # It doesn't really matter what this is, the point is that it references a dependency
    # ${dependency.tfstate.outputs.prefix}
  EOT
}


# Case 1: remote_state references a dependency
#
# This is only a problem for eks/ but not for vpc/
#
# remote_state {
#   backend = "local"
#   generate = {
#     path      = "backend.tf"
#     if_exists = "overwrite_terragrunt"
#   }
#   config = {
#     path = "${dependency.tfstate.outputs.prefix}-${path_relative_to_include()}.tfstate"
#   }
# }

# Case 2: remote state does not reference dependencies.  This does not produce the error,
# even though we are still referencing a dependency in the generate block.
#
remote_state {
  backend = "local"
  generate = {
    path      = "backend.tf"
    if_exists = "overwrite_terragrunt"
  }
  config = {
    path = "tfstate-${path_relative_to_include()}.tfstate"
  }
}

locals {
  common = {}
}
