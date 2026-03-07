variable "project" {
    default = "roboshop"
}
  
variable "environment" {
    default = "dev"
}

variable "sg_name" {
    type = list
    default = [
        #Database sg_names
        "mongodb", "redis", "mysql", "rabbitmq",

        #backend sg_names
        "catalogue", "user", "cart", "shipping", "payment",

        #backend ALB
        "backend_alb",

        #frontend
        "frontend",

        #frontned ALB
        "frontned_alb",

        #bastion ALB
        "bastion_alb",

        #bastion
        "bastion"
        ]
}