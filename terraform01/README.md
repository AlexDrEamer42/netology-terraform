# Домашнее задание к занятию "Введение в Terraform"

Установил Terraform по [инструкции с официального сайта](https://developer.hashicorp.com/terraform/tutorials/aws-get-started/install-cli).

```bash
vagrant@server1:~$ terraform --version
Terraform v1.4.2
on linux_amd64
```
------

### Задание 1

1. Скачал необходимые зависимости: 
    ```bash
    terraform init
    ```
2. Секретную информацию можно сохранить в файле `personal.auto.tfvars`.
3. Выполнил код проекта:
    ```bash
    terraform plan
    ```
    ```bash
    terraform apply
    ```
   Секретное содержимое ресурса:
    ```
    "result": "hd4iB22kEiqWS4lC"
    ```
4. При валидации обнаружены две ошибки:
   1. Строка 24:
       ```
       resource "docker_image" {
       ```
       Не хватает имени ресурса. Исправил на:
       ```
       resource "docker_image" "nginx" {
       ```
   2. Строка 29:
       ```
       resource "docker_container" "1nginx" {
       ```
      Имя ресурса не может начинаться с цифры. Исправил на:
       ```
       resource "docker_container" "nginx1" {
       ```
5. Выполнил код. Вывод команды ```docker ps```:
   ```bash
   vagrant@server1:~/repo/ter-homeworks/01/src$ sudo docker ps
   CONTAINER ID   IMAGE          COMMAND                  CREATED         STATUS         PORTS                  NAMES
   0d9b3ea86be1   904b8cb13b93   "/docker-entrypoint.…"   5 seconds ago   Up 4 seconds   0.0.0.0:8000->80/tcp   example_hd4iB22kEiqWS4lC
   ```
6. Запуск команды `terraform apply` с ключом `--auto-approved` автоматически применяет созданный план. 
Это может повредить созданной инфраструктуре. Например, если после применения исходного плана в инфраструктуру 
были внесены изменения, то изменённый план их удалит.  
7. Уничтожил созданные ресурсы:
    ```bash
    sudo terraform destroy
    ```
    Убедился, что все ресурсы уничтожены:
    ```bash
    vagrant@server1:~/repo/ter-homeworks/01/src$ sudo docker ps
    CONTAINER ID   IMAGE     COMMAND   CREATED   STATUS    PORTS     NAMES
    vagrant@server1:~/repo/ter-homeworks/01/src$ cat terraform.tfstate
    {
      "version": 4,
      "terraform_version": "1.4.2",
      "serial": 23,
      "lineage": "656f41a4-7e78-ab6e-b21c-27206f508f79",
      "outputs": {},
      "resources": [],
      "check_results": null
    }
    ```
8. Образ `nginx` не был удалён, т.к. в настройках ресурса был указан параметр:
   ```
   keep_locally = true
   ```


------

## Дополнительные задания (со звездочкой*)

Изучил документации provider [**Virtualbox**](https://registry.tfpla.net/providers/shekeriev/virtualbox/latest/docs/overview/index) от 
shekeriev. Создал ВМ с Debian:
```terraform
terraform {
  required_providers {
    virtualbox = {
      source = "shekeriev/virtualbox"
      version = "0.0.4"
    }
  }
}

resource "virtualbox_vm" "vm1" {
  name   = "debian-11"
  image  = "https://app.vagrantup.com/shekeriev/boxes/debian-11/versions/0.3/providers/virtualbox.box"
  cpus   = 2
  memory    = "1024 mib"

  network_adapter {
    type           = "hostonly"
    device         = "IntelPro1000MTDesktop"
    host_interface = "vboxnet1"
  }
}
```