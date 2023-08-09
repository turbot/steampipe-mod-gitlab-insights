---
repository: "https://github.com/turbot/steampipe-mod-gitlab-insights"
---

# GitLab Insights Mod

Create dashboards and reports for your GitLab resources using Steampipe.

<img src="https://raw.githubusercontent.com/turbot/steampipe-mod-gitlab-insights/main/docs/images/open_issue_age_report.png" width="50%" type="thumbnail"/>
<img src="https://raw.githubusercontent.com/turbot/steampipe-mod-gitlab-insights/main/docs/images/project_visibility_report.png" width="50%" type="thumbnail"/>
<img src="https://raw.githubusercontent.com/turbot/steampipe-mod-gitlab-insights/main/docs/images/project_failed_pipeline_report.png" width="50%" type="thumbnail"/>
<img src="https://raw.githubusercontent.com/turbot/steampipe-mod-gitlab-insights/main/docs/images/branch_activity_report.png" width="50%" type="thumbnail"/>
<img src="https://raw.githubusercontent.com/turbot/steampipe-mod-gitlab-insights/main/docs/images/branch_protection_report.png" width="50%" type="thumbnail"/>
<img src="https://raw.githubusercontent.com/turbot/steampipe-mod-gitlab-insights/main/docs/images/open_mr_age_report.png" width="50%" type="thumbnail"/>

## Overview

Dashboards/Reports can help answer questions like:

- How many projects do I have access to?
- How old are my issues across all my projects?
- When was a project last contributed to?
- Which of my branches are (un)protected?

## References

[GitLab](https://gitlab.com/) is a provider of Internet hosting or on-premise for software development and version control using Git. It offers the distributed version control and source code management (SCM) functionality of Git, plus its own features.

[Steampipe](https://steampipe.io) is an open source CLI to instantly query cloud APIs using SQL.

[Steampipe Mods](https://steampipe.io/docs/reference/mod-resources#mod) are collections of `named queries`, codified `controls` that can be used to test current configuration of your cloud resources against a desired configuration, and `dashboards` that organize and display key pieces of information.

## Documentation

- **[Dashboards →](https://hub.steampipe.io/mods/turbot/gitlab_insights/dashboards)**

## Getting started

### Installation

Download and install Steampipe (https://steampipe.io/downloads). Or use Brew:

```sh
brew tap turbot/tap
brew install steampipe
```

Install the GitLab plugin with [Steampipe](https://steampipe.io):

```sh
steampipe plugin install theapsgroup/gitlab
```

Clone:

```sh
git clone https://github.com/turbot/steampipe-mod-gitlab-insights.git
cd steampipe-mod-gitlab-insights
```

### Usage

Start your dashboard server to get started:

```sh
steampipe dashboard
```

By default, the dashboard interface will then be launched in a new browser window at http://localhost:9194. From here, you can view dashboards and reports.

### Credentials

This mod uses the credentials configured in the [Steampipe GitLab plugin](https://hub.steampipe.io/plugins/theapsgroup/gitlab).

### Configuration

No extra configuration is required.

### FAQ

Q1: I have multiple GitLab configurations but Steampipe only seems to show results from one of these, how do I show all/more?

A1: As the tables in this mod are unqualified, they will revert to utilising the first connection for the plugin that is loaded - you can utilise a [connection aggregator](https://steampipe.io/docs/managing/connections#using-aggregators) in combination with providing the [search path](https://steampipe.io/docs/guides/search-path) argument to specify which connection(s) you wish to include.

## Contributing

If you have an idea for additional dashboards or just want to help maintain and extend this mod ([or others](https://github.com/topics/steampipe-mod)) we would love you to join the community and start contributing.

- **[Join our Slack community →](https://turbot.com/community/join)** and hang out with other Mod developers.

Please see the [contribution guidelines](https://github.com/turbot/steampipe/blob/main/CONTRIBUTING.md) and our [code of conduct](https://github.com/turbot/steampipe/blob/main/CODE_OF_CONDUCT.md). All contributions are subject to the [Apache 2.0 open source license](https://github.com/turbot/steampipe-mod-gitlab-insights/blob/main/LICENSE).

Want to help but not sure where to start? Pick up one of the `help wanted` issues:

- [Steampipe](https://github.com/turbot/steampipe/labels/help%20wanted)
- [GitLab Insights Mod](https://github.com/turbot/steampipe-mod-gitlab-insights/labels/help%20wanted)