resource "aws_ecr_repository" "simanis" {
    name = var.repo
    tags = {
        Name = var.tags["Name"]
        Env = var.tags["Env"]
  }
}