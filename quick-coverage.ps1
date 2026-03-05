# Quick Coverage Check
# Runs tests with coverage and displays summary in console

Write-Host "Running code coverage analysis..." -ForegroundColor Cyan

# Get solution directory
$solutionDir = Get-Location

dotnet test "..\TestProject1\LongestSequenceSolutionTests.csproj" `
    /p:CollectCoverage=true `
    /p:CoverletOutputFormat="json,cobertura" `
    /p:CoverletOutput="$solutionDir\TestResults\" `
    /p:Exclude="[xunit.*]*" `
    --logger "console;verbosity=normal"

if ($LASTEXITCODE -eq 0) {
    Write-Host "`nTests passed! ✓" -ForegroundColor Green
    
    # Try to display coverage summary
    $coverageFile = "TestResults\coverage.cobertura.xml"
    if (Test-Path $coverageFile) {
        [xml]$coverage = Get-Content $coverageFile
        $lineRate = [math]::Round([decimal]$coverage.coverage.'line-rate' * 100, 2)
        $branchRate = [math]::Round([decimal]$coverage.coverage.'branch-rate' * 100, 2)
        
        Write-Host "`n=====================================" -ForegroundColor Cyan
        Write-Host "      Coverage Summary" -ForegroundColor Cyan
        Write-Host "=====================================" -ForegroundColor Cyan
        Write-Host "Line Coverage:   $lineRate%" -ForegroundColor $(if ($lineRate -ge 80) { "Green" } elseif ($lineRate -ge 60) { "Yellow" } else { "Red" })
        Write-Host "Branch Coverage: $branchRate%" -ForegroundColor $(if ($branchRate -ge 80) { "Green" } elseif ($branchRate -ge 60) { "Yellow" } else { "Red" })
        Write-Host "=====================================" -ForegroundColor Cyan
    } else {
        Write-Host "`nCoverage file not found, but tests passed!" -ForegroundColor Yellow
    }
} else {
    Write-Host "`nTests failed! ✗" -ForegroundColor Red
    exit $LASTEXITCODE
}
