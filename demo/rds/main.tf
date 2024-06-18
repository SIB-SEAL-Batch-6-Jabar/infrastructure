resource "aws_db_instance" "simanis-db" {
    engine = var.engine
    engine_version = var.engine_version
    availability_zone = var.avaibility_zone
    identifier = var.identifier
    username = var.username
    password = var.password
    instance_class = var.instance_class
    storage_type = var.storage_type
    allocated_storage = var.allocated_storage
    vpc_security_group_ids = [aws_security_group.simanis-rds-sg.id]
    db_subnet_group_name   = aws_db_subnet_group.simanis-subnet-g.name
    skip_final_snapshot = true
    publicly_accessible = true

  tags = {
    Name = var.tags["Name"]
    Env = var.tags["Env"]
  }
}

resource "aws_security_group" "simanis-rds-sg" {
  name = "rds-sg"
  vpc_id = var.vpc_id

  ingress {
    from_port   = 5432
    to_port     = 5432
    protocol    = "tcp"
    cidr_blocks = ["0.0.0.0/0"]
  }

  egress {
    from_port   = 0
    to_port     = 0
    protocol    = "-1"
    cidr_blocks = ["0.0.0.0/0"]
  }
}

# resource "aws_db_subnet_group" "simanis-subnet-g" {
#   name       = "my-db-subnet-group"
#   subnet_ids = var.aws_public_subnet

#   tags = {
#     Name = var.tags["Name"]
#     Env = var.tags["Env"]
#   }
# }

# resource "null_resource" "create_db" {
#   provisioner "local-exec" {
#     command = <<EOT
#       if ! command -v psql &> /dev/null
#       then
#           echo "psql could not be found, installing..."
#           sudo apt-get update
#           sudo apt-get install -y wget ca-certificates
#           wget --quiet -O - https://www.postgresql.org/media/keys/ACCC4CF8.asc | sudo apt-key add -
#           echo "deb http://apt.postgresql.org/pub/repos/apt/ $(lsb_release -cs)-pgdg main" | sudo tee /etc/apt/sources.list.d/pgdg.list
#           sudo apt-get update
#           sudo apt-get install -y postgresql-client-16
#       else
#           echo "psql is already installed"
#       fi

#       export PGPASSWORD=${var.password}
#       psql --host=${aws_db_instance.simanis-db.endpoint} --port=5432 --username=${var.username} --dbname=postgres --command="CREATE DATABASE simanis;"
#     EOT
#   }

#   depends_on = [aws_db_instance.simanis-db]
# }

