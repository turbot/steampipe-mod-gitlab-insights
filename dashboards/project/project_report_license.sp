dashboard "project_license_report" {
  title = "GitLab Project License Report"
  documentation = file("./dashboards/project/docs/project_report_license.md")

  tags = merge(local.project_common_tags, {
    type = "Report"
  })

  container {
    card {
      query = query.project_count
      width = 2
    }

    card {
      query = query.project_without_license_count
      width = 2
    }

    card {
      query = query.project_mpl_license_count
      width = 2
    }

    card {
      query = query.project_gpl_license_count
      width = 2
    }

    card {
      query = query.project_apache_license_count
      width = 2
    }

    card {
      query = query.project_mit_license_count
      width = 2
    }
  }

  container {
    table {
      title = "Project Licenses"
      query = query.project_license_table

      column "web_url" {
        display = "none"
      }

      column "license_url" {
        display = "none"
      }

      column "Project" {
        href = "{{.'web_url'}}"
      }

      column "License" {
        href = "{{.'license_url'}}"
      }
    }
  }
}

query "project_without_license_count" {
  sql = <<-EOQ
    select
      'Without License' as label,
      count(*) as value,
      case
        when count(*) > 0 then 'alert'
        else 'ok'
      end as type
    from
      gitlab_my_project
    where license_key is null or license_key = '';
  EOQ
}

query "project_mpl_license_count" {
  sql = <<-EOQ
    select
      license_key as label, 
      count(*) as value
    from 
      gitlab_my_project 
    where 
      license_key = 'mpl-2.0'
    group by
      license_key;
  EOQ
}

query "project_gpl_license_count" {
  sql = <<-EOQ
    select
      'gpl-3.0 / agpl-3.0 / lgpl-3.0' as label, 
      count(*) as value
    from 
      gitlab_my_project 
    where 
      license_key IN ('gpl-3.0', 'agpl-3.0', 'lgpl-3.0')
    group by
      license_key;
  EOQ
}

query "project_apache_license_count" {
  sql = <<-EOQ
    select
      license_key as label, 
      count(*) as value
    from 
      gitlab_my_project 
    where 
      license_key = 'apache-2.0'
    group by
      license_key;
  EOQ
}

query "project_mit_license_count" {
  sql = <<-EOQ
    select
      license_key as label, 
      count(*) as value
    from 
      gitlab_my_project 
    where 
      license_key = 'mit'
    group by
      license_key;
  EOQ
}

query "project_license_table" {
  sql = <<-EOQ
    select
      full_path as "Project",
      license_key as "License",
      license as "License Name",
      web_url,
      license_url
    from
      gitlab_my_project;
  EOQ
}