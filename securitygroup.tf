resource "aws_security_group" "elb-securitygroup" {
  vpc_id = "${aws_vpc.main.id}"
  name   = "elb"

  egress {
    from_port   = 0
    to_port     = 0
    protocol    = "-1"
    cidr_blocks = ["0.0.0.0/0"]
  }

  ingress {
    from_port   = 80
    to_port     = 80
    protocol    = "tcp"
    cidr_blocks = ["0.0.0.0/0"]
  }

  tags {
    Name = "elb-securitygroup"
  }
}

resource "aws_security_group" "servers" {
  vpc_id = "${aws_vpc.main.id}"
  name   = "servers"

  egress {
    from_port   = 0
    to_port     = 0
    protocol    = "-1"
    cidr_blocks = ["0.0.0.0/0"]
  }

  ingress {
    from_port       = 80
    to_port         = 80
    protocol        = "tcp"
    security_groups = ["${aws_security_group.elb-securitygroup.id}"]
  }

  tags {
    Name = "servers"
  }
}
