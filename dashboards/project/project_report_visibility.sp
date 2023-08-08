dashboard "project_visibility_report" {
  title = "GitLab Project Visibility Report"
  documentation = file("./dashboards/project/docs/project_report_visibility.md")

  tags = merge(local.project_common_tags, {
    type = "Report"
  })

  container {
    card {
      query = query.project_count
      width = 3
    }

    card {
      query = query.project_public_count
      width = 3
    }

    card {
      query = query.project_private_count
      width = 3
    }

    card {
      query = query.project_internal_count
      width = 3
    }
  }

  container {
    table {
      title = "Project Visibility"
      query = query.project_visibility_table

      column "web_url" {
        display = "none"
      }

      column "Project" {
        href = "{{.'web_url'}}"
      }
    }
  }
}

query "project_public_count" {
  sql = <<-EOQ
    select
      'Public' as label,
      count(*) as value,
      case
        when count(*) > 0 then 'alert'
        else 'ok'
      end as type
    from
      gitlab_my_project
    where
      visibility = 'public';
  EOQ
}

query "project_private_count" {
  sql = <<-EOQ
    select
      'Private' as label,
      count(*) as value
    from
      gitlab_my_project
    where
      visibility = 'private';
  EOQ
}

query "project_internal_count" {
  sql = <<-EOQ
    select
      'Internal' as label,
      count(*) as value
    from
      gitlab_my_project
    where
      visibility = 'internal';
  EOQ
}

query "project_visibility_table" {
  sql = <<-EOQ
    select
      full_path as "Project",
      visibility as "Visibility",
      web_url
    from
      gitlab_my_project
    order by
      visibility desc;
  EOQ
}