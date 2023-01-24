provider "aws" {
  region = "us-east-1"
}

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

#CloudWatch

#RAM
resource "aws_cloudwatch_metric_alarm" "RAM" {
  alarm_name                = "Alerte RAM 70% d'utilisation"
  comparison_operator       = "GreaterThanOrEqualToThreshold"
  evaluation_periods        = "2"
  metric_name               = "MemoryUtilization"
  namespace                 = "AWS/EC2"
  period                    = "60"
  statistic                 = "SampleCount"
  threshold                 = "70"
  alarm_description         = "This metric monitors ec2 ram utilization"
alarm_actions  =  [aws_sns_topic.RAM.arn]
}

resource "aws_sns_topic" "RAM" {
  name = "RAM_alerte"
}

resource "aws_sns_topic_subscription" "RAM_Alerte" {
  topic_arn = aws_sns_topic.RAM.arn
  protocol  = "email"
  endpoint  = "jules.hautcoeur@viacesi.fr"
}

#CPU
resource "aws_cloudwatch_metric_alarm" "CPU_Alerte" {
  alarm_name                = "Alerte RAM 70% d'utilisation"
  comparison_operator       = "GreaterThanOrEqualToThreshold"
  evaluation_periods        = "2"
  metric_name               = "CPUUtilization"
  namespace                 = "AWS/EC2"
  period                    = "60"
  statistic                 = "SampleCount"
  threshold                 = "70"
  alarm_description         = "This metric monitors ec2 ram utilization"
alarm_actions  =  [aws_sns_topic.CPU.arn]
}

resource "aws_sns_topic" "CPU" {
  name = "CPU_alerte"
}

resource "aws_sns_topic_subscription" "CPU_Alerte" {
  topic_arn = aws_sns_topic.CPU.arn
  protocol  = "email"
  endpoint  = "jules.hautcoeur@viacesi.fr"
}

#fin CloudWatch

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
