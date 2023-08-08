dashboard "group_access_request_report" {
  title = "GitLab Group Access Request Report"
  documentation = file("./dashboards/group/docs/group_report_access_request.md")

  tags = merge(local.group_common_tags, {
    type     = "Report"
    category = "Security"
  })

  container {
    card {
      query = query.group_count
      width = 3
    }

    card {
      query = query.group_access_request_count
      width = 3
    }
  }

  container {
    table {
      title = "Group Access Requests"
      query = query.group_access_request_table

      column "web_url" {
        display = "none"
      }

      column "Group" {
        href = "{{.'web_url'}}"
      }
    }
  }
}

query "group_access_request_count" {
  sql = <<-EOQ
    select
      'Active Requests' as label,
      count(r.*) as value,
      case
        when count(r.*) > 0 then 'alert'
        else 'ok'
      end as type
    from
      gitlab_group g
      join gitlab_group_access_request r on g.id = r.group_id
    where
      r.state = 'active';
  EOQ
}

query "group_access_request_table" {
  sql = <<-EOQ
    select
      g.full_path as "Group",
      r.username as "User",
      r.access_level_description as "Requested Access",
      now()::date - r.requested_at::date as "Age in Days",
      g.web_url
    from
      gitlab_group g
      join gitlab_group_access_request r on g.id = r.group_id
    where
      r.state = 'active';
  EOQ
}