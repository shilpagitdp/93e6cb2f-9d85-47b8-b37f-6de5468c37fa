# Code Coverage Quick Reference

## 🚀 Run Coverage (Choose One)

### Windows PowerShell
```powershell
# Full HTML report (opens in browser)
.\run-coverage.ps1

# Quick console summary only
.\quick-coverage.ps1
```

### Linux/Mac
```bash
chmod +x run-coverage.sh
./run-coverage.sh
```

### Manual
```bash
# Basic coverage
dotnet test /p:CollectCoverage=true

# With OpenCover format
dotnet test /p:CollectCoverage=true /p:CoverletOutputFormat=opencover

# Generate HTML report
reportgenerator -reports:"**/coverage.opencover.xml" -targetdir:"CoverageReport" -reporttypes:"Html"
```

## 📊 Coverage Formats

```bash
# Single format
/p:CoverletOutputFormat=opencover

# Multiple formats
/p:CoverletOutputFormat="json,cobertura,opencover"
```

## 🎯 Thresholds

```bash
# Enforce minimum 80% line coverage
dotnet test /p:CollectCoverage=true /p:Threshold=80 /p:ThresholdType=line

# Enforce branch coverage
dotnet test /p:CollectCoverage=true /p:Threshold=75 /p:ThresholdType=branch
```

## 🚫 Exclusions

```bash
# Exclude assemblies
/p:Exclude="[xunit.*]*,[*.Tests]*"

# Exclude specific namespace
/p:Exclude="[*]MyNamespace.Generated.*"
```

## 📁 Output Locations

```
TestResults/
├── coverage.json
├── coverage.cobertura.xml
└── coverage.opencover.xml

CoverageReport/
├── index.html           # Main report
├── Summary.txt          # Text summary
└── badges/              # SVG badges
```

## 🔧 Install ReportGenerator

```bash
dotnet tool install --global dotnet-reportgenerator-globaltool
```

## 📈 Reading Results

```
+------------------+--------+--------+--------+
| Module           | Line   | Branch | Method |
+------------------+--------+--------+--------+
| MyProject        | 85.5%  | 75.0%  | 90.0%  |
+------------------+--------+--------+--------+
```

- **Line**: % of code lines executed
- **Branch**: % of decision paths tested  
- **Method**: % of methods called

## 🎨 Report Types

```bash
-reporttypes:"Html"                    # HTML only
-reporttypes:"Html;Badges"             # HTML + badges
-reporttypes:"Html;Cobertura;Badges"   # Multiple types
```

## 🔄 CI/CD

### GitHub Actions
```yaml
- run: dotnet test /p:CollectCoverage=true /p:CoverletOutputFormat=cobertura
- uses: codecov/codecov-action@v3
  with:
    files: '**/coverage.cobertura.xml'
```

### Azure DevOps
```yaml
- task: DotNetCoreCLI@2
  inputs:
    command: test
    arguments: '/p:CollectCoverage=true /p:CoverletOutputFormat=cobertura'
```

## 💯 Coverage Goals

| Range | Rating |
|-------|--------|
| 90-100% | ⭐⭐⭐⭐⭐ Excellent |
| 80-89% | ⭐⭐⭐⭐ Good |
| 70-79% | ⭐⭐⭐ Fair |
| < 70% | ⭐⭐ Needs Work |

**Target: 80%+**

## 🐛 Common Issues

**ReportGenerator not found?**
```bash
dotnet tool install --global dotnet-reportgenerator-globaltool
```

**Coverage shows 0%?**
- Check tests pass: `dotnet test`
- Verify project references
- Check packages installed

**Permission denied (Linux/Mac)?**
```bash
chmod +x run-coverage.sh
```

## 📚 More Info

- Full docs: [COVERAGE.md](COVERAGE.md)
- Setup summary: [COVERAGE_SETUP_SUMMARY.md](COVERAGE_SETUP_SUMMARY.md)
- Main README: [README.md](README.md)

---

**Quick Start**: Run `.\run-coverage.ps1` now!
