param(
    [string]$Repo = "/"
    [string]$Branch = "main"
    [switch]$Force
)

$targetDir = (Get-Location).ProviderPath
$baseUrl = "https://github.com/$Repo/$Branch"
$files = @("AGENTS.MD", "PROJECT-MAP.MD", "LARGE-CHANGES.MD", "HANDOFF.MD")

foreach ($file in $files) {
    $destinationPath = Join-Path $targetDir $file
    
    if ((Test-Path -LiteralPath $destinationPath) -and -not $Force) {
        # log skip and continue
        continue
    }
    $url = "$baseUrl/$file"
    Invoke-WebRequest -Uri $url -OutFile $destinationPath -UseBasicParsing
}

