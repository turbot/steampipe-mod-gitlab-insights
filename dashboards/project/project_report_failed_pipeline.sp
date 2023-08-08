dashboard "project_failed_pipeline_report" {
  title = "GitLab Project Failed Pipelines Report"
  documentation = file("./dashboards/project/docs/project_report_failed_pipeline.md")

  tags = merge(local.project_common_tags, {
    type = "Report"
  })

  container {
    card {
      query = query.project_count
      width = 3
    }

    card {
      query = query.project_failed_pipeline_count
      width = 3
    }
  }

  container {
    table {
      title = "Failed Pipelines"
      query = query.project_failed_pipeline_table

      column "web_url" {
        display = "none"
      }

      column "pipeline_url" {
        display = "none"
      }

      column "Project" {
        href = "{{.'web_url'}}"
      }

      column "Pipeline" {
        href = "{{.'pipeline_url'}}"
      }
    }
  }
}

query "project_failed_pipeline_count" {
  sql = <<-EOQ
    select
      'Failed Pipelines' as label,
      count(l.*) as value,
      case
        when count(l.*) > 0 then 'alert'
        else 'ok'
      end as type
    from
      gitlab_my_project p
      join gitlab_project_pipeline l on p.id = l.project_id
    where
      l.status = 'failed';
  EOQ
}

query "project_failed_pipeline_table" {
  sql = <<-EOQ
    select
      p.full_path as "Project",
      l.id as "Pipeline",
      l.ref as "Pipeline Ref",
      now()::date - l.updated_at::date as "Age in Days",
      p.web_url,
      l.web_url as pipeline_url
    from
      gitlab_my_project p
      join gitlab_project_pipeline l on p.id = l.project_id
    where
      l.status = 'failed';
  EOQ
}