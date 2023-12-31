# GitLab Insights Mod for Steampipe

A GitLab dashboarding tool that can be used to view dashboards and reports across all of your GitLab resources.

![image](https://hub.steampipe.io/images/mods/turbot/gitlab-insights-social-graphic.png)

## Overview

Dashboards/Reports can help answer questions like:

- How many projects do I have access to?
- How old are my issues across all my projects?
- When was a project last contributed to?
- Which of my branches are (un)protected?

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

## Contributing

If you have an idea for additional dashboards or just want to help maintain and extend this mod ([or others](https://github.com/topics/steampipe-mod)) we would love you to join the community and start contributing.

- **[Join our Slack community →](https://turbot.com/community/join)** and hang out with other Mod developers.

Please see the [contribution guidelines](https://github.com/turbot/steampipe/blob/main/CONTRIBUTING.md) and our [code of conduct](https://github.com/turbot/steampipe/blob/main/CODE_OF_CONDUCT.md). All contributions are subject to the [Apache 2.0 open source license](https://github.com/turbot/steampipe-mod-gitlab-insights/blob/main/LICENSE).

Want to help but not sure where to start? Pick up one of the `help wanted` issues:

- [Steampipe](https://github.com/turbot/steampipe/labels/help%20wanted)
- [GitLab Insights Mod](https://github.com/turbot/steampipe-mod-gitlab-insights/labels/help%20wanted)