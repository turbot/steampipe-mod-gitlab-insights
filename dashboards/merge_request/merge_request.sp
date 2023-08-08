category "merge_request" {
  title = "Merge Request"
  icon  = "flowsheet"
}

locals {
  merge_request_common_tags = {
    service = "GitLab/MergeRequest"
  }
}