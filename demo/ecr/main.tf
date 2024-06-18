resource "aws_ecr_repository" "simanis" {
    count = length(var.repo)
    name = var.repo[count.index]
    tags = {
        Name = var.tags["Name"]
        Env = var.tags["Env"]
  }
}