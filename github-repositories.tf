resource "github_repository" "alaz" {
  name        = "alaz"
  description = "Root repository for the cloud challenge backend"

  visibility = "public"
  auto_init = true
}


resource "github_branch" "staging" {
  repository = github_repository.alaz.name
  branch     = "staging"
}

resource "github_branch_default" "default"{
  repository = github_repository.alaz.name
  branch     = "main"
}


resource "github_branch_protection" "main" {
  repository_id = github_repository.alaz.name

  pattern          = "main"
  enforce_admins   = true
  allows_deletions = false

#  required_status_checks {
#    strict   = false
#    contexts = ["ci/travis"]
#  }

#  required_pull_request_reviews {
#    dismiss_stale_reviews  = true
#    restrict_dismissals    = true
#    dismissal_restrictions = [
#      data.github_user.example.node_id,
#      github_team.example.node_id,
#    ]
#  }

#  push_restrictions = [
#    data.github_user.example.node_id,
#    # limited to a list of one type of restriction (user, team, app)
#    # github_team.example.node_id
#  ]

}

resource "github_branch_protection" "staging" {
  repository_id = github_repository.alaz.name

  pattern          = "staging"
  enforce_admins   = true
  allows_deletions = false
}
