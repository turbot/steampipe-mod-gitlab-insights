dashboard "group_expiring_member_report" {
  title = "GitLab Group Expiring Members Report"
  documentation = file("./dashboards/group/docs/group_report_expiring_member.md")

  tags = merge(local.group_common_tags, {
    type     = "Report"
    category = "Security"
  })

  container {
    card {
      query = query.group_count
      width = 2
    }

    card {
      query = query.group_expiring_member_24_hours_count
      width = 2
      type  = "info"
    }

    card {
      query = query.group_expiring_member_30_days_count
      width = 2
      type  = "info"
    }

    card {
      query = query.group_expiring_member_30_90_days_count
      width = 2
      type  = "info"
    }

    card {
      query = query.group_expiring_member_90_365_days_count
      width = 2
      type  = "info"
    }

    card {
      query = query.group_expiring_member_1_year_count
      width = 2
      type  = "info"
    }
  }

  container {
    table {
      title = "Group Expiring Members"
      query = query.group_expiring_member_table

      column "web_url" {
        display = "none"
      }

      column "member_url" {
        display = "none"
      }

      column "Group" {
        href = "{{.'web_url'}}"
      }

      column "Member" {
        href = "{{.'member_url'}}"
      }
    }
  }
}

query "group_expiring_member_24_hours_count" {
  sql = <<-EOQ
    select
      '< 24 Hours' as label,
      count(m.*) as value
    from
      gitlab_group g
      join gitlab_group_member m on g.id = m.group_id
    where
      m.state = 'active'
      and (
        m.expires_at is not null and
        m.expires_at < now() + '1 days'::interval
      );
  EOQ
}

query "group_expiring_member_30_days_count" {
  sql = <<-EOQ
    select
      '1-30 Days' as label,
      count(m.*) as value
    from
      gitlab_group g
      join gitlab_group_member m on g.id = m.group_id
    where
      m.state = 'active'
      and (
        m.expires_at is not null and
        m.expires_at between symmetric now() + '1 days'::interval and now() + '30 days' :: interval
      );
  EOQ
}

query "group_expiring_member_30_90_days_count" {
  sql = <<-EOQ
    select
      '30-90 Days' as label,
      count(m.*) as value
    from
      gitlab_group g
      join gitlab_group_member m on g.id = m.group_id
    where
      m.state = 'active'
      and (
        m.expires_at is not null and
        m.expires_at between symmetric now() + '30 days'::interval and now() + '90 days' :: interval
      );
  EOQ
}

query "group_expiring_member_90_365_days_count" {
  sql = <<-EOQ
    select
      '90-365 Days' as label,
      count(m.*) as value
    from
      gitlab_group g
      join gitlab_group_member m on g.id = m.group_id
    where
      m.state = 'active'
      and (
        m.expires_at is not null and
        m.expires_at between symmetric now() + '90 days'::interval and now() + '365 days' :: interval
      );
  EOQ
}

query "group_expiring_member_1_year_count" {
  sql = <<-EOQ
    select
      '> 1 Year' as label,
      count(m.*) as value
    from
      gitlab_group g
      join gitlab_group_member m on g.id = m.group_id
    where
      m.state = 'active'
      and (
        m.expires_at is not null and
        m.expires_at >= now() + '1 year' :: interval
      );
  EOQ
}

query "group_expiring_member_table" {
  sql = <<-EOQ
    select
      g.full_path as "Group",
      m.username as "Member",
      m.access_desc as "Access Level",
      m.expires_at::date - now()::date as "Expires in Days",
      g.web_url,
      m.web_url as member_url
    from
      gitlab_group g
      join gitlab_group_member m on g.id = m.group_id
    where
      m.state = 'active'
      and m.expires_at is not null
    order by
      "Expires in Days";
  EOQ
}