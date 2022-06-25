FROM mcr.microsoft.com/dotnet/aspnet:3.1 AS base
WORKDIR /app
EXPOSE 80

FROM mcr.microsoft.com/dotnet/sdk:3.1 AS build
WORKDIR /src
COPY ["AvineshWebApplication/AvineshWebApplication.csproj", "AvineshWebApplication/"]
RUN dotnet restore "AvineshWebApplication/AvineshWebApplication.csproj"
COPY . .
WORKDIR "/src/AvineshWebApplication"
RUN dotnet build "AvineshWebApplication.csproj" -c Release -o /app

FROM build AS publish
RUN dotnet publish "AvineshWebApplication.csproj" -c Release -o /app

FROM base AS final
WORKDIR /app
COPY --from=publish /app .
ENTRYPOINT ["dotnet", "AvineshWebApplication.dll"]