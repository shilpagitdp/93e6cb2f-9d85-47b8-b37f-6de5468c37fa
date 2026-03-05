# Use the official .NET 8 SDK image for building
FROM mcr.microsoft.com/dotnet/sdk:8.0 AS build
WORKDIR /src

# Copy project files
COPY ["LongestSequenceSolution.csproj", "./"]
RUN dotnet restore "LongestSequenceSolution.csproj"

# Copy all source files
COPY . .

# Build the application
RUN dotnet build "LongestSequenceSolution.csproj" -c Release -o /app/build

# Publish the application
FROM build AS publish
RUN dotnet publish "LongestSequenceSolution.csproj" -c Release -o /app/publish /p:UseAppHost=false

# Use the runtime image for the final stage
FROM mcr.microsoft.com/dotnet/runtime:8.0 AS final
WORKDIR /app

# Copy the published application from the publish stage
COPY --from=publish /app/publish .

# Set the entry point
ENTRYPOINT ["dotnet", "LongestSequenceSolution.dll"]
