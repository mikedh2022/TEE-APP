output "organization" {
  value = "${var.github_organization}"
}

output "repo" {
  value = {
    hello_world     = "${github_repository.hello.name}"


  }
}

output "token" {
  value     = "${var.github_token}"
  sensitive = true
}
