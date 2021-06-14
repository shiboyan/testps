$Headers = @{
Accept = "application/vnd.github.v3+json"
}
$GitUrl=git remote show origin -n | select-string -Pattern "Fetch URL"
$RepoName=$GitUrl.ToString().Split("/")[-2]
$RepoDetails=$GitUrl.ToString().Split("/")[-1].Split(".")[0]
$Comments=(Invoke-RestMethod -Headers $Headers -Uri https://api.github.com/repos/$RepoName/$RepoDetails/pulls).body
if(!$Comments.Contains("mment")){
        throw "Not meet our criteria"
}
Write-Output "PR comment check done"