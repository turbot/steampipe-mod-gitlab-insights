dashboard "group_2fa_report" {
  title = "GitLab Group 2FA Report"
  documentation = file("./dashboards/group/docs/group_report_2fa.md")

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
      query = query.group_2fa_enabled_count
      width = 3
    }

    card {
      query = query.group_2fa_disabled_count
      width = 3
    }
  }

  container {
    table {
      title = "Group 2fa Settings"
      query = query.group_2fa_table

      column "web_url" {
        display = "none"
      }

      column "Group" {
        href = "{{.'web_url'}}"
      }
    }
  }
}

query "group_2fa_enabled_count" {
  sql = <<-EOQ
    select
      'Enabled' as label,
      count(*) as value
    from
      gitlab_group
    where
      require_two_factor_authentication;
  EOQ
}

query "group_2fa_disabled_count" {
  sql = <<-EOQ
    select
      'Disabled' as label,
      count(*) as value,
      case
        when count(*) > 0 then 'alert'
        else 'ok'
      end as type
    from
      gitlab_group
    where
      not require_two_factor_authentication;
  EOQ
}

query "group_2fa_table" {
  sql = <<-EOQ
    select
      full_path as "Group",
      require_two_factor_authentication as "2FA Required",
      two_factor_grace_period as "2FA Grace Period (in hours)",
      web_url
    from
      gitlab_group;
  EOQ
}