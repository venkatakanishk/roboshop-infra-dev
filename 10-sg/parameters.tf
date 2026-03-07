/* resource "aws_ssm_parameter" "sg_id" {
  name  = "/${var.project}/${var.environment}/momgo_db_sg_id"#/roboshop/dev/sg_id
  type  = "String"
  value = module.sg.sg_id
} */

resource "aws_ssm_parameter" "sg_id" {
  count = length(var.sg_name)
  name  = "/${var.project}/${var.environment}/${var.sg_name[count.index]}_sg_id"#/roboshop/dev/mongodb_sg_id
  type  = "String"
  value = module.sg[count.index].sg_id
}