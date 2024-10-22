dashboard "project_expiring_member_report" {
  title = "GitLab Project Expiring Members Report"
  documentation = file("./dashboards/project/docs/project_report_expiring_member.md")

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
      query = query.project_expiring_member_24_hours_count
      width = 2
      type  = "info"
    }

    card {
      query = query.project_expiring_member_30_days_count
      width = 2
      type  = "info"
    }

    card {
      query = query.project_expiring_member_30_90_days_count
      width = 2
      type  = "info"
    }

    card {
      query = query.project_expiring_member_90_365_days_count
      width = 2
      type  = "info"
    }

    card {
      query = query.project_expiring_member_1_year_count
      width = 2
      type  = "info"
    }
  }

  container {
    table {
      title = "Project Expiring Members"
      query = query.project_expiring_member_table

      column "web_url" {
        display = "none"
      }

      column "member_url" {
        display = "none"
      }

      column "Project" {
        href = "{{.'web_url'}}"
      }

      column "Member" {
        href = "{{.'member_url'}}"
      }
    }
  }
}

query "project_expiring_member_24_hours_count" {
  sql = <<-EOQ
    select
      '< 24 Hours' as label,
      count(m.*) as value
    from
      gitlab_my_project p
      join gitlab_project_member m on p.id = m.project_id
    where
      m.state = 'active'
      and (
        m.expires_at is not null and
        m.expires_at < now() + '1 days'::interval
      );
  EOQ
}

query "project_expiring_member_30_days_count" {
  sql = <<-EOQ
    select
      '1-30 Days' as label,
      count(m.*) as value
    from
      gitlab_my_project p
      join gitlab_project_member m on p.id = m.project_id
    where
      m.state = 'active'
      and (
        m.expires_at is not null and
        m.expires_at between symmetric now() + '1 days'::interval and now() + '30 days' :: interval
      );
  EOQ
}

query "project_expiring_member_30_90_days_count" {
  sql = <<-EOQ
    select
      '30-90 Days' as label,
      count(m.*) as value
    from
      gitlab_my_project p
      join gitlab_project_member m on p.id = m.project_id
    where
      m.state = 'active'
      and (
        m.expires_at is not null and
        m.expires_at between symmetric now() + '30 days'::interval and now() + '90 days' :: interval
      );
  EOQ
}

query "project_expiring_member_90_365_days_count" {
  sql = <<-EOQ
    select
      '90-365 Days' as label,
      count(m.*) as value
    from
      gitlab_my_project p
      join gitlab_project_member m on p.id = m.project_id
    where
      m.state = 'active'
      and (
        m.expires_at is not null and
        m.expires_at between symmetric now() + '90 days'::interval and now() + '365 days' :: interval
      );
  EOQ
}

query "project_expiring_member_1_year_count" {
  sql = <<-EOQ
    select
      '> 1 Year' as label,
      count(m.*) as value
    from
      gitlab_my_project p
      join gitlab_project_member m on p.id = m.project_id
    where
      m.state = 'active'
      and (
        m.expires_at is not null and
        m.expires_at >= now() + '1 year' :: interval
      );
  EOQ
}

query "project_expiring_member_table" {
  sql = <<-EOQ
    select
      p.full_path as "Project",
      m.username as "Member",
      m.access_desc as "Access Level",
      m.expires_at::date - now()::date as "Expires in Days",
      p.web_url,
      m.web_url as member_url
    from
      gitlab_my_project p
      join gitlab_project_member m on p.id = m.project_id
    where
      m.state = 'active'
      and m.expires_at is not null
    order by
      "Expires in Days";
  EOQ
}