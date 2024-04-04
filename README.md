Test case for [#3036](https://github.com/gruntwork-io/terragrunt/issues/3036).


Use Terragrunt 0.54.16 or later and run:

```
# Clone the example
git clone https://github.com/jtackaberry/terragrunt-dep-bug.git

# Apply mock tfstate module -- this is fine
cd terragrunt-dep-bug/tfstate
terragrunt apply

# Apply mock vpc module -- this is fine
cd ../vpc
terragrunt apply

# Apply mock eks module -- error occurs here
cd ../eks
terragrunt apply
```

which should result in:

```
ERRO[0000] Error: Unknown variable

ERRO[0000]   on /.../terragrunt-dep-bug/terragrunt.hcl line 12, in remote_state:
ERRO[0000]   12:     path = "${dependency.tfstate.outputs.prefix}-${path_relative_to_include()}.tfstate"
ERRO[0000]
ERRO[0000] There is no variable named "dependency".

ERRO[0000] Could not convert include to the execution ctx to evaluate additional locals in file /.../terragrunt-dep-bug/vpc/terragrunt.hcl  prefix=[/.../terragrunt-dep-bug/vpc]
```
