output "eip" {
	description = "elastic/static IP for NAT gateway"
	value       = aws_eip.nat_eip.public_ip
}

output "s3_bucket_name" {
	description = "Unique name for my s3_bucket"
	value       = aws_s3_bucket.nginx_bucket.id
}

output "bastion_ip" {
	description = "IP for my bastion-host"
	value       = aws_instance.bastion_host.public_ip
}

output "nginx_ec2_internal_ip" {
	description = "Private IP for my ec2 svc"
	value       = aws_instance.nginx_ec2.private_ip
}