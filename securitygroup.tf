resource "aws_security_group" "chain-security" {
  vpc_id = "${aws_vpc.chaincloud.id}"
  name = "blockchain-securty group"
  description = " security group for blockchain"

  egress {
    from_port = 0
    to_port = 0
    protocol = "-1"
    cidr_blocks = ["0.0.0.0/0"]
  }
  ingress {
    from_port = 22
    to_port = 22
    protocol = "tcp"
    cidr_blocks = ["0.0.0.0/0"]
 }
### Opening port for Hyperledger Sawtooth
  # Opening port for Sawtooth to use trasaction processor
 ingress {
   from_port = 4004
   to_port = 4004
   protocol = "tcp"
   cidr_blocks = ["0.0.0.0/0"]
 }

  # Since i intend to open plenty of ports below for docker i do no need to create another.
# ingress {
#   from_port = 8008
#   to_port = 8008
#   protocol = "tcp"
#   cidr_blocks = ["0.0.0.0/0"]
# }
 ### Kubernetes uses ports 30000 and above ,this gives kubernetes plenty of ranges to test our deployments.
 #   In real world only open dedicated ports
  ingress {
    from_port = 30000
    to_port = 31000
    protocol = "tcp"
    cidr_blocks = ["0.0.0.0/0"]
  }
###   open por for us to use docker and test
  ingress {
    from_port = 8000
    to_port = 9000
    protocol = "tcp"
    cidr_blocks = ["0.0.0.0/0"]
  }

tags{
  Name = "blockhainvpc-security group"
 }
}
