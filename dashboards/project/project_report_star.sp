dashboard "project_star_report" {
  title = "GitLab Project Stars Report"
  documentation = file("./dashboards/project/docs/project_report_star.md")

  tags = merge(local.project_common_tags, {
    type = "Report"
  })

  container {
    card {
      query = query.project_count
      width = 2
    }

    card {
      query = query.project_unstarred_count
      width = 2
    }

    card {
      query = query.project_1_100_stars_count
      width = 2
    }

    card {
      query = query.project_101_500_stars_count
      width = 2
    }

    card {
      query = query.project_501_1000_stars_count
      width = 2
    }

    card {
      query = query.project_over_1000_stars_count
      width = 2
    }
  }

  container {
    table {
      title = "Project Stars"
      query = query.project_star_table

      column "web_url" {
        display = "none"
      }

      column "Project" {
        href = "{{.'web_url'}}"
      }
    }
  }
}

query "project_unstarred_count" {
  sql = <<-EOQ
    select
      'Unstarred' as label,
      count(*) as value
    from
      gitlab_my_project
    where
      star_count = 0;
  EOQ
}

query "project_1_100_stars_count" {
  sql = <<-EOQ
    select
      '1 - 100' as label,
      count(*) as value
    from
      gitlab_my_project
    where
      star_count between 1 and 100;
  EOQ
}

query "project_101_500_stars_count" {
  sql = <<-EOQ
    select
      '101 - 500' as label,
      count(*) as value
    from
      gitlab_my_project
    where
      star_count between 101 and 500;
  EOQ
}

query "project_501_1000_stars_count" {
  sql = <<-EOQ
    select
      '501 - 1000' as label,
      count(*) as value
    from
      gitlab_my_project
    where
      star_count between 501 and 1000;
  EOQ
}

query "project_over_1000_stars_count" {
  sql = <<-EOQ
    select
      '> 1000' as label,
      count(*) as value
    from
      gitlab_my_project
    where
      star_count > 1000;
  EOQ
}

query "project_star_table" {
  sql = <<-EOQ
    select
      full_path as "Project",
      star_count as "Stars",
      web_url
    from
      gitlab_my_project
    order by
      star_count desc,
      full_path;
  EOQ
}