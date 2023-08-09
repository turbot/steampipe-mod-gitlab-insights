dashboard "merge_request_open_age_report" {
  title = "GitLab Open Merge Request Age Report"
  documentation = file("./dashboards/merge_request/docs/merge_request_report_age.md")

  tags = merge(local.merge_request_common_tags, {
    type     = "Report"
    category = "Age"
  })

  container {
    card {
      query = query.open_merge_request_count
      width = 2
    }

    card {
      query = query.open_merge_request_24_hours_count
      width = 2
      type  = "info"
    }

    card {
      query = query.open_merge_request_30_days_count
      width = 2
      type  = "info"
    }

    card {
      query = query.open_merge_request_30_90_days_count
      width = 2
      type  = "info"
    }

    card {
      query = query.open_merge_request_90_365_days_count
      width = 2
      type  = "info"
    }

    card {
      query = query.open_merge_request_1_year_count
      width = 2
      type  = "info"
    }
  }

  container {
    table {
      title = "Open Merge Requests"
      query = query.open_merge_request_table

      column "web_url" {
        display = "none"
      }

      column "project_url" {
        display = "none"
      }

      column "Merge Request" {
        href = "{{.'web_url'}}"
      }

      column "Project" {
        href = "{{.'project_url'}}"
      }
    }
  }
}

query "open_merge_request_count" {
  sql = <<-EOQ
    select
      count(m.*) as value,
      'Open Merge Requests' as label
    from
      gitlab_my_project p
      join gitlab_merge_request m on m.project_id = p.id
    where
      m.state = 'opened';
  EOQ
}

query "open_merge_request_24_hours_count" {
  sql = <<-EOQ
    select
      '< 24 Hours' as label,
      count(m.*) as value
    from
      gitlab_my_project p
      join gitlab_merge_request m on m.project_id = p.id
    where
      m.state = 'opened'
      and m.created_at > now() - '1 days'::interval;
  EOQ
}

query "open_merge_request_30_days_count" {
  sql = <<-EOQ
    select
      '1-30 Days' as label,
      count(m.*) as value
    from
      gitlab_my_project p
      join gitlab_merge_request m on m.project_id = p.id
    where
      m.state = 'opened'
      and m.created_at between symmetric now() - '1 days' :: interval and now() - '30 days' :: interval;
  EOQ
}

query "open_merge_request_30_90_days_count" {
  sql = <<-EOQ
    select
      '30-90 Days' as label,
      count(m.*) as value
    from
      gitlab_my_project p
      join gitlab_merge_request m on m.project_id = p.id
    where
      m.state = 'opened'
      and m.created_at between symmetric now() - '30 days' :: interval and now() - '90 days' :: interval;
  EOQ
}

query "open_merge_request_90_365_days_count" {
  sql = <<-EOQ
    select
      '90-365 Days' as label,
      count(m.*) as value
    from
      gitlab_my_project p
      join gitlab_merge_request m on m.project_id = p.id
    where
      m.state = 'opened'
      and m.created_at  between symmetric now() - '90 days' :: interval and now() - '365 days' :: interval;
  EOQ
}

query "open_merge_request_1_year_count" {
  sql = <<-EOQ
    select
      '> 1 Year' as label,
      count(m.*) as value
    from
      gitlab_my_project p
      join gitlab_merge_request m on m.project_id = p.id
    where
      m.state = 'opened'
      and m.created_at <= now() - '1 year' :: interval;
  EOQ
}

query "open_merge_request_table" {
  sql = <<-EOQ
    select
      p.full_path as "Project",
      m.title as "Merge Request",
      now()::date - m.created_at::date as "Age in Days",
      now()::date - m.updated_at::date as "Days Since Last Update",
      author_username as "Author",
      m.web_url,
      p.web_url as project_url
    from
      gitlab_my_project p
      join gitlab_merge_request m on m.project_id = p.id
    where
      m.state = 'opened'
    order by
      "Age in Days" desc;
  EOQ
}