resource "aws_security_group" "elb-securitygroup" {
  vpc_id = "${aws_vpc.main.id}"
  name   = "elb"
}

resource "aws_security_group" "servers" {
  vpc_id = "${aws_vpc.main.id}"
  name   = "serers"
}
