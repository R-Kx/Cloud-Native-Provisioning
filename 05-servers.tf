data "aws_ami" "ubuntu" {
	most_recent = true
	owners      = ["099720109477"]

	filter {
	  name   = "name"
	  values = ["ubuntu/images/hvm-ssd/ubuntu-jammy-22.04-amd64-server-*"] 
	}

	filter {
	  name   = "virtualization-type"
	  values = ["hvm"]
	}
}

resource "aws_key_pair" "aws_auth" {
	key_name   = var.key_name
	public_key = file(var.pub_key_path)
}

resource "aws_instance" "bastion_host" {
	ami                         = data.aws_ami.ubuntu.id
	instance_type               = var.instance_type
	subnet_id                   = aws_subnet.public[0].id
	vpc_security_group_ids      = [aws_security_group.bastion_sg.id]
	key_name                    = var.key_name
	associate_public_ip_address = true
}

resource "aws_instance" "nginx_ec2" {
	ami                         = data.aws_ami.ubuntu.id
	instance_type               = var.instance_type
	subnet_id                   = aws_subnet.private[0].id
	vpc_security_group_ids      = [aws_security_group.nginx_sg.id]
	key_name                    = var.key_name
	iam_instance_profile        = aws_iam_instance_profile.nginx_profile.name

	user_data                   = <<-EOF
#!/bin/bash
sudo apt update -y
sudo apt install nginx awscli -y
sudo systemctl start nginx
sudo systemctl enable nginx
aws s3 cp s3://${aws_s3_bucket.nginx_bucket.id}/index.html /var/www/html/index.html
EOF
}
