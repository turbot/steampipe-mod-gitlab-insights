category "group" {
  title = "Group"
}

locals {
  group_common_tags = {
    service = "GitLab/Group"
  }
}

query "group_count" {
  sql = <<-EOQ
    select
      count(*) as "Groups"
    from
      gitlab_group;
  EOQ
}