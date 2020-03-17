# resource "aws_iam_server_certificate" "cert" {
#   name_prefix      = "example-cert"
#   certificate_body = "${file("self-ca-cert.pem")}"
#   private_key      = "${file("test-key.pem")}"

#   lifecycle {
#     create_before_destroy = true
#   }
# }

resource "aws_elb" "elb" {
  name = "andys-elb"

  # availability_zones = ["us-east-1a", "us-east-1b", "us-east-1c"]

  listener {
    instance_port     = 8000
    instance_protocol = "http"
    lb_port           = 80
    lb_protocol       = "http"
  }

  # listener {
  #   instance_port      = 8000
  #   instance_protocol  = "http"
  #   lb_port            = 443
  #   lb_protocol        = "https"
  #   ssl_certificate_id = "${aws_iam_server_certificate.cert.arn}"
  # }

  health_check {
    healthy_threshold   = 2
    unhealthy_threshold = 2
    timeout             = 3
    target              = "HTTP:8000/"
    interval            = 30
  }
  security_groups             = ["${aws_security_group.elb-securitygroup.id}"]
  subnets                     = ["${aws_subnet.subnet1.id}", "${aws_subnet.subnet2.id}", "${aws_subnet.subnet3.id}"]
  instances                   = ["${aws_instance.server1.id}", "${aws_instance.server2.id}", "${aws_instance.server3.id}"]
  cross_zone_load_balancing   = true
  idle_timeout                = 400
  connection_draining         = true
  connection_draining_timeout = 400
  tags = {
    Name = "elb"
  }
}
