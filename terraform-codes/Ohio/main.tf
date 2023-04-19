provider "aws" {
  region = "us-east-2"
}

resource "aws_instance" "ohio_1" {
  ami           = "ami-0a695f0d95cefc163"
  instance_type = "t2.micro"
  key_name      = "ohio_key"
  user_data     = <<-EOF
    #!/bin/bash
    sudo apt-get update -y
    sudo apt-get install ruby-full ruby-webrick wget -y 
    cd /tmp 
    wget https://aws-codedeploy-us-east-1.s3.us-east-1.amazonaws.com/releases/codedeploy-agent_1.3.2-1902_all.deb 
    mkdir codedeploy-agent_1.3.2-1902_ubuntu22 
    dpkg-deb -R codedeploy-agent_1.3.2-1902_all.deb codedeploy-agent_1.3.2-1902_ubuntu22 
    sed 's/Depends:.*/Depends:ruby3.0/' -i ./codedeploy-agent_1.3.2-1902_ubuntu22/DEBIAN/control 
    dpkg-deb -b codedeploy-agent_1.3.2-1902_ubuntu22/ 
    sudo dpkg -i codedeploy-agent_1.3.2-1902_ubuntu22.deb 
    systemctl list-units --type=service | grep codedeploy 
    sudo service codedeploy-agent restart
  EOF
  tags = {
    Name = "ohio_1"
  }
}

resource "aws_instance" "ohio_2" {
  ami           = "ami-0a695f0d95cefc163"
  instance_type = "t2.micro"
  key_name      = "ohio_key"
  user_data     = <<-EOF
    #!/bin/bash
    sudo apt-get update -y
    sudo apt-get install ruby-full ruby-webrick wget -y 
    cd /tmp 
    wget https://aws-codedeploy-us-east-1.s3.us-east-1.amazonaws.com/releases/codedeploy-agent_1.3.2-1902_all.deb 
    mkdir codedeploy-agent_1.3.2-1902_ubuntu22 
    dpkg-deb -R codedeploy-agent_1.3.2-1902_all.deb codedeploy-agent_1.3.2-1902_ubuntu22 
    sed 's/Depends:.*/Depends:ruby3.0/' -i ./codedeploy-agent_1.3.2-1902_ubuntu22/DEBIAN/control 
    dpkg-deb -b codedeploy-agent_1.3.2-1902_ubuntu22/ 
    sudo dpkg -i codedeploy-agent_1.3.2-1902_ubuntu22.deb 
    systemctl list-units --type=service | grep codedeploy 
    sudo service codedeploy-agent restart
  EOF
  tags = {
    Name = "ohio_2"
  }
}