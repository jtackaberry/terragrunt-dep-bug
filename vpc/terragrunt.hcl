include "root" {
  path   = find_in_parent_folders("root.hcl")
  expose = true
}

locals {
  # This line causes the error "Could not convert include to the execution ctx to evaluate
  # additional locals in file"
  common = include.root.locals.common
}
