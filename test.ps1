$PrString=git ls-remote origin 'pull/*/head'.ToString()
$PrString
$GitUrl=git remote show origin -n | select-string -Pattern "Fetch URL"
$RepoName=$GitUrl.ToString().Split("/")[-2]
$RepoDetails=$GitUrl.ToString().Split("/")[-1].Split(".")[0]


$Headers = @{
        Accept = "application/vnd.github.v3+json"
    }

#$Headers = @{
#        Authorization = "token ${Env:GITHUB_PAT}"
#        Accept = "application/vnd.github.v3+json"
#}

Invoke-RestMethod -Headers $Headers  -Uri $GithubUri -Method Post


$Comments=Invoke-RestMethod -Headers $Headers  https://api.github.com/repos/shiboyan/testps/pulls
echo $Comments.body

#if([String]::IsNullOrEmpty($PrString)){
#   Write-Output "no PR."
#}
#else{
#   $PrID=$PrString.Split("/")[2].trim()
#}
$Comments=(Invoke-RestMethod https://api.github.com/repos/$RepoName/$RepoDetails/pulls/$PRID).body
echo $Comments
if(!$Comments.Contains("mment")){
       throw "Not meet our criteria"
}
echo "PR comment check done"