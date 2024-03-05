# GitLab Insights Mod for Powerpipe

> [!IMPORTANT]
> Steampipe mods are [migrating to Powerpipe format](https://powerpipe.io) to gain new features. This mod currently works with both Steampipe and Powerpipe, but will only support Powerpipe from v1.x onward.

A GitLab dashboarding tool that can be used to view dashboards and reports across all of your GitLab resources.

![image](https://hub-powerpipe-io-git-development-turbot.vercel.app/images/mods/turbot/gitlab-insights-social-graphic.png)

## Overview

Dashboards/Reports can help answer questions like:

- How many projects do I have access to?
- How old are my issues across all my projects?
- When was a project last contributed to?
- Which of my branches are (un)protected?

## Documentation

- **[Dashboards →](https://hub-powerpipe-io-git-development-turbot.vercel.app/mods/turbot/gitlab_insights/dashboards)**

## Getting Started

### Installation

Install Powerpipe (https://powerpipe.io/downloads), or use Brew:

```sh
brew install turbot/tap/powerpipe
```

This mod also requires [Steampipe](https://steampipe.io) with the [GitLab plugin](https://hub.steampipe.io/plugins/theapsgroup/gitlab) as the data source. Install Steampipe (https://steampipe.io/downloads), or use Brew:

```sh
brew install turbot/tap/steampipe
steampipe plugin install theapsgroup/gitlab
```

This mod uses the credentials configured in the [Steampipe GitLab plugin](https://hub.steampipe.io/plugins/theapsgroup/gitlab#configuration).

Finally, install the mod:

```sh
mkdir dashboards
cd dashboards
powerpipe mod init
powerpipe mod install github.com/turbot/steampipe-mod-gitlab-insights
```

### Browsing Dashboards

Start Steampipe as the data source:

```sh
steampipe service start
```

Start the dashboard server:

```sh
powerpipe server
```

Browse and view your dashboards at **http://localhost:9033**.

## Open Source & Contributing

This repository is published under the [Apache 2.0 license](https://www.apache.org/licenses/LICENSE-2.0). Please see our [code of conduct](https://github.com/turbot/.github/blob/main/CODE_OF_CONDUCT.md). We look forward to collaborating with you!

[Steampipe](https://steampipe.io) and [Powerpipe](https://powerpipe.io) are products produced from this open source software, exclusively by [Turbot HQ, Inc](https://turbot.com). They are distributed under our commercial terms. Others are allowed to make their own distribution of the software, but cannot use any of the Turbot trademarks, cloud services, etc. You can learn more in our [Open Source FAQ](https://turbot.com/open-source).

## Get Involved

**[Join #powerpipe on Slack →](https://turbot.com/community/join)**

Want to help but don't know where to start? Pick up one of the `help wanted` issues:

- [Powerpipe](https://github.com/turbot/powerpipe/labels/help%20wanted)
- [GitLab Insights Mod](https://github.com/turbot/steampipe-mod-gitlab-insights/labels/help%20wanted)