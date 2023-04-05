data "gitea_repo" "repos" {
  count    = length(local.repos)
  name     = local.repos[count.index]
  username = "sh4ke"
}

output "foo" {
  value = data.gitea_repo.repos[12].created
}
