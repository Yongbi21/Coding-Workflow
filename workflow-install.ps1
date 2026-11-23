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

    $rootDir  = (Get-Location).ProviderPath                                                                                                                                                                 
    $slnFiles = @(Get-ChildItem -LiteralPath $rootDir -Filter "*.sln" -File)                                                                                                                                
                                                                                                                                                                                                            
    if ($slnFiles.Count -eq 1) {                                                                                                                                                                            
        $slnPath = $slnFiles[0].FullName                                                                                                                                                                    
        $content = Get-Content -LiteralPath $slnPath -Raw                                                                                                                                                   
        if ($content -match '"Coding-Workflow"') {                                                                                                                                                          
            Write-Host "Skipped .sln update (already contains Coding-Workflow)." -ForegroundColor Yellow                                                                                                    
            return                                                                                                                                                                                          
        }                                                                                                                                                                                                   

        $folderGuid = [guid]::NewGuid().ToString("B").ToUpper()                                                                                                                                         
        $itemLines  = ($files | ForEach-Object { "`t`tdocs\Coding-Workflow\$_ = docs\Coding-Workflow\$_" }) -join "`r`n"                                                                                
                                                                                                                                                                                                            
        $folderBlock = @(                                                                                                                                                                               
                "Project(`"{2150E333-8FDC-42A3-9474-1A3956D46DE8}`") = `"Coding-Workflow`", `"Coding-Workflow`", `"$folderGuid`""                                                                           
                "`tProjectSection(SolutionItems) = preProject"                                                                                                                                              
                $itemLines                                                                                                                                                                                  
                "`tEndProjectSection"                                                                                                                                                                       
                "EndProject"                                                                                                                                                                                
            ) -join "`r`n"                                                                                                                                                                                  
                                                                                                                                                                                                            
        $regex = [regex]::new('(?m)^Global\r?$')                                                                                                                                                        
            if ($regex.IsMatch($content)) {                                                                                                                                                                 
                $updated = $regex.Replace($content, "$folderBlock`r`nGlobal", 1)                                                                                                                            
                [System.IO.File]::WriteAllText($slnPath, $updated, (New-Object System.Text.UTF8Encoding($true)))                                                                                            
                Write-Host "Added Coding-Workflow folder to: $($slnFiles[0].Name)" -ForegroundColor Green                                                                                                   
            }                                                                                                                                                                                               
        }   

     
