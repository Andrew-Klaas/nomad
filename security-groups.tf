resource "aws_security_group" "nomad_server" {
  name        = "nomad-server-sg-${var.cluster_name}"
  description = "Security Group for Nomad Server Instances"
  vpc_id      = "${var.vpc_id}"

  tags {
    Name         = "Nomad Server (${var.cluster_name})"
    NomadCluster = "${replace(var.cluster_name, " ", "")}"
  }

  # SSH
  ingress {
    from_port   = 22
    to_port     = 22
    protocol    = "tcp"
    cidr_blocks = ["0.0.0.0/0"]
  }

  # Nomad HTTP
  ingress {
    from_port   = 4646
    to_port     = 4646
    protocol    = "tcp"
    cidr_blocks = ["0.0.0.0/0"]
  }

  # Nomad RPC
  ingress {
    from_port = 4647
    to_port   = 4647
    protocol  = "tcp"
    self      = true
  }

  # Nomad Serf
  ingress {
    from_port = 4648
    to_port   = 4648
    protocol  = "tcp"
    self      = true
  }

  # TCP All outbound traffic
  egress {
    from_port   = 0
    to_port     = 65535
    protocol    = "tcp"
    cidr_blocks = ["0.0.0.0/0"]
  }

  # UDP All outbound traffic
  egress {
    from_port   = 0
    to_port     = 65535
    protocol    = "udp"
    cidr_blocks = ["0.0.0.0/0"]
  }

  ############################
  # added for nomad SPARK DEMO
  ############################
  # HDFS NameNode UI
  ingress {
    from_port   = 50070
    to_port     = 50070
    protocol    = "tcp"
    cidr_blocks = ["0.0.0.0/0"]
  }

  # HDFS DataNode UI
  ingress {
    from_port   = 50075
    to_port     = 50075
    protocol    = "tcp"
    cidr_blocks = ["0.0.0.0/0"]
  }

  # Spark history server UI
  ingress {
    from_port   = 18080
    to_port     = 18080
    protocol    = "tcp"
    cidr_blocks = ["0.0.0.0/0"]
  }

  #inter communication between HDFS
  ingress {
    from_port = 0
    to_port   = 0
    protocol  = "-1"
    self      = true
  }
}

resource "aws_security_group" "consul_server" {
  name        = "consul-server-sg"
  description = "Security Group for Consul Server Instances"
  vpc_id      = "${var.vpc_id}"

  tags {
    Name          = "Consul Server (${var.cluster_name})"
    ConsulCluster = "${replace(var.cluster_name, " ", "")}"
  }

  # SSH
  ingress {
    from_port   = 22
    to_port     = 22
    protocol    = "tcp"
    cidr_blocks = ["0.0.0.0/0"]
  }

  # DNS (TCP)
  ingress {
    from_port   = 8600
    to_port     = 8600
    protocol    = "tcp"
    cidr_blocks = ["0.0.0.0/0"]
  }

  # DNS (UDP)
  ingress {
    from_port   = 8600
    to_port     = 8600
    protocol    = "udp"
    cidr_blocks = ["0.0.0.0/0"]
  }

  # HTTP
  ingress {
    from_port   = 8500
    to_port     = 8500
    protocol    = "tcp"
    cidr_blocks = ["0.0.0.0/0"]
  }

  # Serf (TCP)
  ingress {
    from_port   = 8301
    to_port     = 8302
    protocol    = "tcp"
    cidr_blocks = ["0.0.0.0/0"]
  }

  # Serf (UDP)
  ingress {
    from_port   = 8301
    to_port     = 8302
    protocol    = "udp"
    cidr_blocks = ["0.0.0.0/0"]
  }

  # Server RPC
  ingress {
    from_port   = 8300
    to_port     = 8300
    protocol    = "tcp"
    cidr_blocks = ["0.0.0.0/0"]
  }

  # RPC
  ingress {
    from_port   = 8400
    to_port     = 8400
    protocol    = "tcp"
    cidr_blocks = ["0.0.0.0/0"]
  }

  # TCP All outbound traffic
  egress {
    from_port   = 0
    to_port     = 65535
    protocol    = "tcp"
    cidr_blocks = ["0.0.0.0/0"]
  }

  # UDP All outbound traffic
  egress {
    from_port   = 0
    to_port     = 65535
    protocol    = "udp"
    cidr_blocks = ["0.0.0.0/0"]
  }
}
