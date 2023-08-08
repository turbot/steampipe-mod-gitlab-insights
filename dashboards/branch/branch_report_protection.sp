dashboard "branch_protection_report" {
  title = "GitLab Branch Protection Report"
  documentation = file("./dashboards/branch/docs/branch_report_protection.md")

  tags = merge(local.branch_common_tags, {
    type     = "Report"
    category = "Security"
  })

  container {
    card {
      query = query.branch_count
      width = 3
    }

    card {
      query = query.branch_protected_count
      width = 3
    }

    card {
      query = query.branch_unprotected_count
      width = 3
    }
  }

  container {
    table {
      title = "Branch Protections"
      query = query.branch_protection_table

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

query "branch_protected_count" {
  sql = <<-EOQ
    select
      'Protected' as label,
      count(b.*) as value
    from
      gitlab_my_project p
      join gitlab_branch b on p.id = b.project_id
    where
      b.protected;
  EOQ
}

query "branch_unprotected_count" {
  sql = <<-EOQ
    select
      'Unprotected' as label,
      count(b.*) as value,
      case
        when count(b.*) > 0 then 'alert'
        else 'ok'
      end as type
    from
      gitlab_my_project p
      join gitlab_branch b on p.id = b.project_id
    where
      not b.protected;
  EOQ
}

query "branch_protection_table" {
  sql = <<-EOQ
    select
      p.full_path as "Project",
      b.name as "Branch",
      b.protected as "Is Protected",
      b.devs_can_push as "Developer Can Push",
      b.devs_can_merge as "Developer Can Merge",
      b.can_push as "You Can Push",
      b.web_url,
      p.web_url as project_url
    from
      gitlab_my_project p
      join gitlab_branch b on p.id = b.project_id;
  EOQ
}
