## Базовый репозиторий с описанием инфраструктуры terraform и ansible


Нужные провайдеры залиты в репозиторий, в директории plugins, для их использования нужно создать файл .terraformrc в домашней папке своего пользователя
```
touch ~/.terraformrc
```

###В файле должно находиться следующее
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
Этого будет достаточно, при использовании terraform init, провайдеры будут браться из локальных испочников, в случае hashicorp providers, будет работать без vpn)

Установка terraform:
https://learn.hashicorp.com/tutorials/terraform/install-cli
