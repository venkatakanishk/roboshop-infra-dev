module "vpc" {
    source = "../../terraform-aws-vpc"
    project = var.project
    environment = var.env
    is_peering_required = true
}