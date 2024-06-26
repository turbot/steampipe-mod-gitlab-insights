mod "gitlab_insights" {
  title         = "GitLab Insights"
  description   = "Create dashboards and reports for your GitLab resources using Powerpipe and Steampipe."
  color         = "#FCA121"
  documentation = file("./docs/index.md")
  icon          = "/images/mods/turbot/gitlab-insights.svg"
  categories    = ["gitlab", "dashboard", "public cloud"]

  opengraph {
    title       = "Powerpipe Mod for GitLab Insights"
    description = "Create dashboards and reports for your GitLab resources using Powerpipe and Steampipe."
    image       = "/images/mods/turbot/gitlab-insights-social-graphic.png"
  }

  require {
    plugin "theapsgroup/gitlab" {
      min_version = "0.4.2"
    }
  }
}