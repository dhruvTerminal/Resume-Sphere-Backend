# Build stage
FROM mcr.microsoft.com/dotnet/sdk:8.0 AS build
WORKDIR /src

COPY ResumeAPI/ResumeAPI.csproj ResumeAPI/
RUN dotnet restore ResumeAPI/ResumeAPI.csproj

COPY . .
RUN dotnet publish ResumeAPI/ResumeAPI.csproj -c Release -o /app/publish /p:UseAppHost=false

# Runtime stage
FROM mcr.microsoft.com/dotnet/aspnet:8.0 AS runtime
WORKDIR /app
COPY --from=build /app/publish .

ENV ASPNETCORE_ENVIRONMENT=Production
EXPOSE 8080

CMD ["sh", "-c", "ASPNETCORE_URLS=http://0.0.0.0:${PORT:-8080} dotnet ResumeAPI.dll"]
