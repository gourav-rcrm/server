provider "aws" {
  region = "ap-south-1"
}

resource "aws_instance" "mumbai_1" {
  ami           = "ami-02eb7a4783e7e9317"
  instance_type = "t2.micro"
  key_name      = "EC2Tutorial"
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
    sudo service codedeploy-agent status
  EOF
  tags = {
    Name = "mumbai_1"
  }
}

resource "aws_instance" "mumbai_2" {
  ami           = "ami-02eb7a4783e7e9317"
  instance_type = "t2.micro"
  key_name      = "EC2Tutorial"
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
    sudo service codedeploy-agent status
  EOF
  tags = {
    Name = "mumbai_2"
  }
}