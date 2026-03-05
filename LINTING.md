# Code Linting and Analysis Configuration

This project uses **StyleCop Analyzers** and **.NET Code Analyzers** to enforce code quality and style rules.

## What's Included

### 1. **StyleCop Analyzers**
- Enforces coding style and naming conventions
- Ensures consistent code formatting
- Detects common code quality issues

### 2. **.NET Code Analyzers**
- Built-in Microsoft analyzers
- Security and performance recommendations
- Best practice enforcement

### 3. **EditorConfig**
- Defines coding style preferences
- Works across different editors (Visual Studio, VS Code, Rider)
- Enforces naming conventions and formatting rules

## Configuration Files

### `.editorconfig`
Defines code style rules including:
- Naming conventions (PascalCase for classes, camelCase for private fields, etc.)
- Indentation and spacing rules
- Using directives organization
- Code preferences (var usage, braces, etc.)

### `stylecop.json`
StyleCop-specific settings:
- Documentation rules
- Ordering rules
- Layout rules
- Company name and copyright settings

## Project Settings

Both projects (`LongestSequenceSolution.csproj` and `LongestSequenceSolutionTests.csproj`) include:

```xml
<EnableNETAnalyzers>true</EnableNETAnalyzers>
<AnalysisMode>All</AnalysisMode>
<EnforceCodeStyleInBuild>true</EnforceCodeStyleInBuild>
```

## How to Use

### Build with Analysis
```powershell
# Standard build - shows warnings
dotnet build

# Treat warnings as errors (strict mode)
dotnet build /p:TreatWarningsAsErrors=true

# Build with detailed diagnostics
dotnet build -v detailed
```

### View Analysis Results in Visual Studio
1. Build the solution (Ctrl+Shift+B)
2. View **Error List** window (View → Error List)
3. Filter by:
   - **Errors** - Must be fixed
   - **Warnings** - Should be addressed
   - **Messages** - Informational

### Suppress Specific Rules

#### In Code (when appropriate)
```csharp
#pragma warning disable CA1031 // Do not catch general exception types
try
{
    // code
}
catch (Exception ex)
{
    // handle
}
#pragma warning restore CA1031
```

#### In .editorconfig
```ini
# Suppress specific rule globally
dotnet_diagnostic.CA1303.severity = none
```

#### In Project File
```xml
<PropertyGroup>
  <NoWarn>$(NoWarn);CA1303;CS1591</NoWarn>
</PropertyGroup>
```

## Common Rules Enforced

### Naming Conventions
- ✅ Classes, methods, properties: `PascalCase`
- ✅ Private fields: `_camelCase` (with underscore prefix)
- ✅ Interfaces: `IPascalCase` (starts with 'I')
- ✅ Local variables: `camelCase`

### Code Style
- ✅ Use braces for all control statements
- ✅ Place opening braces on new line
- ✅ Use `var` only when type is apparent
- ✅ Organize using directives (System first)
- ✅ No unused variables or parameters

### Code Quality
- ✅ Validate public method arguments
- ✅ Avoid catching general exceptions
- ✅ Use appropriate exception types
- ✅ Dispose resources properly
- ✅ Avoid hard-coded strings (localization)

## Severity Levels

| Level | Description | Build Impact |
|-------|-------------|--------------|
| `error` | Must be fixed | Build fails |
| `warning` | Should be addressed | Build succeeds |
| `suggestion` | Nice to have | Build succeeds |
| `silent` | Informational only | No impact |
| `none` | Disabled | No checking |

## Customize Rules

Edit `.editorconfig` to change rule severity:

```ini
# Make a rule an error
dotnet_diagnostic.CA1062.severity = error

# Make a rule a suggestion
dotnet_diagnostic.IDE0058.severity = suggestion

# Disable a rule
dotnet_diagnostic.CA1303.severity = none
```

## Integration with CI/CD

Add to your GitHub Actions workflow:

```yaml
- name: Build with code analysis
  run: dotnet build --configuration Release /p:TreatWarningsAsErrors=true

- name: Run code analysis
  run: dotnet build --no-restore /p:RunCodeAnalysis=true
```

## Installed Packages

### Main Project
- `StyleCop.Analyzers` (1.2.0-beta.556)
- `Microsoft.CodeAnalysis.NetAnalyzers` (8.0.0)

### Test Project
- Same analyzers as main project
- Ensures consistent code quality across all code

## Benefits

✅ **Consistency** - All code follows the same style  
✅ **Quality** - Catches potential bugs early  
✅ **Maintainability** - Easier to read and understand  
✅ **Team Collaboration** - Everyone follows same rules  
✅ **Best Practices** - Enforces .NET coding standards  

## VS Code Integration

Install the C# extension, and it will automatically use the `.editorconfig` file.

## Visual Studio Integration

Visual Studio 2022 automatically reads `.editorconfig` and applies the rules.

## Rider Integration

JetBrains Rider automatically detects and applies `.editorconfig` settings.

## Troubleshooting

### Too Many Warnings?
Start by setting `TreatWarningsAsErrors=false` and gradually fix issues.

### Rule Conflicts?
`.editorconfig` settings take precedence over StyleCop defaults.

### Build Slower?
Code analysis adds ~10-20% to build time. You can disable for Debug builds:

```xml
<PropertyGroup Condition="'$(Configuration)' == 'Debug'">
  <EnforceCodeStyleInBuild>false</EnforceCodeStyleInBuild>
</PropertyGroup>
```

## Resources

- [StyleCop Analyzers Documentation](https://github.com/DotNetAnalyzers/StyleCopAnalyzers)
- [.NET Code Analysis](https://learn.microsoft.com/en-us/dotnet/fundamentals/code-analysis/overview)
- [EditorConfig Documentation](https://editorconfig.org/)
