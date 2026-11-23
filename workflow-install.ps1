param(
    [string]$Repo = "Yongbi21/Coding-Workflow",
    [string]$Branch = "main",
    [switch]$Force
)

$ErrorActionPreference = "Stop"
[Net.ServicePointManager]::SecurityProtocol = [Net.SecurityProtocolType]::Tls12

$docsDir = Join-Path (Get-Location).ProviderPath "docs"
$targetDir = Join-Path $docsDir "Coding-Workflow"

if (-not (Test-Path -LiteralPath $targetDir)) {
    New-Item -ItemType Directory -Path $targetDir -Force | Out-Null
}

$baseUrl = "https://raw.githubusercontent.com/$Repo/$Branch"
$files = @("AGENTS.md", "PROJECT-MAP.md", "LARGE-CHANGES.md", "HANDOFF.md")

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

