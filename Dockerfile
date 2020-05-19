# FROM mcr.microsoft.com/dotnet/core/sdk:3.0 AS build-env
# WORKDIR /app

# # copy csproj and restore as distinct layers
# # COPY *.sln .
# COPY aspnetapp/*.csproj ./aspnetapp/
# RUN dotnet restore

# # copy everything else and build app
# COPY . ./
# WORKDIR /app/aspnetapp
# RUN dotnet publish -c Release -o out

# FROM mcr.microsoft.com/dotnet/core/aspnet:3.0 AS runtime
# WORKDIR /app
# COPY --from=build-env /app/aspnetapp/out ./
# ENTRYPOINT ["dotnet", "DockerAPI.dll"]

FROM mcr.microsoft.com/dotnet/core/sdk:3.1 AS build-env
WORKDIR /app

# copy csproj and restore as distinct layers
COPY *.csproj ./
RUN dotnet restore

# copy everything else and build
COPY . ./
RUN dotnet publish -c Release -o out

# build runtime image
FROM mcr.microsoft.com/dotnet/core/aspnet:3.1 AS runtime
WORKDIR /app
COPY --from=build-env /app/out ./
ENTRYPOINT ["dotnet", "DockerAPI.dll"]