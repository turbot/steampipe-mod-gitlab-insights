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
      query = query.project_weak_copyleft_license_count
      width = 2
    }

    card {
      query = query.project_popular_copyleft_license_count
      width = 2
    }

    card {
      query = query.project_permissive_license_count
      width = 2
    }

    card {
      query = query.project_other_license_count
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
    where
      license_key is null or license_key = '';
  EOQ
}

query "project_weak_copyleft_license_count" {
  sql = <<-EOQ
    select
      'Weak Copyleft' as label,
      count(*) as value
    from
      gitlab_my_project
    where
      license_key in ('lgpl-3.0','lgpl-2.1','mpl-2.0','epl-2.0','osl-3.0','eupl-1.2');
  EOQ
}

query "project_popular_copyleft_license_count" {
  sql = <<-EOQ
    select
      'Popular Copyleft' as label,
      count(*) as value
    from
      gitlab_my_project
    where
      license_key in ('gpl-3.0','gpl-2.0','agpl-3.0','agpl-2.0','cc-by-sa-4.0','apsl');
  EOQ
}

query "project_permissive_license_count" {
  sql = <<-EOQ
    select
      'Permissive' as label,
      count(*) as value
    from
      gitlab_my_project
    where
      license_key in ('apache-2.0','mit','bsd-3','bsd-2','bsd-3-clause','bsd2-clause', 'cc-by-4.0', 'wtfpl', 'ms-pl', 'unlicensed');
  EOQ
}

query "project_other_license_count" {
  sql = <<-EOQ
    select
      'Other' as label,
      count(*) as value
    from
      gitlab_my_project
    where
      license_key is not null
      and license_key not in ('lgpl-3.0','lgpl-2.1','mpl-2.0','epl-2.0','osl-3.0','eupl-1.2','gpl-3.0','gpl-2.0','agpl-3.0','agpl-2.0','cc-by-sa-4.0','apsl','apache-2.0','mit','bsd-3','bsd-2','bsd-3-clause','bsd2-clause', 'cc-by-4.0', 'wtfpl', 'ms-pl', 'unlicensed');
  EOQ
}

query "project_license_table" {
  sql = <<-EOQ
    select
      full_path as "Project",
      license_key as "License",
      license as "License Name",
      case
        when (license_key in ('lgpl-3.0','lgpl-2.1','mpl-2.0','epl-2.0','osl-3.0','eupl-1.2')) then 'weak copyleft'
        when (license_key in ('gpl-3.0','gpl-2.0','agpl-3.0','agpl-2.0','cc-by-sa-4.0','apsl')) then 'popular copyleft'
        when (license_key in ('apache-2.0','mit','bsd-3','bsd-2','bsd-3-clause','bsd2-clause', 'cc-by-4.0', 'wtfpl', 'ms-pl', 'unlicensed')) then 'permissive'
        when (license_key is null) then null
        else 'other'
      end as "License Type",
      web_url,
      license_url
    from
      gitlab_my_project;
  EOQ
}