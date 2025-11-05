function search-project {
    param (
        [Parameter(Mandatory = $true)]
        [string]$ProjectName
    )
    $uri = "http://gitlab.dev.de.uhlmann-net.de/api/v4/search?search=$ProjectName&scope=projects"
    $headers = @{
        'Accept'        = '*/*'
        'PRIVATE-TOKEN' = $env:GITLAB_TOKEN
    }
    $result = Invoke-WebRequest -Uri $uri -Method Get -Headers $headers
    $result.Content | jq --arg project_name "$ProjectName" '.[] | {name: .name, url: .web_url, ssh_url: .ssh_url_to_repo}'
}

function get-ci {
    param (
        [Parameter(Mandatory = $true)]
        [string]$Id
    )
    $uri = "http://gitlab.dev.de.uhlmann-net.de/api/v4/projects/$Id/repository/files/.gitlab-ci.yml/raw"
    $headers = @{
        'Accept'        = '*/*'
        'PRIVATE-TOKEN' = $env:GITLAB_TOKEN
    }
    $result = Invoke-WebRequest -Uri $uri -Method Get -Headers $headers
    $result.Content
}

function get-file {
    param (
        [Parameter(Mandatory = $true)]
        [string]$Project,
        [Parameter(Mandatory = $true)]
        [string]$File,
        [Parameter(Mandatory = $false)]
        [string]$Branch = "master"
    )
    $project_id = get-project $Project | jq -r '.id'
    $uri = "http://gitlab.dev.de.uhlmann-net.de/api/v4/projects/$project_id/repository/files/$File/raw?ref=$Branch"
    $headers = @{
        'Accept'        = '*/*'
        'PRIVATE-TOKEN' = $env:GITLAB_TOKEN
    }
    $result = Invoke-WebRequest -Uri $uri -Method Get -Headers $headers
    $result.Content
}

function get-project {
    param (
        [Parameter(Mandatory = $true)]
        [string]$project_name
    )

    $uri = "http://gitlab.dev.de.uhlmann-net.de/api/v4/search?archived=true&search=$project_name&scope=projects"
    $headers = @{
        'Accept'        = '*/*'
        'PRIVATE-TOKEN' = $env:GITLAB_TOKEN
    }
    $result = Invoke-WebRequest -Uri $uri -Method Get -Headers $headers
    $result.Content  | jq --arg project_name "$project_name" '.[] | select(.name | ascii_downcase == $project_name)'
}

function get-mrs {
    param (
        [Parameter(Mandatory = $true)]
        [string]$pbi_id
    )

    $uri = "http://gitlab.dev.de.uhlmann-net.de/api/v4/merge_requests?search=$pbi_id&in=title&page=1&per_page=100&state=merged&order_by=created_at&sort=asc"
    $headers = @{
        'Accept'        = '*/*'
        'PRIVATE-TOKEN' = $env:GITLAB_TOKEN
    }

    $result = Invoke-WebRequest -Uri $uri -Method Get -Headers $headers
    $result.Content | jq -r '.[] | "\(.title) \n\(.web_url)\n"'
    $pages = $result.Headers.'x-total-pages'
    $pages_count = [int] $pages[0]
    for ($i = 2; $i -le $pages_count; $i++ ) {
        $uri = "http://gitlab.dev.de.uhlmann-net.de/api/v4/merge_requests?search=$pbi_id&in=title&page=$i&per_page=100&state=merged&order_by=created_at&sort=asc"
        $result = Invoke-WebRequest -Uri $uri -Method Get -Headers $headers
        $result.Content | jq -r '.[] | "\(.title) \n\(.web_url)\n"'
    }

    $merge_requests = $result.Headers.'x-total'
    Write-Host $merge_requests "merge requests on" $pages "pages"
}

function get-open-mrs {
    $uri = "http://gitlab.dev.de.uhlmann-net.de/api/v4/merge_requests?assignee_username=vidic_n&state=opened&page=1&per_page=100"
    $headers = @{
        'Accept'        = '*/*'
        'PRIVATE-TOKEN' = $env:GITLAB_TOKEN
    }

    $result = Invoke-WebRequest -Uri $uri -Method Get -Headers $headers
    $result.Content | jq -r '.[] | "\(.title) \n\(.web_url)\n"'
    $pages = $result.Headers.'x-total-pages'
    $pages_count = [int] $pages[0]
    for ($i = 2; $i -le $pages_count; $i++ ) {
        $uri = "http://gitlab.dev.de.uhlmann-net.de/api/v4/merge_requests?assignee_username=vidic_n&state=opened&page=$i&per_page=100"
        $result = Invoke-WebRequest -Uri $uri -Method Get -Headers $headers
        $result.Content | jq -r '.[] | "\(.title) \n\(.web_url)\n"'
    }

    $merge_requests = $result.Headers.'x-total'
    Write-Host $merge_requests "merge requests on" $pages "pages"
}

function get-review-mrs {
    $uri = "http://gitlab.dev.de.uhlmann-net.de/api/v4/merge_requests?reviewer_username=vidic_n&state=opened&page=1&per_page=100"
    $headers = @{
        'Accept'        = '*/*'
        'PRIVATE-TOKEN' = $env:GITLAB_TOKEN
    }

    $result = Invoke-WebRequest -Uri $uri -Method Get -Headers $headers
    $result.Content | jq -r '.[] | "\(.title) \n\(.web_url)\n"'
    $pages = $result.Headers.'x-total-pages'
    $pages_count = [int] $pages[0]
    for ($i = 2; $i -le $pages_count; $i++ ) {
        $uri = "http://gitlab.dev.de.uhlmann-net.de/api/v4/merge_requests?reviewer_username=vidic_n&state=opened&page=$i&per_page=100"
        $result = Invoke-WebRequest -Uri $uri -Method Get -Headers $headers
        $result.Content | jq -r '.[] | "\(.title) \n\(.web_url)\n"'
    }

    $merge_requests = $result.Headers.'x-total'
    Write-Host $merge_requests "merge requests on" $pages "pages"
}

function get-packages {
    $uri = "http://gitlab.dev.de.uhlmann-net.de/api/v4/groups/1010/packages"
    $headers = @{
        'Accept'        = '*/*'
        'PRIVATE-TOKEN' = $env:GITLAB_TOKEN
    }
    $result = Invoke-WebRequest -Uri $uri -Method Get -Headers $headers
    $json_data = $result.Content | jq '.' | ConvertFrom-Json
    # $data = $result.Content | jq -r '.[] | "\(.name) \(.version) http://gitlab.dev.de.uhlmann-net.de/groups/package-hub/-/packages/\(.id)"'
    $json_data | Format-Table

    # $pages = $result.Headers.'x-total-pages'
    # $pages_count = [int] $pages[0]
    # for ($i = 2; $i -le $pages_count; $i++ ) {
    #     $uri = "http://gitlab.dev.de.uhlmann-net.de/api/v4/groups/1010/packages"
    #     $result = Invoke-WebRequest -Uri $uri -Method Get -Headers $headers
    #     $result.Content | jq -r '.[] | "\(.title) \n\(.web_url)\n"'
    # }

    # $merge_requests = $result.Headers.'x-total'
    # Write-Host $merge_requests "merge requests on" $pages "pages"
}

function get-project-url {

    param (
        [Parameter(Mandatory = $true)]
        [string]$ProjectName
    )

    $project = get-project $ProjectName
    $project | jq -r '.ssh_url_to_repo'
}

function get-repos {
    param (
        [Parameter(Mandatory = $true)]
        [string]$GroupName
    )

    $uri = "http://gitlab.dev.de.uhlmann-net.de/api/v4/groups/$GroupName/projects?&page=1&per_page=100&order_by=name&sort=asc"
    $headers = @{
        'Accept'        = '*/*'
        'PRIVATE-TOKEN' = $env:GITLAB_TOKEN
    }
    $result = Invoke-WebRequest -Uri $uri -Method Get -Headers $headers
    $pages = $result.Headers.'x-total-pages'
    $pages_count = [int] $pages[0]
    $result.Content | jq -r '.[] | .name'

    for ($i = 2; $i -le $pages_count; $i++ ) {
        $uri = "http://gitlab.dev.de.uhlmann-net.de/api/v4/groups/$GroupName/projects?&page=$i&per_page=100&order_by=name&sort=asc"
        $result = Invoke-WebRequest -Uri $uri -Method Get -Headers $headers
        $result.Content | jq -r '.[] | .name'
    }
    Write-Host
    $merge_requests = $result.Headers.'x-total'
    # Write-Host $merge_requests "projects on" $pages "pages"
}

function git-pull-dirs {
    param (
        [Parameter(Mandatory = $true)]
        [string]$Path
    )
    Get-ChildItem | Select-Object -expand Name | ForEach-Object { & "git" -C $_ pull }
}

function clone {
    param (
        [Parameter(Mandatory = $true)]
        [string]$ProjectName,
        [Parameter(Mandatory = $false)]
        [string]$Branch
    )
    $result = get-project-url $ProjectName
    ($result) | ForEach-Object { & "git" clone $_ }
}

function get-azure-repos {
    param (
        [Parameter(Mandatory = $true)]
        [string]$AzureProject
    )

    $result = az repos list -p $AzureProject
    $result | jq '.[].sshUrl'
}

function get-tag {
    param (
        [Parameter(Mandatory = $true)]
        [string]$ProjectName
    )
    $project_id = get-project $ProjectName | jq '.id'
    $uri = "http://gitlab.dev.de.uhlmann-net.de/api/v4/projects/$project_id/repository/tags"
    $headers = @{
        'Accept'        = '*/*'
        'PRIVATE-TOKEN' = $env:GITLAB_TOKEN
    }
    $result = Invoke-WebRequest -Uri $uri -Method Get -Headers $headers
    $result.Content | jq -r '.[] | "\(.name)\n\(.commit.title)\n" '
}

function clone-vm {
    param (
        [Parameter(Mandatory = $true)]
        [string]$template_name,
        [Parameter(Mandatory = $true)]
        [string]$vm_name
    )

    Write-Host $template_name $vm_name
    # $user_name = "vidic_n"
    # $new_vm_name = $user_name + "-" + $vm_name

    # $datacenter = "/UDELP-Datacenter"
    # $resource_pool = "$datacenter/host/CI-Cluster/UDELP-CI-02/Resources/runner"
    # $data_store = "$datacenter/datastore/SharedStorage/DSC-CI/UDELP-DS01-CI-EPHEMERAL-02"
    # $folder = "$datacenter/vm/CI/users/vidic_n"

    # time govc vm.clone `
    #     -pool="$resource_pool" `
    #     -ds="$data_store" `
    #     -c=8 `
    #     -m=32768 `
    #     -vm="$vm" `
    #     -on=true `
    #     -template=false `
    #     -folder="$folder" `
    #     "$vm_name"

}

# function get-pipelines {
#     param (
#         [Parameter(Mandatory = $true)]
#         [string]$ProjectName
#     )

#     $ProjectId = get-project $ProjectName | jq '.id'

#     $Pipelines = curl -s -X GET "http://gitlab.dev.de.uhlmann-net.de/api/v4/projects/$ProjectId/pipelines" `
#         --header 'Accept: */*'`
#         --header "PRIVATE-TOKEN: $env:GITLAB_TOKEN"

#     $Pipelines | jq '. | reverse'
# }

# function get-schedules {
#     param (
#         [Parameter(Mandatory = $true)]
#         [string]$ProjectName
#     )

#     $ProjectId = get-project $ProjectName | jq '.id'

#     $Pipelines = curl -s -X GET "http://gitlab.dev.de.uhlmann-net.de/api/v4/projects/$ProjectId/pipeline_schedules" `
#         --header 'Accept: */*'`
#         --header "PRIVATE-TOKEN: $env:GITLAB_TOKEN"

#     $Pipelines | jq '. | reverse'
# }
