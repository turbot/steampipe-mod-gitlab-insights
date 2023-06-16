dashboard "project_access_request_report" {
  title = "GitLab Project Access Request Report"
  documentation = file("./dashboards/project/docs/project_report_access_request.md")

  tags = merge(local.project_common_tags, {
    type     = "Report"
    category = "Security"
  })

  container {
    card {
      query = query.project_count
      width = 2
    }

    card {
      query = query.project_access_request_count
      width = 2
    }
  }

  container {
    table {
      title = "Project Access Requests"
      query = query.project_access_request_table

      column "web_url" {
        display = "none"
      }

      column "Project" {
        href = "{{.'web_url'}}"
      }
    }
  }
}

query "project_access_request_count" {
  sql = <<-EOQ
    select
      'Active Requests' as label,
      count(r.*) as value,
      case
        when count(r.*) > 0 then 'alert'
        else 'ok'
      end as type
    from
      gitlab_project p
    join
      gitlab_project_access_request r
    on p.id = r.project_id
    where
      r.state = 'active';
  EOQ
}

query "project_access_request_table" {
  sql = <<-EOQ
    select
      p.full_path as "Project",
      r.username as "User",
      r.access_level_description as "Requested Access",
      now()::date - r.requested_at::date as "Age in Days",
      p.web_url
    from
      gitlab_project p
    join
      gitlab_project_access_request r
    on p.id = r.project_id
    where
      r.state = 'active';
  EOQ
}