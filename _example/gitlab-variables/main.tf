terraform {
  required_providers {
    gitlab = {
      source  = "gitlabhq/gitlab"
      version = "3.15.1"
    }
    random = {
      source  = "hashicorp/random"
      version = "3.3.1"
    }
  }
}

provider "gitlab" {
  token    = "glpat-KnH3HBmYFefWhSek4k3f"
  base_url = "https://gitlab.sikalabs.com/api/v4/"
}

resource "random_password" "password" {
  length  = 20
  special = false
}

resource "gitlab_project_variable" "example" {
  for_each = {
    "PASSWORD" = random_password.password.result
    FOO        = "hello"
    BAR        = "xxx"
  }
  project   = "339"
  key       = each.key
  value     = each.value
  protected = false
}
