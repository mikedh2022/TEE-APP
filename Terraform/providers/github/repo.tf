resource "github_repository" "hello" {
    name          = "hello-world"
  description   = "hello world service"
  topics        = ["django", "python", "tuto"]
  has_downloads = false
  has_wiki      = true
  has_issues    = true
  private       = false

  lifecycle {
    prevent_destroy = true
  }
}

