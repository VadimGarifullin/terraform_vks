data "template_file" "hosts" {
  template = "${file("${path.module}/ansible/hosts.cfg")}"
  depends_on = [
    openstack_compute_instance_v2.pod,
  ]
  
  vars = {
    pods  =  "${join(",", openstack_compute_instance_v2.pod.*.access_ip_v4)}"
  
  }
}

resource "null_resource" "dev-hosts" {
  triggers = {
    template_rendered = "${data.template_file.hosts.rendered}"
  }
  provisioner "local-exec" {
    command = "echo '${data.template_file.hosts.rendered}' > ansible/hosts"
  }
}

resource "null_resource" "format_hosts" {
  depends_on = [
    data.template_file.hosts
  ]
  provisioner "local-exec" {
    command = "./format.sh"
  }
  
}