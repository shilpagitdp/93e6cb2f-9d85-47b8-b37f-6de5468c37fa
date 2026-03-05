# Code Linting Quick Reference

## 🚀 Quick Commands

```bash
# Standard build with analysis
dotnet build

# Strict build (warnings as errors)
dotnet build /p:TreatWarningsAsErrors=true

# Clean build
dotnet clean && dotnet build

# Run tests with analysis
dotnet test
```

## 📋 Common Rules Cheat Sheet

### Naming Conventions
| Element | Convention | Example |
|---------|-----------|---------|
| Class | PascalCase | `SubsequenceFinder` |
| Interface | IPascalCase | `IRepository` |
| Method | PascalCase | `FindLongestSequence` |
| Property | PascalCase | `FirstName` |
| Private Field | _camelCase | `_maxLength` |
| Local Variable | camelCase | `tempValue` |
| Parameter | camelCase | `inputArray` |
| Constant | PascalCase | `MaxValue` |

### Code Style Rules
✅ Always use braces `{ }` for if/while/for statements  
✅ Opening brace `{` on new line  
✅ Use `var` only when type is obvious  
✅ Sort using directives (System first)  
✅ Remove unused variables  
✅ One statement per line  

## 🔧 Suppress Rules (Use Sparingly!)

### In Code
```csharp
#pragma warning disable CA1031 // Do not catch general exception types
try { /* code */ }
catch (Exception ex) { /* handle */ }
#pragma warning restore CA1031
```

### In .editorconfig
```ini
dotnet_diagnostic.CA1303.severity = none
```

## 🎯 Severity Levels

```ini
# In .editorconfig, change severity:
dotnet_diagnostic.RULE_ID.severity = error      # 🔴 Build fails
dotnet_diagnostic.RULE_ID.severity = warning    # ⚠️ Show warning
dotnet_diagnostic.RULE_ID.severity = suggestion # 💡 Subtle hint
dotnet_diagnostic.RULE_ID.severity = silent     # ℹ️ No UI
dotnet_diagnostic.RULE_ID.severity = none       # Disabled
```

## 📊 View Issues in Visual Studio

1. **Error List**: View → Error List (Ctrl+\, E)
2. **Filter by**: Errors | Warnings | Messages
3. **Double-click** to jump to issue

## 🔍 Common Issues & Fixes

### ❌ CA1062: Validate arguments of public methods
```csharp
// Fix: Add null check
public void Process(int[] data)
{
    if (data == null) throw new ArgumentNullException(nameof(data));
    // ...
}
```

### ❌ IDE0058: Expression value is never used
```csharp
// Usually disabled - safe to ignore
dotnet_diagnostic.IDE0058.severity = none
```

### ❌ SA1633: File must have header
```csharp
// Disabled in stylecop.json
"xmlHeader": false
```

### ❌ CS0219: Variable is assigned but never used
```csharp
// Fix: Remove the variable or use it
var x = 5;  // ❌ Remove if not used
Console.WriteLine(x);  // ✅ Or use it
```

## 🎨 EditorConfig Examples

```ini
# Prefer 'var' when type is obvious
csharp_style_var_when_type_is_apparent = true:suggestion

# Require braces
csharp_prefer_braces = true:warning

# Private fields with underscore
dotnet_naming_rule.private_fields_should_be_camel_case.severity = warning
```

## 🧪 Test Project Specific

Test projects have same rules as main project.

Common test suppressions:
```ini
# Allow public test methods without documentation
dotnet_diagnostic.CS1591.severity = none
```

## 📁 Configuration Files

- `.editorconfig` → Code style rules (all editors)
- `stylecop.json` → StyleCop specific settings
- `*.csproj` → Enable analyzers

## 🔄 CI/CD Integration

```yaml
# GitHub Actions
- name: Build with analysis
  run: dotnet build /p:TreatWarningsAsErrors=true
```

## 💡 Pro Tips

1. **Fix errors first**, then warnings, then suggestions
2. **Don't suppress** unless you have a good reason
3. **Document suppressions** with comments
4. **Run locally** before pushing to CI/CD
5. **Consistent team rules** - commit `.editorconfig`

## 📚 Resources

- Full docs: See `LINTING.md`
- StyleCop rules: https://github.com/DotNetAnalyzers/StyleCopAnalyzers
- .NET analyzers: https://learn.microsoft.com/en-us/dotnet/fundamentals/code-analysis/

---

**Quick Help**: Having issues? See [LINTING.md](LINTING.md) for detailed troubleshooting.
