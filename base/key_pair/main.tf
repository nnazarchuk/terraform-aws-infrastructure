resource "aws_key_pair" "main" {
  public_key = file(var.public_key)

  tags = var.common_tags
}
