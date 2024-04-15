# DB Variables
variable "DB_SnapShot_ID" {
default = "arn:aws:rds:us-east-1:730335572176:snapshot:dev-rds-db-snapshot"
description = "DB Snapshot ARN"
type        = string

}

# DB Instance Class Variables
variable "DB_Instance_Class" {
default = "db.t2.micro"
description = "DB Instance Type"
type        = string

}

# DB Indentifier Variables
variable "DB_Indentifier" { # Identifier of your Snapshot
default = "dev-rds-db"
description = "DB Instance Identifier"
type        = string

}

# Multi AZ Variables
variable "Multi_AZ_Deployment" { 
default     = false
description = "Multi_AZ_Deployment"
type        = bool

}



