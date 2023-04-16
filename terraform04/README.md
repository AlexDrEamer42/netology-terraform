# Домашнее задание к занятию "Использование Terraform в команде"

### Задание 1

Проверьте код из лекции 4 с помощью tflint и checkov. 

Типы ошибок, выявленные tflint:

- Warning: Missing version constraint for provider 
- Warning: variable is declared but not used
- Warning: Module source uses a default branch as ref (main) 

Типы ошибок, выявленные checkov:

- Check: CKV_YC_4: "Ensure compute instance does not have serial console enabled."
- Check: CKV_YC_2: "Ensure compute instance does not have public IP."
- Check: CKV_YC_11: "Ensure security group is assigned to network interface."

### Задание 2

Создал ветку terraform-05, закомитил изменения.
Открыл в проекте terraform console, в другом окне из этой же директории запустил terraform apply.
Ответ об ошибке доступа к State:

```
Acquiring state lock. This may take a few moments...
╷
│ Error: Error acquiring the state lock
│ 
│ Error message: ConditionalCheckFailedException: Condition not satisfied
│ Lock Info:
│   ID:        5819dee0-eb92-15f4-2903-76aec4f458d2
│   Path:      tfstate-develop-42/terraform.tfstate
│   Operation: OperationTypeInvalid
│   Who:       alex@example
│   Version:   1.3.7
│   Created:   2023-04-12 13:59:58.07622098 +0000 UTC
│   Info:      
│ 
│ 
│ Terraform acquires a state lock to protect the state from being written
│ by multiple users at the same time. Please resolve the issue above and try
│ again. For most commands, you can disable locking with the "-lock=false"
│ flag, but this is not recommended.
```
Принудительно разблокировал State:
```
terraform force-unlock 5819dee0-eb92-15f4-2903-76aec4f458d2
```
```
Do you really want to force-unlock?
  Terraform will remove the lock on the remote state.
  This will allow local Terraform commands to modify this state, even though it
  may still be in use. Only 'yes' will be accepted to confirm.

  Enter a value: yes

Terraform state has been successfully unlocked!

The state has been unlocked, and Terraform commands should now be able to
obtain a new lock on the remote state.
```
Проверил выполнение terraform apply:
```
Acquiring state lock. This may take a few moments...
data.template_file.cloudinit: Reading...

...

No changes. Your infrastructure matches the configuration.

Terraform has compared your real infrastructure against your configuration and found no differences, so no changes are needed.
Releasing state lock. This may take a few moments...

Apply complete! Resources: 0 added, 0 changed, 0 destroyed.
```
### Задание 3

1. Создал ветку 'terraform-hotfix'.
2. Проверил код с помощью tflint и checkov.
3. Исправил предупреждения и ошибки:
    1. Прописал версию для провайдеров "yandex" и "template".
    2. Изменил ветку для источника в модуле test-vm.
    3. Удалил неиспользуемые переменные.
    4. Отключил публичный IP-адрес для ВМ в модуле test_vm.
    5. Добавил группу безопасности для ВМ в модуле test_vm.
4. Создал PR: https://github.com/AlexDrEamer42/netology-terraform/pull/1

### Задание 4*

Создал переменные с валидацией в файле [var_validation.tf](./src/var_validation.tf)