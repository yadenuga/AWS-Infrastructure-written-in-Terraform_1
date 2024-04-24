

# Create RDS Subnet Group
resource "aws_db_subnet_group" "dev_db2_subnet_group" {

  name         = "dev_db2_subnet_group" 
  subnet_ids   = [aws_subnet.Private_Data_Subnet_AZ1.id,aws_subnet.Private_Data_Subnet_AZ2.id]
  description  = "subnets for database instance"

  tags   = {
    Name = "dev_db2_subnet_group" 
  }
}

# Get the latest DB Snapshot
# Terraform aws DB Snapshot
data "aws_db_snapshot" "latest_db_snapshot" {
  db_snapshot_identifier = var.DB_SnapShot_ID
  most_recent            = true
  snapshot_type          = "manual"
}

# Create database instance restored from db snapshots
# Terraform aws DB instance
resource "aws_db_instance" "database_instance" {
  instance_class          = var.DB_Instance_Class
  skip_final_snapshot     = true
  availability_zone       = "us-east-1a"
  identifier              = var.DB_Indentifier
  snapshot_identifier     = data.aws_db_snapshot.latest_db_snapshot.id
  db_subnet_group_name    = aws_db_subnet_group.dev_db2_subnet_group.name
  multi_az                = var.Multi_AZ_Deployment
  vpc_security_group_ids  = [aws_security_group.DB-SG.id]
}