category "project" {
  title = "Project"
  icon  = "rebase_edit"
}

locals {
  project_common_tags = {
    service = "GitLab/Project"
  }
}

query "project_count" {
  sql = <<-EOQ
    select
      count(*) as "Projects"
    from
      gitlab_my_project;
  EOQ
}