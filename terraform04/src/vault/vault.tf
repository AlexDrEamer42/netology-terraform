provider "vault" {
  address         = "http://127.0.0.1:8200"
  skip_tls_verify = true
  token           = "education"
}
data "vault_generic_secret" "vault_example" {
  path = "secret/example"
}

output "vault_example" {
  #value = "${nonsensitive(data.vault_generic_secret.vault_example.data)}"
  value = nonsensitive(data.vault_generic_secret.vault_example.data.test)
}

resource "vault_generic_secret" "example2" {
  data_json = file("${path.module}/secret.json")
  path      = "secret/test"
}
