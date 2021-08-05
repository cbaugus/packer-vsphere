provider "vsphere" {
  user           = var.vsphere_user
  password       = var.vsphere_pass
  vsphere_server = var.vsphere_server
  # If you have a self-signed cert
  allow_unverified_ssl = true
  client_debug         = true
}

// provider "vault" {
//   auth_login {
//     path = "auth/userpass/login/${var.login_username}"
//
//     parameters = {
//       password = var.login_password
//     }
//   }
// }
