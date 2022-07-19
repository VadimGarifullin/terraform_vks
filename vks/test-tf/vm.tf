resource "openstack_compute_keypair_v2" "ssh" {
  name = "terraform_ssh_key"
  public_key = file("${path.module}/terraform.pem.pub")
}

resource "openstack_compute_secgroup_v2" "rules" {
  name = "terraform_test_deploy"
  description = "security group for terraform instance"
  rule {
    from_port = 22
    to_port = 22
    ip_protocol = "tcp"
    cidr = "0.0.0.0/0"
  }
  rule {
    from_port = 80
    to_port = 80
    ip_protocol = "tcp"
    cidr = "0.0.0.0/0"
  }
  rule {
    from_port = -1
    to_port = -1
    ip_protocol = "icmp"
    cidr = "0.0.0.0/0"
  }
}

resource "openstack_blockstorage_volume_v2" "pod_volume" {
  count = "${var.pod_count}"
  # Название диска
  name = "terraform-pod${format("%d", count.index + 1)}"
  # Тип создаваемого диска
  volume_type = "dp1-ssd"
  # Размер диска
  size = "10"
  # uuid индикатор образа, в примере  openstack image list
  image_id = "a5df5943-ee94-426a-abc0-e2fee5b6a349"
}

resource "openstack_compute_instance_v2" "pod" {
  count = "${var.pod_count}"
  name = "terraform-pod${format("%d", count.index + 1)}"
  # Имя и uuid образа с ОС
  image_name = "terraform-test-docker"
  #image_id = 
  # Конфигурация инстанса
  flavor_name = "Basic-1-1-10"
  key_pair = openstack_compute_keypair_v2.ssh.name
  # Указываем, что при создании использовать config drive
  # Без этой опции ВМ не будет создана корректно в сетях без DHCP
  config_drive = true
  security_groups = [
   openstack_compute_secgroup_v2.rules.name
  ]
  network {
    name = "Terraform_network"
  }
  block_device {
    uuid = openstack_blockstorage_volume_v2.pod_volume[count.index].id
    boot_index = 0
    source_type = "volume"
    destination_type = "volume"
    delete_on_termination = true
  }

  #provisioner "remote-exec" {
  #  connection {
  #    host = openstack_compute_instance_v2.instance.access_ip_v4
  #    user = "debian"
  #    private_key = file("${path.module}/terraform.pem")
  #  }
  #  inline = [
  #    "sudo apt-get update",
  #    "sudo apt-get -y install nginx",
  #  ]
  #}
}

output "pod_ips" {
  value = "${openstack_compute_instance_v2.pod.*.access_ip_v4}"
}

