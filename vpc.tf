resource "aws_vpc" "chaincloud" {
  cidr_block = "10.0.0.0/16"
  instance_tenancy = "default"
  enable_dns_support = "true"
  enable_dns_hostnames = "true"
  enable_classiclink = "false"
  tags {
    Name = "chainvpc"
  }
}
# subnets
resource "aws_subnet" "chain-public-1" {
  vpc_id = "${aws_vpc.chaincloud.id}"
  cidr_block = "10.0.1.0/24"
  map_public_ip_on_launch = "true"
  availability_zone = "us-east-2a"
  tags {
    Name = "chain-public1"

}
}
resource "aws_subnet" "chain-public-2" {
  vpc_id = "${aws_vpc.chaincloud.id}"
  cidr_block = "10.0.2.0/24"
  map_public_ip_on_launch = "true"
  availability_zone = "us-east-2b"
  tags {
    Name = "chain-public2"
  }
}
  resource "aws_subnet" "chain-private-1" {
    vpc_id = "${aws_vpc.chaincloud.id}"
    cidr_block = "10.0.3.0/24"
    map_public_ip_on_launch  = "false"
    availability_zone = "us-east-2a"
    tags {
      Name = "chain-private-1"
    }
  }
  resource "aws_subnet" "chain-private-2" {
    vpc_id = "${aws_vpc.chaincloud.id}"
    cidr_block = "10.0.4.0/24"
    map_public_ip_on_launch = "false"
    availability_zone = "us-east-2b"
    tags {
      Name = "chain-private2"
    }
  }
## adding our internet gateway
resource "aws_internet_gateway" "chain-gateway" {
  vpc_id = "${aws_vpc.chaincloud.id}"
  tags {
    Name = "blockcchainvpc-gateway"
  }
}

resource "aws_route_table" "chain-rt" {
  vpc_id = "${aws_vpc.chaincloud.id}"
  route {
    cidr_block = "0.0.0.0/0"
    gateway_id = "${aws_internet_gateway.chain-gateway.id}"

}
}
#route association public
resource "aws_route_table_association" "chain-rt-1" {
  subnet_id = "${aws_subnet.chain-public-1.id}"
  route_table_id = "${aws_route_table.chain-rt.id}"
}
resource "aws_route_table_association" "chain-rt-2" {
  subnet_id = "${aws_subnet.chain-public-2.id}"
  route_table_id = "${aws_route_table.chain-rt.id}"
}
