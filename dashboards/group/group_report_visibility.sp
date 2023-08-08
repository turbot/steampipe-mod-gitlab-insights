dashboard "group_visibility_report" {
  title = "GitLab Group Visibility Report"
  documentation = file("./dashboards/group/docs/group_report_visibility.md")

  tags = merge(local.group_common_tags, {
    type = "Report"
  })

  container {
    card {
      query = query.group_count
      width = 3
    }

    card {
      query = query.group_public_count
      width = 3
    }

    card {
      query = query.group_private_count
      width = 3
    }

    card {
      query = query.group_internal_count
      width = 3
    }
  }

  container {
    table {
      title = "Group Visibility"
      query = query.group_visibility_table

      column "web_url" {
        display = "none"
      }

      column "Group" {
        href = "{{.'web_url'}}"
      }
    }
  }
}

query "group_public_count" {
  sql = <<-EOQ
    select
      'Public' as label,
      count(*) as value
    from
      gitlab_group
    where
      visibility = 'public';
  EOQ
}

query "group_private_count" {
  sql = <<-EOQ
    select
      'Private' as label,
      count(*) as value
    from
      gitlab_group
    where
      visibility = 'private';
  EOQ
}

query "group_internal_count" {
  sql = <<-EOQ
    select
      'Internal' as label,
      count(*) as value
    from
      gitlab_group
    where
      visibility = 'internal';
  EOQ
}

query "group_visibility_table" {
  sql = <<-EOQ
    select
      full_path as "Project",
      visibility as "Visibility",
      web_url
    from
      gitlab_group
    order by
      visibility desc;
  EOQ
}