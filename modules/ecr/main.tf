resource "aws_ecr_repository" "repos" {

for_each=toset(var.repo_names)

name=each.value

image_tag_mutability="MUTABLE"

}
