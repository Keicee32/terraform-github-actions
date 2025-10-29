

resource "aws_instance" "app_instance" {
    ami = var.ami_id
    instance_type = var.instance_type
    subnet_id = aws_subnet.public_app_vpc_subnet.id[0]

    root_block_device {
      volume_size = var.volume_size
      volume_type = var.volume_type
      delete_on_termination = var.delete_on_termination
    }
}