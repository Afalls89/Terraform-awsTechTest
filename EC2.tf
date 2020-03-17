data "aws_ami" "ubuntu" {
  most_recent = true

  filter {
    name   = "name"
    values = ["ubuntu/images/hvm-ssd/ubuntu-trusty-14.04-amd64-server-*"]
  }

  filter {
    name   = "virtualization-type"
    values = ["hvm"]
  }

  owners = ["099720109477"] # Canonical
}

resource "aws_instance" "server1" {
  ami                    = "${data.aws_ami.ubuntu.id}"
  instance_type          = "t2.micro"
  subnet_id              = "${aws_subnet.subnet1.id}"
  vpc_security_group_ids = ["${aws_security_group.servers.id}"]

  tags = {
    Name = "server1"
  }
}

resource "aws_instance" "server2" {
  ami                    = "${data.aws_ami.ubuntu.id}"
  instance_type          = "t2.micro"
  subnet_id              = "${aws_subnet.subnet2.id}"
  vpc_security_group_ids = ["${aws_security_group.servers.id}"]

  tags = {
    Name = "server2"
  }
}

resource "aws_instance" "server3" {
  ami                    = "${data.aws_ami.ubuntu.id}"
  instance_type          = "t2.micro"
  subnet_id              = "${aws_subnet.subnet3.id}"
  vpc_security_group_ids = ["${aws_security_group.servers.id}"]

  tags = {
    Name = "server3"
  }
}
