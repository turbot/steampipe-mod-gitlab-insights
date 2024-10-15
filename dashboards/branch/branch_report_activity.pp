dashboard "branch_activity_report" {
  title = "GitLab Branch Activity Report"
  documentation = file("./dashboards/branch/docs/branch_report_activity.md")

  tags = merge(local.branch_common_tags, {
    type = "Report"
  })

  container {
    card {
      query = query.branch_count
      width = 2
    }

    card {
      query = query.branch_24_hours_count
      width = 2
      type  = "info"
    }

    card {
      query = query.branch_30_days_count
      width = 2
      type  = "info"
    }

    card {
      query = query.branch_30_90_days_count
      width = 2
      type  = "info"
    }

    card {
      query = query.branch_90_365_days_count
      width = 2
      type  = "info"
    }

    card {
      query = query.branch_1_year_count
      width = 2
      type  = "info"
    }
  }

  container {
    table {
      title = "Branches"
      query = query.branch_table

      column "web_url" {
        display = "none"
      }

      column "project_url" {
        display = "none"
      }

      column "Branch" {
        href = "{{.'web_url'}}"
      }

      column "Project" {
        href = "{{.'project_url'}}"
      }
    }
  }
}

query "branch_count" {
  sql = <<-EOQ
    select
      'Branches' as label,
      count(b.*) as value
    from
      gitlab_my_project p
      join gitlab_branch b on p.id = b.project_id;
  EOQ
}

query "branch_24_hours_count" {
  sql = <<-EOQ
    select
      '< 24 Hours' as label,
      count(b.*) as value
    from
      gitlab_branch b
    where
      b.project_id in (
        select
          id
        from
          gitlab_my_project
      )
      and b.commit_date > now() - '1 days'::interval;
  EOQ
}

query "branch_30_days_count" {
  sql = <<-EOQ
    select
      '1-30 Days' as label,
      count(b.*) as value
    from
      gitlab_branch b
    where
      b.project_id in (
        select
          id
        from
          gitlab_my_project
      )
      and b.commit_date between symmetric now() - '1 days' :: interval and now() - '30 days' :: interval;
  EOQ
}

query "branch_30_90_days_count" {
  sql = <<-EOQ
    select
      '30-90 Days' as label,
      count(b.*) as value
    from
      gitlab_branch b
    where
      b.project_id in (
        select
          id
        from
          gitlab_my_project
      )
      and b.commit_date between symmetric now() - '30 days' :: interval and now() - '90 days' :: interval;
  EOQ
}

query "branch_90_365_days_count" {
  sql = <<-EOQ
    select
      '90-365 Days' as label,
      count(b.*) as value
    from
      gitlab_branch b
    where
      b.project_id in (
        select
          id
        from
          gitlab_my_project
      )
      and b.commit_date between symmetric now() - '90 days' :: interval and now() - '365 days' :: interval;
  EOQ
}

query "branch_1_year_count" {
  sql = <<-EOQ
    select
      '> 1 Year' as label,
      count(b.*) as value
    from
      gitlab_branch b
    where
      b.project_id in (
        select
          id
        from
          gitlab_my_project
      )
      and b.commit_date <= now() - '1 year' :: interval;
  EOQ
}


query "branch_table" {
  sql = <<-EOQ
    select
      p.full_path as "Project",
      b.name as "Branch",
      b.default as "Is Default",
      b.merged as "Is Merged",
      --now()::date - b.created_at::date as "Age in Days", --GitLab doesn't expose branch creation date...
      now()::date - b.commit_date::date as "Days Since Last Commit",
      b.web_url,
      p.web_url as project_url
    from
      gitlab_my_project p
      join gitlab_branch b on p.id = b.project_id;
  EOQ
}