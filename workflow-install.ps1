param(
    [string]$Repo = "Yongbi21/Coding-Workflow",
    [string]$Branch = "main",
    [switch]$Force
)

$ErrorActionPreference = "Stop"
[Net.ServicePointManager]::SecurityProtocol = [Net.SecurityProtocolType]::Tls12

$targetDir = (Get-Location).ProviderPath
$baseUrl = "https://raw.githubusercontent.com/$Repo/$Branch"
$files = @("agents.md", "project-map.md", "large-changes.md", "handoff.md")

foreach ($file in $files) {
    $destinationPath = Join-Path $targetDir $file   
    
    if ((Test-Path -LiteralPath $destinationPath) -and -not $Force) {
        Write-Host "Skipped file already exists: $file" -ForegroundColor Yellow
        continue
    }
    
    $url = "$baseUrl/$file"
    Invoke-WebRequest -Uri $url -OutFile $destinationPath -UseBasicParsing
    Write-Host "Downloaded: $file" -ForegroundColor Green

}

