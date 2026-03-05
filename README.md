# Longest Increasing Subsequence Finder

A .NET 8 console application that finds the longest strictly increasing subsequence in an array of integers.

## Problem Description

Given an array of integers, find the longest subsequence where each element is strictly greater than the previous element.

**Example:**
- Input: `[6, 1, 5, 9, 2]`
- Output: `[1, 5, 9]`
- Explanation: The longest increasing subsequence has length 3

## Prerequisites

- .NET 8 SDK
- Docker Desktop (for containerization verification)

---

## How to Verify the Solution

### ✅ 1. Verify the Algorithm Works

#### Run Locally
```bash
# Clone the repository
git clone https://github.com/shilpagitdp/93e6cb2f-9d85-47b8-b37f-6de5468c37fa
cd 93e6cb2f-9d85-47b8-b37f-6de5468c37fa

# Build the solution
dotnet build

# Run with test data
dotnet run --project LongestSequenceSolution.csproj -- 6 1 5 9 2
# Expected output: 1 5 9

# Run in interactive mode
dotnet run --project LongestSequenceSolution.csproj
# Enter: 6 1 5 9 2
# Expected output: 1 5 9
```

---

### ✅ 2. Verify Unit Tests

#### Run All Tests
```bash
# Run tests
dotnet test

# Expected output:
# Test Run Successful.
# Total tests: 17
#      Passed: 17
```

#### Test Coverage Includes:
- Empty arrays
- Single elements
- Decreasing sequences
- Multiple equal-length subsequences
- Edge cases (nulls, duplicates)

---

### ✅ 3. Verify Code Coverage Reporting

#### Generate Coverage Report (Windows)
```powershell
# Run coverage script
.\run-coverage.ps1

# This will:
# 1. Run all tests with coverage collection
# 2. Generate HTML coverage report
# 3. Open report in browser automatically
```

#### What You'll See:
- Line coverage percentage
- Branch coverage percentage
- Interactive HTML report showing covered/uncovered lines
- Coverage report saved to: `CoverageReport/index.html`

#### Manual Coverage (Any Platform)
```bash
dotnet test /p:CollectCoverage=true /p:CoverletOutputFormat=cobertura
# Output shows coverage percentage in console
```

---

### ✅ 4. Verify Docker Containerization

#### Build Docker Image
```bash
docker build -t longest-sequence-solution .
```

#### Run Container with Test Data
```bash
# Test case 1
docker run --rm longest-sequence-solution 6 1 5 9 2
# Expected: 1 5 9

# Test case 2
docker run --rm longest-sequence-solution 3 1 2 5 4 6
# Expected: 1 2 4 6

# Test case 3
docker run --rm longest-sequence-solution 1 2 3 4 5
# Expected: 1 2 3 4 5
```

#### Run in Interactive Mode
```bash
docker run -it --rm longest-sequence-solution
# Then enter numbers when prompted
```

#### Using Docker Compose
```bash
# Build and run
docker compose up --build

# Stop
docker compose down
```

---

### ✅ 5. Verify Code Linting

#### Check Code Quality
```bash
# Build with code analysis
dotnet build

# The build uses:
# - .NET Code Analyzers (built-in)
# - EditorConfig rules for formatting
# - Minimum analysis mode (catches critical issues)
```

#### Code Quality Features:
- ✅ Naming conventions (PascalCase for classes/methods)
- ✅ Code formatting (indentation, spacing)
- ✅ Basic code analysis (null checks, potential bugs)
- ✅ Configured in `.editorconfig` and project file

---

## Project Structure

```
LongestSequenceSolution/
├── Program.cs                          # Main entry point
├── SubsequenceFinder.cs               # Core algorithm
├── LongestSequenceSolution.csproj     # Project file
├── Dockerfile                          # Docker configuration
├── docker-compose.yml                 # Docker Compose config
├── .dockerignore                      # Docker ignore rules
├── .editorconfig                      # Code formatting rules
├── .gitignore                         # Git ignore rules
├── run-coverage.ps1                   # Coverage script (Windows)
├── README.md                          # This file
└── TestProject1/
    ├── SubsequenceFinderTests.cs      # Unit tests
    └── LongestSequenceSolutionTests.csproj
```

---

## Quick Verification Checklist

- Run program: `dotnet run -- 6 1 5 9 2`
- Run tests: `dotnet test`
- Generate coverage: `.\run-coverage.ps1`
- Build Docker image: `docker build -t longest-sequence-solution .`
- Run container: `docker run --rm longest-sequence-solution 6 1 5 9 2`

---

## Technology Stack

- **.NET 8** - Latest LTS version
- **xUnit** - Unit testing framework
- **Coverlet** - Code coverage tool
- **ReportGenerator** - HTML coverage reports
- **Docker** - Containerization
- **EditorConfig** - Code formatting

---

## Test Coverage

The test suite includes 17 comprehensive test cases:
- Basic increasing sequences
- Edge cases (empty, single element)
- Decreasing sequences
- Multiple runs of same length (returns first)
- All duplicates
- Entire array is increasing
- Long sequences with multiple runs
- Null input validation

---
