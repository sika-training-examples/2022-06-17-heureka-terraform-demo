terraform {
  backend "http" {
    address        = "https://gitlab.sikalabs.com/api/v4/projects/339/terraform/state/dev"
    lock_address   = "https://gitlab.sikalabs.com/api/v4/projects/339/terraform/state/dev/lock"
    unlock_address = "https://gitlab.sikalabs.com/api/v4/projects/339/terraform/state/dev/lock"
    lock_method    = "POST"
    unlock_method  = "DELETE"
    retry_wait_min = 5
  }
}
