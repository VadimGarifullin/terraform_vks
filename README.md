## Базовый репозиторий с описанием инфраструктуры terraform и ansible


Нужные провайдеры залиты в репозиторий, в директории plugins, для их использования нужно создать файл .terraformrc в домашней папке своего пользователя
```
touch ~/.terraformrc
```

### В файле должно находиться следующее
```
provider_installation {
  network_mirror {
    url = "https://hub.mcs.mail.ru/repository/terraform-providers/"
    include = ["vk-cs/*"]
  }
  filesystem_mirror {
    path    = "/opt/terraform/plugins/"
    include = ["registry.terraform.io/*/*"]

  }
}
```
Этого будет достаточно, при использовании terraform init, провайдеры будут браться из локальных испочников, в случае hashicorp providers, будет работать без vpn) Обратите внимание только на path, у вас будет другой путь скорее всего, либо файлы репозитория должны быть склонированы в /opt/terraform/

Установка terraform:
https://learn.hashicorp.com/tutorials/terraform/install-cli

Скачать провайдера:
https://releases.hashicorp.com/

# mkdir -p /root/.local/share/terraform/plugins/registry.terraform.io/terraform-provider-openstack/openstack/1.40.0/linux_amd64/
# curl -L https://releases.hashicorp.com/terraform-provider-openstack/1.40.0/terraform-provider-openstack_1.40.0_linux_amd64.zip -o terraform-provider-openstack.zip
# unzip terraform-provider-openstack.zip
# mv terraform-provider-openstack_v1.40.0 /root/.local/share/terraform/plugins/registry.terraform.io/terraform-provider-openstack/openstack/1.40.0/linux_amd64/
# terraform providers mirror /root/.local/share/terraform/plugins/
