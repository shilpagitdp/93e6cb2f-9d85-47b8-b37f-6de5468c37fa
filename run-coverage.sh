#!/bin/bash

# Run Code Coverage for Linux/Mac
# This script runs tests with code coverage and generates an HTML report

echo "Running tests with code coverage..."

# Get solution directory
SOLUTION_DIR=$(pwd)

# Clean previous coverage results
if [ -d "TestResults" ]; then
    rm -rf TestResults
    echo "Cleaned previous test results"
fi

if [ -d "CoverageReport" ]; then
    rm -rf CoverageReport
    echo "Cleaned previous coverage report"
fi

# Clean test project TestResults too
if [ -d "../TestProject1/TestResults" ]; then
    rm -rf ../TestProject1/TestResults
fi

# Run tests with coverage collection
echo ""
echo "Running tests with Coverlet..."
dotnet test ../TestProject1/LongestSequenceSolutionTests.csproj \
    /p:CollectCoverage=true \
    /p:CoverletOutputFormat=opencover \
    /p:CoverletOutput="$SOLUTION_DIR/TestResults/" \
    /p:Exclude="[xunit.*]*" \
    --logger "console;verbosity=detailed"

if [ $? -ne 0 ]; then
    echo ""
    echo "Tests failed!"
    exit 1
fi

# Check if coverage file was generated
if [ ! -f "TestResults/coverage.opencover.xml" ]; then
    echo ""
    echo "Coverage file not found at: TestResults/coverage.opencover.xml"
    echo "Looking for coverage files..."
    
    # Search for coverage files
    FOUND_FILE=$(find . -name "coverage.*.xml" -type f | head -n 1)
    if [ -n "$FOUND_FILE" ]; then
        echo "Found: $FOUND_FILE"
        echo "Using this file for report generation"
        COVERAGE_FILE="$FOUND_FILE"
    else
        echo "No coverage files found!"
        exit 1
    fi
else
    COVERAGE_FILE="TestResults/coverage.opencover.xml"
fi

echo ""
echo "Generating HTML coverage report..."

# Install ReportGenerator if not already installed
dotnet tool install --global dotnet-reportgenerator-globaltool --version 5.2.0 2>/dev/null

# Generate HTML report
reportgenerator \
    -reports:"$COVERAGE_FILE" \
    -targetdir:"CoverageReport" \
    -reporttypes:"Html;TextSummary;Badges;Cobertura"

if [ $? -ne 0 ]; then
    echo ""
    echo "Failed to generate report!"
    exit 1
fi

# Display summary
echo ""
echo "====================================="
echo "   Code Coverage Report Generated    "
echo "====================================="

if [ -f "CoverageReport/Summary.txt" ]; then
    cat CoverageReport/Summary.txt
fi

echo ""
echo "HTML Report: CoverageReport/index.html"
echo ""
echo "Done!"

# Try to open report in default browser (Linux)
if command -v xdg-open > /dev/null; then
    xdg-open CoverageReport/index.html
# Try to open report in default browser (Mac)
elif command -v open > /dev/null; then
    open CoverageReport/index.html
fi
