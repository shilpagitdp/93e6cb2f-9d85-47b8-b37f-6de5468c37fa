# Run Code Coverage
# This script runs tests with code coverage and generates an HTML report

Write-Host "Running tests with code coverage..." -ForegroundColor Cyan

# Get solution directory
$solutionDir = Get-Location

# Clean previous coverage results
if (Test-Path "TestResults") {
    Remove-Item -Recurse -Force "TestResults"
    Write-Host "Cleaned previous test results" -ForegroundColor Yellow
}

if (Test-Path "CoverageReport") {
    Remove-Item -Recurse -Force "CoverageReport"
    Write-Host "Cleaned previous coverage report" -ForegroundColor Yellow
}

# Clean test project TestResults too
if (Test-Path "..\TestProject1\TestResults") {
    Remove-Item -Recurse -Force "..\TestProject1\TestResults"
}

# Run tests with coverage collection
Write-Host "`nRunning tests with Coverlet..." -ForegroundColor Cyan
dotnet test "..\TestProject1\LongestSequenceSolutionTests.csproj" `
    /p:CollectCoverage=true `
    /p:CoverletOutputFormat=opencover `
    /p:CoverletOutput="$solutionDir\TestResults\" `
    /p:Exclude="[xunit.*]*" `
    --logger "console;verbosity=detailed"

if ($LASTEXITCODE -ne 0) {
    Write-Host "`nTests failed!" -ForegroundColor Red
    exit $LASTEXITCODE
}

# Check if coverage file was generated
$coverageFile = "TestResults\coverage.opencover.xml"
if (-not (Test-Path $coverageFile)) {
    Write-Host "`nCoverage file not found at: $coverageFile" -ForegroundColor Red
    Write-Host "Looking for coverage files..." -ForegroundColor Yellow
    
    # Search for coverage files
    $foundFiles = Get-ChildItem -Path . -Filter "coverage.*.xml" -Recurse -ErrorAction SilentlyContinue
    if ($foundFiles) {
        Write-Host "Found coverage files:" -ForegroundColor Yellow
        $foundFiles | ForEach-Object { Write-Host "  $_" -ForegroundColor Yellow }
        $coverageFile = $foundFiles[0].FullName
        Write-Host "Using: $coverageFile" -ForegroundColor Green
    } else {
        Write-Host "No coverage files found!" -ForegroundColor Red
        exit 1
    }
}

Write-Host "`nGenerating HTML coverage report..." -ForegroundColor Cyan

# Generate HTML report using ReportGenerator
dotnet tool install --global dotnet-reportgenerator-globaltool --version 5.2.0 2>$null
reportgenerator `
    -reports:"$coverageFile" `
    -targetdir:"CoverageReport" `
    -reporttypes:"Html;TextSummary;Badges;Cobertura"

if ($LASTEXITCODE -ne 0) {
    Write-Host "`nFailed to generate report!" -ForegroundColor Red
    exit $LASTEXITCODE
}

# Display summary
Write-Host "`n" -NoNewline
Write-Host "=====================================" -ForegroundColor Green
Write-Host "   Code Coverage Report Generated    " -ForegroundColor Green
Write-Host "=====================================" -ForegroundColor Green

if (Test-Path "CoverageReport\Summary.txt") {
    Get-Content "CoverageReport\Summary.txt"
}

Write-Host "`nHTML Report: " -NoNewline -ForegroundColor Cyan
Write-Host "CoverageReport\index.html" -ForegroundColor Yellow

Write-Host "`nOpening coverage report in browser..." -ForegroundColor Cyan
Start-Process "CoverageReport\index.html"

Write-Host "`nDone!" -ForegroundColor Green
