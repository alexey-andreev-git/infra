locals { 
  absolute_module_path = abspath(path.module) 

  file_path            = var.deployment_file == "" ? "${local.absolute_module_path}/deployment.yaml" : var.deployment_file

  yaml_data            = yamldecode(file("${local.file_path}")) 
  # { for d in yamldecode(file("${local.absolute_module_path}/deployment.yaml")) : d.id => d }

  deployments_data     = { for d in local.yaml_data.aws.deployments : d.id => d }

  aws_region           = var.region == "" ? local.yaml_data.aws.region : var.region

}
