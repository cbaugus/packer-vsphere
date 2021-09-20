provider "vsphere" {
  user           = var.vsphere_user
  password       = var.vsphere_pass
  vsphere_server = var.vsphere_server
  # If you have a self-signed cert
  allow_unverified_ssl = true
  client_debug         = true
}

// provider "vault" {
//   address = var.vault_server_url
//   auth_login {
//     path = "auth/approle/login"
//
//     parameters = {
//       role_id   = var.vault_approle_id
//       secret_id = var.vault_approle_secret_id
//     }
//   }
// }
