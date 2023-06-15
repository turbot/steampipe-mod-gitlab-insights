dashboard "issue_open_age_report" {
  title = "GitLab Open Issues Age Report"
  documentation = file("./dashboards/issue/docs/issue_report_age.md")

  tags = merge(local.issue_common_tags, {
    type     = "Report"
    category = "Age"
  })

  container {
    card {
      query = query.open_issue_count
      width = 2
    }

    card {
      query = query.open_issue_24_hours_count
      width = 2
      type  = "info"
    }

    card {
      query = query.open_issue_30_days_count
      width = 2
      type  = "info"
    }

    card {
      query = query.open_issue_30_90_days_count
      width = 2
      type  = "info"
    }

    card {
      query = query.open_issue_90_365_days_count
      width = 2
      type  = "info"
    }

    card {
      query = query.open_issue_1_year_count
      width = 2
      type  = "info"
    }
  }

  container {
    table {
      title = "Open Issues"
      query = query.open_issue_table

      column "web_url" {
        display = "none"
      }

      column "project_url" {
        display = "none"
      }

      column "Issue" {
        href = "{{.'web_url'}}"
      }

      column "Project" {
        href = "{{.'project_url'}}"
      }
    }
  }
}

query "open_issue_count" {
  sql = <<-EOQ
    select
      count(i.*) as value,
      'Open Issues' as label
    from
      gitlab_my_project p
    join 
      gitlab_issue i
    on 
      i.project_id = p.id
    where
      i.state = 'opened';
  EOQ
}

query "open_issue_24_hours_count" {
  sql = <<-EOQ
    select
      '< 24 Hours' as label,
      count(i.*) as value
    from
      gitlab_my_project p
    join 
      gitlab_issue i
    on 
      i.project_id = p.id
    where
      i.state = 'opened'
    and 
      i.created_at > now() - '1 days'::interval;
  EOQ
}

query "open_issue_30_days_count" {
  sql = <<-EOQ
    select
      '1-30 Days' as label,
      count(i.*) as value
    from
      gitlab_my_project p
    join 
      gitlab_issue i
    on 
      i.project_id = p.id
    where
      i.state = 'opened'
    and 
      i.created_at between symmetric now() - '1 days' :: interval and now() - '30 days' :: interval;
  EOQ
}

query "open_issue_30_90_days_count" {
  sql = <<-EOQ
    select
      '30-90 Days' as label,
      count(i.*) as value
    from
      gitlab_my_project p
    join 
      gitlab_issue i
    on 
      i.project_id = p.id
    where
      i.state = 'opened'
    and 
      i.created_at between symmetric now() - '30 days' :: interval and now() - '90 days' :: interval;
  EOQ
}

query "open_issue_90_365_days_count" {
  sql = <<-EOQ
    select
      '90-365 Days' as label,
      count(i.*) as value
    from
      gitlab_my_project p
    join 
      gitlab_issue i
    on 
      i.project_id = p.id
    where
      i.state = 'opened'
    and 
      i.created_at  between symmetric now() - '90 days' :: interval and now() - '365 days' :: interval;
  EOQ
}

query "open_issue_1_year_count" {
  sql = <<-EOQ
    select
      '> 1 Year' as label,
      count(i.*) as value
    from
      gitlab_my_project p
    join 
      gitlab_issue i
    on 
      i.project_id = p.id
    where
      i.state = 'opened'
    and 
      i.created_at <= now() - '1 year' :: interval;
  EOQ
}

query "open_issue_table" {
  sql = <<-EOQ
    select
      title as "Issue",
      p.full_path as "Project",
      now()::date - i.created_at::date as "Age in Days",
      now()::date - i.updated_at::date as "Days Since Last Update",
      author as "Author",
      i.web_url,
      p.web_url as project_url
    from
      gitlab_my_project p
    join 
      gitlab_issue i
    on 
      i.project_id = p.id
    where
      i.state = 'opened'
    order by
      "Age in Days" desc
  EOQ
}