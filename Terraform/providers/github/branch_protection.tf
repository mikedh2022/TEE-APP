resource "github_branch_protection" "hello" {
  repository     = "${github_repository.hello.name}"
  branch         = "master"
  enforce_admins = false
}
