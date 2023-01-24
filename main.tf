resource "aws_security_group" "minecraft_sg" {
  name        = "minecraft_sg"
  description = "Security group for Minecraft servers"

  ingress {
    from_port   = 25565
    to_port     = 25565
    protocol    = "tcp"
    cidr_blocks = ["0.0.0.0/0"]
  }
}

resource "aws_key_pair" "minecraft_key" {
  key_name   = "minecraft_key"
  public_key = ASIA4NX53ALYB4GWAA64
}

resource "aws_launch_configuration" "minecraft_lc" {
  image_id      = "ami-0ff8a91507f77f867"
  instance_type = "t2.micro"
  security_groups = [aws_security_group.minecraft_sg.name]
  key_name          = aws_key_pair.minecraft_key.key_name
  user_data = <<EOF
#!/bin/bash
apt-get update
apt-get install -y default-jre
wget https://launcher.mojang.com/v1/objects/bb2b6b1aefcd70dfd1892149ac3a215f6c636b07/server.jar
nohup java -Xms512M -Xmx1G -jar server.jar nogui &
EOF
}

resource "aws_auto_scaling_group" "minecraft_asg" {
  name                      = "minecraft_asg"
  launch_configuration      = aws_launch_configuration.minecraft_lc.name
  min_size                  = 2
  max_size                  = 5
  desired_capacity          = 3
  vpc_zone_identifier       = ["subnet-01234567890abcdef0", "subnet-01234567890abcdef1"]
  health_check_type         = "EC2"
}
