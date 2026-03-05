# Code Coverage Configuration

This project uses **Coverlet** and **ReportGenerator** to provide comprehensive code coverage reporting for xUnit tests.

## 📦 Installed Packages

- **coverlet.collector** (6.0.0) - Data collector for coverage
- **coverlet.msbuild** (6.0.0) - MSBuild integration for coverage
- **ReportGenerator** (5.2.0) - Generates HTML reports from coverage data

## 🚀 Quick Start

### Windows (PowerShell)

#### Full HTML Report
```powershell
.\run-coverage.ps1
```
Generates a complete HTML report and opens it in your browser.

#### Quick Console Summary
```powershell
.\quick-coverage.ps1
```
Shows coverage percentage in the console without generating HTML.

### Linux/Mac (Bash)
```bash
chmod +x run-coverage.sh
./run-coverage.sh
```

## 📊 Manual Commands

### Option 1: Basic Coverage
```bash
dotnet test /p:CollectCoverage=true
```
Runs tests and shows coverage summary in console.

### Option 2: Generate Coverage File
```bash
dotnet test \
  /p:CollectCoverage=true \
  /p:CoverletOutputFormat=opencover \
  /p:CoverletOutput=./TestResults/coverage.opencover.xml
```

### Option 3: Multiple Formats
```bash
dotnet test \
  /p:CollectCoverage=true \
  /p:CoverletOutputFormat="json,cobertura,opencover" \
  /p:CoverletOutput=./TestResults/
```

### Option 4: With HTML Report
```bash
# Run tests and collect coverage
dotnet test \
  /p:CollectCoverage=true \
  /p:CoverletOutputFormat=opencover \
  /p:CoverletOutput=./TestResults/coverage.opencover.xml

# Generate HTML report
reportgenerator \
  -reports:"TestResults/coverage.opencover.xml" \
  -targetdir:"CoverageReport" \
  -reporttypes:"Html;TextSummary"
```

## 📁 Output Files

### Coverage Data Files
- `TestResults/coverage.json` - JSON format
- `TestResults/coverage.cobertura.xml` - Cobertura format (CI/CD friendly)
- `TestResults/coverage.opencover.xml` - OpenCover format (detailed)

### HTML Report
- `CoverageReport/index.html` - Main report page
- `CoverageReport/Summary.txt` - Text summary
- `CoverageReport/badge_linecoverage.svg` - Coverage badge

## 🎯 Coverage Thresholds

You can enforce minimum coverage thresholds:

```bash
dotnet test \
  /p:CollectCoverage=true \
  /p:Threshold=80 \
  /p:ThresholdType=line \
  /p:ThresholdStat=total
```

Options:
- **Threshold**: Minimum percentage (0-100)
- **ThresholdType**: `line`, `branch`, or `method`
- **ThresholdStat**: `total`, `average`, or `minimum`

## 🔍 Coverage Metrics

### Line Coverage
Percentage of code lines executed during tests.

### Branch Coverage
Percentage of decision points (if/else) tested.

### Method Coverage
Percentage of methods called during tests.

## 🎨 Report Types

ReportGenerator supports many formats:

```bash
-reporttypes:"Html;Badges;Cobertura;TextSummary;Xml;JsonSummary"
```

Available types:
- **Html** - Interactive HTML report
- **Badges** - SVG badges for README
- **Cobertura** - For Azure DevOps, Jenkins
- **TextSummary** - Console-friendly summary
- **SonarQube** - For SonarQube integration

## 🚫 Excluding Code from Coverage

### Exclude Entire Class
```csharp
[ExcludeFromCodeCoverage]
public class MyClass
{
    // ...
}
```

### Exclude Specific Method
```csharp
[ExcludeFromCodeCoverage]
public void MyMethod()
{
    // ...
}
```

### Exclude via Configuration
In test command:
```bash
/p:Exclude="[TestProject]*,[*.Tests]*,[*]*.Designer"
```

## 🔧 Configuration Options

### In Project File (.csproj)
```xml
<PropertyGroup>
  <CoverletOutput>./TestResults/</CoverletOutput>
  <CoverletOutputFormat>opencover,cobertura</CoverletOutputFormat>
  <Exclude>[xunit.*]*,[*.Tests]*</Exclude>
  <Include>[*]*</Include>
  <ExcludeByFile>**/Migrations/*.cs</ExcludeByFile>
</PropertyGroup>
```

### Via coverlet.runsettings
Create `coverlet.runsettings`:
```xml
<?xml version="1.0" encoding="utf-8" ?>
<RunSettings>
  <DataCollectionRunSettings>
    <DataCollectors>
      <DataCollector friendlyName="XPlat code coverage">
        <Configuration>
          <Format>opencover,cobertura</Format>
          <Exclude>[xunit.*]*</Exclude>
          <IncludeTestAssembly>false</IncludeTestAssembly>
        </Configuration>
      </DataCollector>
    </DataCollectors>
  </DataCollectionRunSettings>
</RunSettings>
```

Use it:
```bash
dotnet test --settings coverlet.runsettings
```

## 📈 Visual Studio Integration

### View Coverage in Visual Studio
1. Test → Analyze Code Coverage for All Tests
2. Or use the coverage scripts which generate HTML reports

### Live Coverage (VS Enterprise)
Visual Studio Enterprise has built-in live code coverage.

## 🔄 CI/CD Integration

### GitHub Actions
```yaml
name: Test Coverage

on: [push, pull_request]

jobs:
  test:
    runs-on: ubuntu-latest
    steps:
      - uses: actions/checkout@v3
      
      - name: Setup .NET
        uses: actions/setup-dotnet@v3
        with:
          dotnet-version: 8.0.x
      
      - name: Run tests with coverage
        run: dotnet test /p:CollectCoverage=true /p:CoverletOutputFormat=cobertura
      
      - name: Generate coverage report
        run: |
          dotnet tool install -g dotnet-reportgenerator-globaltool
          reportgenerator -reports:"**/coverage.cobertura.xml" -targetdir:"CoverageReport" -reporttypes:"Html;Badges"
      
      - name: Upload coverage report
        uses: actions/upload-artifact@v3
        with:
          name: coverage-report
          path: CoverageReport/
      
      - name: Comment coverage on PR
        uses: 5monkeys/cobertura-action@master
        with:
          path: '**/coverage.cobertura.xml'
          minimum_coverage: 75
```

### Azure DevOps
```yaml
- task: DotNetCoreCLI@2
  displayName: 'Run tests with coverage'
  inputs:
    command: test
    arguments: '/p:CollectCoverage=true /p:CoverletOutputFormat=cobertura'
    publishTestResults: true

- task: PublishCodeCoverageResults@1
  inputs:
    codeCoverageTool: 'Cobertura'
    summaryFileLocation: '**/coverage.cobertura.xml'
```

## 📊 Coverage Goals

| Coverage % | Rating |
|------------|--------|
| 90-100% | Excellent ⭐⭐⭐⭐⭐ |
| 80-89% | Good ⭐⭐⭐⭐ |
| 70-79% | Fair ⭐⭐⭐ |
| 60-69% | Poor ⭐⭐ |
| < 60% | Needs Improvement ⭐ |

**Recommended minimum: 80%**

## 🐛 Troubleshooting

### Coverage shows 0%
- Ensure test project references the main project
- Check that tests are actually running
- Verify Coverlet packages are installed

### ReportGenerator not found
Install globally:
```bash
dotnet tool install --global dotnet-reportgenerator-globaltool
```

### Permission denied (Linux/Mac)
```bash
chmod +x run-coverage.sh
```

### Multiple test projects
```bash
dotnet test /p:CollectCoverage=true /p:MergeWith="../coverage.json"
```

## 📚 Resources

- [Coverlet Documentation](https://github.com/coverlet-coverage/coverlet)
- [ReportGenerator](https://github.com/danielpalme/ReportGenerator)
- [Cobertura Format](https://cobertura.github.io/cobertura/)

## 🎓 Best Practices

1. **Run coverage locally** before committing
2. **Aim for 80%+** coverage
3. **Don't chase 100%** - focus on critical paths
4. **Test behavior**, not implementation
5. **Exclude generated code** from coverage
6. **Review uncovered lines** - they might indicate dead code
7. **Use coverage as a guide**, not a goal

## 💡 Example Output

```
Calculating coverage result...
  Generating report '../TestResults/coverage.opencover.xml'

+------------------+--------+--------+--------+
| Module           | Line   | Branch | Method |
+------------------+--------+--------+--------+
| LongestSequence  | 100%   | 100%   | 100%   |
+------------------+--------+--------+--------+

|       | Total | Covered | Uncovered |
|-------|-------|---------|-----------|
| Lines | 45    | 45      | 0         |
| Branch| 8     | 8       | 0         |

Test Run Successful.
Total tests: 19
     Passed: 19
```

## 🎯 Quick Reference

```powershell
# Full report with HTML
.\run-coverage.ps1

# Quick summary
.\quick-coverage.ps1

# Console only
dotnet test /p:CollectCoverage=true

# With threshold enforcement
dotnet test /p:CollectCoverage=true /p:Threshold=80

# Generate specific format
dotnet test /p:CollectCoverage=true /p:CoverletOutputFormat=cobertura
```

---

**Next Steps**: Run `.\run-coverage.ps1` to see your current code coverage!
