## v1.0.0 [2024-10-22]

This mod now requires [Powerpipe](https://powerpipe.io). [Steampipe](https://steampipe.io) users should check the [migration guide](https://powerpipe.io/blog/migrating-from-steampipe).

## v0.4 [2024-03-20]

_Bug fixes_

- Fixed the `project_license_table`, `project_other_license_count` and `project_weak_copyleft_license_count` queries to use the latest version of EUP (European Union Public License 1.2). ([#13](https://github.com/turbot/steampipe-mod-gitlab-insights/pull/13))

## v0.3 [2024-03-06]

_Powerpipe_

[Powerpipe](https://powerpipe.io) is now the preferred way to run this mod!  [Migrating from Steampipe →](https://powerpipe.io/blog/migrating-from-steampipe)

All v0.x versions of this mod will work in both Steampipe and Powerpipe, but v1.0.0 onwards will be in Powerpipe format only.

_Enhancements_

- Focus documentation on Powerpipe commands.
- Show how to combine Powerpipe mods with Steampipe plugins.

## v0.2[2023-11-03]

_Breaking changes_

- Updated the plugin dependency section of the mod to use `min_version` instead of `version`. ([#6](https://github.com/turbot/steampipe-mod-gitlab-insights/pull/6))

## v0.1 [2023-08-09]

_What's new?_

- New dashboards added:
  - [Branch Activity Report](https://hub.steampipe.io/mods/turbot/gitlab_insights/dashboards/dashboard.branch_activity_report)
  - [Branch Protection Report](https://hub.steampipe.io/mods/turbot/gitlab_insights/dashboards/dashboard.branch_protection_report)
  - [Group 2FA Report](https://hub.steampipe.io/mods/turbot/gitlab_insights/dashboards/dashboard.group_2fa_report)
  - [Group Access Request Report](https://hub.steampipe.io/mods/turbot/gitlab_insights/dashboards/dashboard.group_access_request_report)
  - [Group Expiring Members Report](https://hub.steampipe.io/mods/turbot/gitlab_insights/dashboards/dashboard.group_expiring_member_report)
  - [Group Visibility Report](https://hub.steampipe.io/mods/turbot/gitlab_insights/dashboards/dashboard.group_visibility_report)
  - [My Open Issues Age Report](https://hub.steampipe.io/mods/turbot/gitlab_insights/dashboards/dashboard.issue_my_open_age_report)
  - [Open Epics Age Report](https://hub.steampipe.io/mods/turbot/gitlab_insights/dashboards/dashboard.epic_open_age_report)
  - [Open Issues Age Report](https://hub.steampipe.io/mods/turbot/gitlab_insights/dashboards/dashboard.issue_open_age_report)
  - [Open Merge Request Age Report](https://hub.steampipe.io/mods/turbot/gitlab_insights/dashboards/dashboard.merge_request_open_age_report)
  - [Project Access Request Report](https://hub.steampipe.io/mods/turbot/gitlab_insights/dashboards/dashboard.project_access_request_report)
  - [Project Expiring Members Report](https://hub.steampipe.io/mods/turbot/gitlab_insights/dashboards/dashboard.project_expiring_member_report)
  - [Project Failed Pipelines Report](https://hub.steampipe.io/mods/turbot/gitlab_insights/dashboards/dashboard.project_failed_pipeline_report)
  - [Project License Report](https://hub.steampipe.io/mods/turbot/gitlab_insights/dashboards/dashboard.project_license_report)
  - [Project Stars Report](https://hub.steampipe.io/mods/turbot/gitlab_insights/dashboards/dashboard.project_star_report)
  - [Project Visibility Report](https://hub.steampipe.io/mods/turbot/gitlab_insights/dashboards/dashboard.project_visibility_report)
