# Longest Increasing Subsequence Finder

A .NET 8 console application that finds the longest strictly increasing subsequence in an array of integers.

## Description

This application implements an algorithm to find the longest strictly increasing subsequence from a given array of numbers. A subsequence is a sequence that appears in the same relative order, but not necessarily contiguous.

## Features

- Interactive console interface
- Command-line argument support for automated testing
- Efficient algorithm for finding longest increasing subsequences
- Comprehensive unit tests
- Docker support for easy deployment
- **Code linting and analysis** with StyleCop and .NET analyzers

## Prerequisites

### Running Locally
- .NET 8 SDK

### Running with Docker
- Docker Desktop or Docker Engine

## Quick Start with Docker

### 1. Build the Docker image
```bash
docker build -t longest-sequence-solution .
```

### 2. Run the application with test data
```bash
docker run --rm longest-sequence-solution 6 1 5 9 2
```
**Output:** `1 5 9`

### 3. Run in interactive mode
```bash
docker run -it --rm longest-sequence-solution
```

## Running the Application

### Local Development

```bash
# Build the solution
dotnet build

# Run interactively
dotnet run --project LongestSequenceSolution.csproj

# Run with arguments
dotnet run --project LongestSequenceSolution.csproj -- 6 1 5 9 2

# Run tests
dotnet test
```

### Using Docker

#### Quick Test with Command-Line Arguments (Recommended)

```bash
# Build the Docker image
docker build -t longest-sequence-solution .

# Test with arguments (best for automated testing)
docker run --rm longest-sequence-solution 6 1 5 9 2
# Output: 1 5 9

docker run --rm longest-sequence-solution 3 1 2 5 4 6
# Output: 1 2 4 6

docker run --rm longest-sequence-solution 1 2 3 4 5
# Output: 1 2 3 4 5
```

#### Interactive Mode

```bash
# Run interactively (allows user input)
docker run -it --rm longest-sequence-solution
```

#### Piping Input

```bash
# Pipe input for batch testing
echo "6 1 5 9 2" | docker run -i --rm longest-sequence-solution
```

#### Using Docker Compose

```bash
# Build and run with docker-compose
docker compose up --build

# Run in detached mode
docker compose up -d

# Attach to running container for interactive input
docker attach longest-sequence-app

# Stop the container
docker compose down
```

#### Run Tests in Docker

```bash
# Build and run tests
docker build -f Dockerfile.test -t longest-sequence-solution-test .
```

## Code Quality and Linting

This project uses **StyleCop Analyzers** and **.NET Code Analyzers** to enforce code quality standards.

### Build with Code Analysis
```bash
# Standard build with warnings
dotnet build

# Strict mode (treat warnings as errors)
dotnet build /p:TreatWarningsAsErrors=true
```

### Configuration Files
- `.editorconfig` - Code style rules and naming conventions
- `stylecop.json` - StyleCop-specific settings

For detailed information about code linting, see [LINTING.md](LINTING.md).

## Usage Examples

### Command-Line Mode (Automated Testing)

```bash
docker run --rm longest-sequence-solution 6 1 5 9 2
# Output: 1 5 9
```

### Interactive Mode

```
Longest Increasing Subsequence Calculator
Enter numbers separated by spaces (or 'exit' to stop)

Enter numbers: 6 1 5 9 2
Output: 1 5 9

Enter numbers: 3 1 2 5 4 6
Output: 1 2 4 6

Enter numbers: exit
```

## Algorithm

The application finds the longest strictly increasing subsequence where each element must be greater than the previous element (not greater than or equal to).

### Example

Input: `[6, 1, 5, 9, 2]`
Output: `[1, 5, 9]`

Explanation: The longest increasing subsequence is `[1, 5, 9]` with length 3.

## Project Structure

```
LongestSequenceSolution/
├── Program.cs                    # Main entry point
├── SubsequenceFinder.cs         # Core algorithm implementation
├── LongestSequenceSolution.csproj
├── Dockerfile                    # Docker configuration
├── Dockerfile.test              # Docker test configuration
├── docker-compose.yml           # Docker Compose configuration
├── .dockerignore                # Docker ignore patterns
├── .gitignore                   # Git ignore patterns
├── .editorconfig                # Code style configuration
├── stylecop.json                # StyleCop settings
├── LINTING.md                   # Code linting documentation
└── TestProject1/
    ├── SubsequenceFinderTests.cs
    └── LongestSequenceSolutionTests.csproj
```

## Testing

The solution includes comprehensive unit tests using xUnit.

```bash
# Run all tests
dotnet test

# Run tests with detailed output
dotnet test --logger "console;verbosity=detailed"

# Run tests with coverage
dotnet test /p:CollectCoverage=true
```

## Docker Testing Scenarios

### Scenario 1: Automated Test Suite
```bash
# Test multiple cases
docker run --rm longest-sequence-solution 6 1 5 9 2
docker run --rm longest-sequence-solution 24795 1710 2461 9288 10195 10431 12485 12292
docker run --rm longest-sequence-solution 3862 16353 22813 28735
```

### Scenario 2: LeetCode-Style Testing
```bash
# Single line output for automated verification
docker run --rm longest-sequence-solution 6 1 5 9 2 | grep "1 5 9"
echo $?  # Should return 0 if successful
```

### Scenario 3: Batch Testing with File Input (PowerShell)
```powershell
# Create test file
"6 1 5 9 2" | Out-File input.txt
"3 1 2 5 4 6" | Add-Content input.txt

# Test each line
Get-Content input.txt | ForEach-Object {
    Write-Host "Input: $_"
    $_ | docker run -i --rm longest-sequence-solution
}
```

## Docker Image Details

- **Base Image**: `mcr.microsoft.com/dotnet/runtime:8.0`
- **Build Image**: `mcr.microsoft.com/dotnet/sdk:8.0`
- **Multi-stage build**: Optimized for smaller final image size
- **Image Type**: Console application (no web server or port exposure needed)
- **Supports**: Interactive mode, command-line arguments, and piped input

## Differences from Web Applications

This is a **console application**, not a web application:
- ❌ No port mapping needed (no `-p 8080:80`)
- ❌ No browser access
- ✅ Runs via command line with arguments or interactive input
- ✅ Perfect for automated testing and scripting

## License

This project is available for educational and demonstration purposes.

## Contributing

Feel free to submit issues and enhancement requests!
