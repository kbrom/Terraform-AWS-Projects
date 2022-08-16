#Create and bootstrap webserver
resource "aws_instance" "webserver" {
  ami                         = "ami-052efd3df9dad4825"
  instance_type               = "t2.xlarge"
  key_name                    = aws_key_pair.webserver-key.key_name
  associate_public_ip_address = true
  vpc_security_group_ids      = [aws_security_group.sg.id]
  subnet_id                   = aws_subnet.subnet.id
  provisioner "remote-exec" {
    inline = [
    "sudo apt-get update -y",
    "sudo apt-get install openssh-server -y",
    "sudo apt-get install net-tools -y",
    "sudo apt-get install curl jq -y ",
   /* "curl -sfL https://get.k3s.io | sudo bash -",
    "sudo chmod 644 /etc/rancher/k3s/k3s.yaml",
    "sudo apt update -y ",
    "sudo apt install git build-essential -y",
    "git clone https://github.com/ansible/awx-operator.git" */
    ]
    connection {
      type        = "ssh"
      user        = "ubuntu"
      private_key = file("~/.ssh/id_rsa")
      host        = self.public_ip
    }
  }
  tags = {
    Name = "webserver"
  }
}
