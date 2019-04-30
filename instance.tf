resource "aws_instance" "blockchain" {
  ami          = "${lookup(var.AMIS, var.AWS_REGION)}"
  instance_type = "t2.micro"
  # putting our instances in public subnet. This is not intended to be a production deployment.
  subnet_id = "${aws_subnet.chain-public-1.id}"
  count = 3 # 3 instances to be created
  vpc_security_group_ids = ["${aws_security_group.chain-security.id}"]
  # Using chainkey pair to access our instances
  key_name = "${aws_key_pair.chainkey.id}"
  instance_initiated_shutdown_behavior = "stop"
  root_block_device ={
    volume_type = "gp2"
    volume_size = 20
# if you want terraform to detroy instances comment the line below
    delete_on_termination = "false"
    }

  tags {
    Name = "blockchain-instance"
  }
}
