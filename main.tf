terraform {
  required_providers {
    aws = {
      source = "hashicorp/aws"
      version = "5.76.0"
    }
  }
}

provider "aws" {
  access_key = "sua access key"
  secret_key = "sua secret key"
  region = "us-east-1"
}

resource "aws_vpc" "hamburgueria_vpc" {
  cidr_block = "10.0.0.0/16"
  tags = {
    Name = "Hamburgueria-vpc"
  }
}

resource "aws_subnet" "hamburgueria_subnet_public" {
  vpc_id = aws_vpc.hamburgueria_vpc.id
  cidr_block = "10.0.1.0/24"
  availability_zone = "us-east-1a"
  map_public_ip_on_launch = true
  tags = {
    Name = "Hamburgueria-subnet-public"
  }
}

resource "aws_subnet" "hamburgueria_subnet_private" {
  vpc_id = aws_vpc.hamburgueria_vpc.id
  cidr_block = "10.0.2.0/24"
  availability_zone = "us-east-1b"
  map_public_ip_on_launch = false
  tags = {
    Name = "Hamburgueria-subnet-private"
  }
}

resource "aws_subnet" "hamburgueria_subnet_private2" {
  vpc_id = aws_vpc.hamburgueria_vpc.id
  cidr_block = "10.0.3.0/24"
  availability_zone = "us-east-1c"
  map_public_ip_on_launch = false
  tags = {
    Name = "Hamburgueria-subnet-private-2"
  }
}

resource "aws_db_subnet_group" "hamburgueria_db_subnet" {
  name = "hamburgueria-db-subnet"
  subnet_ids = [aws_subnet.hamburgueria_subnet_private.id, aws_subnet.hamburgueria_subnet_private2.id]
  tags = {
    Name = "Hamburgueria-db-subnet"
  }
}

resource "aws_internet_gateway" "hamburguer_igw" {
  vpc_id = aws_vpc.hamburgueria_vpc.id 
  tags = {
    Name = "Hamburgueria-igw"
  }
}

resource "aws_route_table" "hamburgueria_route_table_public" {
  vpc_id = aws_vpc.hamburgueria_vpc.id
  route {
    cidr_block = "0.0.0.0/0"
    gateway_id = aws_internet_gateway.hamburguer_igw.id
  }
  tags = {
    Name = "Hamburgueria-rt-public"
  }
}

resource "aws_route_table" "hamburgueria_route_table_private" {
  vpc_id = aws_vpc.hamburgueria_vpc.id
  tags = {
    Name = "Hamburgueria-rt-private"
  }
}

resource "aws_route_table_association" "rt_private" {
  subnet_id = aws_subnet.hamburgueria_subnet_private.id
  route_table_id = aws_route_table.hamburgueria_route_table_private.id
}

resource "aws_route_table_association" "rt_public" {
  subnet_id = aws_subnet.hamburgueria_subnet_public.id
  route_table_id = aws_route_table.hamburgueria_route_table_public.id
}

resource "aws_security_group" "hamburgueria_sg" {
  name = "Hamburgueria-sg"
  vpc_id = aws_vpc.hamburgueria_vpc.id

  ingress {
    from_port = 80
    to_port = 80
    protocol = "tcp"
    cidr_blocks = ["0.0.0.0/0"]
  }

  ingress {
    from_port = 443
    to_port = 443
    protocol = "tcp"
    cidr_blocks = ["0.0.0.0/0"]
    }

  ingress {
    from_port = 22
    to_port = 22
    protocol = "tcp"
    cidr_blocks = ["0.0.0.0/0"]
  }

  ingress {
    from_port = 3306
    to_port = 3306
    protocol = "tcp"
    cidr_blocks = ["0.0.0.0/0"]
  }

  egress {
    from_port = 0
    to_port  = 0
    protocol = "-1"  # -1 significa todos os protocolos
    cidr_blocks = ["0.0.0.0/0"]
  }
  tags = {
    Name = "Hamburgueria-sg"
  }
}

resource "aws_instance" "hamburgueria_instance" {
  ami = "ami-005fc0f236362e99f"
  instance_type = "t2.micro"
  subnet_id = aws_subnet.hamburgueria_subnet_public.id
  vpc_security_group_ids = [aws_security_group.hamburgueria_sg.id]
  key_name = "sua secret key"
  user_data = <<-EOF
    #!/bin/bash
    sudo apt update -y
    sudo apt install -y python3 python3-pip apache2 mysql-client mysql-server
    sudo pip3 install flask mysql-connector-python
    sudo systemctl start apache2
    sudo systemctl enable apache2
    echo "Instalado com sucesso" > /var/www/html/index.html
    EOF
    tags = {
    Name = "Hamburgueria-instance"
  }
}

resource "aws_db_instance" "hamburgueria_db" {
  engine = "mysql"
  engine_version = "8.0.39"
  instance_class = "db.t4g.micro"
  allocated_storage = 20
  db_name = "hamburgueriadb"
  username = "admin"
  password = "adminpassword"
  multi_az = false
  skip_final_snapshot = true
  vpc_security_group_ids = [aws_security_group.hamburgueria_sg.id]
  db_subnet_group_name = aws_db_subnet_group.hamburgueria_db_subnet.name
  tags = {
    Name = "Hamburgueria-db"
  }
}