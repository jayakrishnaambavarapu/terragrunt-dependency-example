terraform {
  source = "tfr://registry.terraform.io/jayakrishnaambavarapu/ambavarapu-vpcmodule/aws//modules/subnets?version=1.0.0"
}

include "root" {
  path = find_in_parent_folders()
}

dependency "vpc" {
  config_path = "/home/ubuntu/terragrunt/prod/vpc"
  mock_outputs_allowed_terraform_commands = ["plan","validate"]
  mock_outputs = {
    vpc_id = "vpc-00f414ee7418e6153"
  }  
}

dependencies {
  paths = ["/home/ubuntu/terragrunt/prod/vpc"]
}

inputs = {
  cidr = "10.0.1.0/24"
  vpc-id = dependency.vpc.outputs.jayakrishna-vpc-result.id
}

#reference link: https://terragrunt.gruntwork.io/docs/reference/config-blocks-and-attributes/#dependency
#reference link: https://terragrunt.gruntwork.io/docs/features/execute-terraform-commands-on-multiple-modules-at-once/

/* in the mock_output_allowed_terraform_commands we specified only plan and validate terraform commands for these two commands mock_outputs vpc_id data will be taken and for apply
command it will take output value return from dependency block.

why because dependency block will return output values only after it created the resource, till then if we run plan or validate commands it display errors.

in the dependencies block we have specified that this first vpc needs to be created and then subnet needs to be created.

subnet is depends on vpc id so in subnet/terragrunt.hcl file we have specified vpc path in dependencies block.

reference link: https://terragrunt.gruntwork.io/docs/reference/config-blocks-and-attributes/#dependencies

important point regarding input variable vpc-id = dependency.vpc.outputs.jayakrishna-vpc-result.id here jayakrishna-vpc-result returns all attributes of vpc resource so to be specific
i have used .id to reference vpc id value to vpc-id in input variables. 

*/

