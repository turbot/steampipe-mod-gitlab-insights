mod "gitlab_insights" {
  title         = "GitLab Insights"
  description   = "Create dashboards and reports for your GitLab resources using Steampipe."
  color         = "#FCA121"
  documentation = file("./docs/index.md")
  icon          = "/images/mods/turbot/gitlab-insights.svg"
  categories    = ["gitlab", "dashboard", "public cloud"]

  opengraph {
    title       = "Steampipe Mod for GitLab Insights"
    description = "Create dashboards and reports for your GitLab resources using Steampipe."
    image       = "/images/mods/turbot/gitlab-insights-social-graphic.png"
  }

  require {
    steampipe {
      min_version = "0.20.0"
    }
    
    plugin "gitlab" {
      min_version = "0.4.2"
    }
  }
}