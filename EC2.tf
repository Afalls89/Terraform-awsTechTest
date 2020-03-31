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

  # provisioner "file" {
  #   content     = "<html><body>EC2 instance server1</body></html>"
  #   destination = "/var/www/html/index.html"
  # }

  user_data = "#/bin/bash\napt-get install nginx\nMYIP=`ifconfig | grep 'addr:10' | awk '{print $2}' | cut -d':' -f2¬\necho 'this is: '$MYIP > /var/www/html/index.html"
  tags = {
    Name = "server1"
  }
}

resource "aws_instance" "server2" {
  ami                    = "${data.aws_ami.ubuntu.id}"
  instance_type          = "t2.micro"
  subnet_id              = "${aws_subnet.subnet2.id}"
  vpc_security_group_ids = ["${aws_security_group.servers.id}"]

  # provisioner "file" {
  #   content     = "<html><body>EC2 instance server2</body></html>"
  #   destination = "/var/www/html/index.html"
  # }
  user_data = "#/bin/bash\napt-get install nginx\nMYIP=`ifconfig | grep 'addr:10' | awk '{print $2}' | cut -d':' -f2¬\necho 'this is: '$MYIP > /var/www/html/index.html"

  tags = {
    Name = "server2"
  }
}

resource "aws_instance" "server3" {
  ami                    = "${data.aws_ami.ubuntu.id}"
  instance_type          = "t2.micro"
  subnet_id              = "${aws_subnet.subnet3.id}"
  vpc_security_group_ids = ["${aws_security_group.servers.id}"]

  #   connection {
  #   type        = "ssh"
  #   user        = "ec2-user"
  #   private_key = file("~/.ssh/terraform")
  #   host        = self.public_ip
  # }


  # provisioner "file" {
  #   content     = "<html><body>EC2 instance server3</body></html>"
  #   destination = "/var/www/html/index.html"
  # }

  user_data = "#/bin/bash\napt-get install nginx\nMYIP=`ifconfig | grep 'addr:10' | awk '{print $2}' | cut -d':' -f2¬\necho 'this is: '$MYIP > /var/www/html/index.html"
  tags = {
    Name = "server3"
  }
}
