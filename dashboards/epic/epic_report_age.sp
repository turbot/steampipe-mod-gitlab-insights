dashboard "epic_open_age_report" {
  title = "GitLab Open Epics Age Report"
  documentation = file("./dashboards/epic/docs/epic_report_age.md")

  tags = merge(local.epic_common_tags, {
    type     = "Report"
    category = "Age"
  })

  container {
    card {
      query = query.open_epic_count
      width = 2
    }

    card {
      query = query.open_epic_24_hours_count
      width = 2
      type  = "info"
    }

    card {
      query = query.open_epic_30_days_count
      width = 2
      type  = "info"
    }

    card {
      query = query.open_epic_30_90_days_count
      width = 2
      type  = "info"
    }

    card {
      query = query.open_epic_90_365_days_count
      width = 2
      type  = "info"
    }

    card {
      query = query.open_epic_1_year_count
      width = 2
      type  = "info"
    }
  }

  container {
    table {
      title = "Open Epics"
      query = query.open_epic_table

      column "web_url" {
        display = "none"
      }

      column "group_url" {
        display = "none"
      }

      column "Epic" {
        href = "{{.'web_url'}}"
      }

      column "Group" {
        href = "{{.'group_url'}}"
      }
    }
  }
}


query "open_epic_count" {
  sql = <<-EOQ
    select
      count(e.*) as value,
      'Open Epics' as label
    from
      gitlab_group g
    join 
      gitlab_epic e
    on 
      e.group_id = g.id
    where
      e.state = 'opened';
  EOQ
}

query "open_epic_24_hours_count" {
  sql = <<-EOQ
    select
      '< 24 Hours' as label,
      count(e.*) as value
    from
      gitlab_group g
    join 
      gitlab_epic e
    on 
      e.group_id = g.id
    where
      e.state = 'opened'
    and 
      e.created_at > now() - '1 days'::interval;
  EOQ
}

query "open_epic_30_days_count" {
  sql = <<-EOQ
    select
      '1-30 Days' as label,
      count(e.*) as value
    from
      gitlab_group g
    join 
      gitlab_epic e
    on 
      e.group_id = g.id
    where
      e.state = 'opened'
    and 
      e.created_at between symmetric now() - '1 days' :: interval and now() - '30 days' :: interval;
  EOQ
}

query "open_epic_30_90_days_count" {
  sql = <<-EOQ
    select
      '30-90 Days' as label,
      count(e.*) as value
    from
      gitlab_group g
    join 
      gitlab_epic e
    on 
      e.group_id = g.id
    where
      e.state = 'opened'
    and 
      e.created_at between symmetric now() - '30 days' :: interval and now() - '90 days' :: interval;
  EOQ
}

query "open_epic_90_365_days_count" {
  sql = <<-EOQ
    select
      '90-365 Days' as label,
      count(e.*) as value
    from
      gitlab_group g
    join 
      gitlab_epic e
    on 
      e.group_id = g.id
    where
      e.state = 'opened'
    and 
      e.created_at  between symmetric now() - '90 days' :: interval and now() - '365 days' :: interval;
  EOQ
}

query "open_epic_1_year_count" {
  sql = <<-EOQ
    select
      '> 1 Year' as label,
      count(e.*) as value
    from
      gitlab_group g
    join 
      gitlab_epic e
    on 
      e.group_id = g.id
    where
      e.state = 'opened'
    and 
      e.created_at <= now() - '1 year' :: interval;
  EOQ
}

query "open_epic_table" {
  sql = <<-EOQ
    select
      g.full_path as "Group",
      title as "Epic",
      now()::date - e.created_at::date as "Age in Days",
      now()::date - e.updated_at::date as "Days Since Last Update",
      author as "Author",
      e.web_url,
      g.web_url as group_url
    from
      gitlab_group g
    join 
      gitlab_epic e
    on 
      e.group_id = g.id
    where
      e.state = 'opened'
    order by
      "Age in Days" desc
  EOQ
}