FROM caddy:builder-alpine AS builder

RUN xcaddy build --with github.com/aksdb/caddy-cgi@v2.2.0 --with github.com/greenpau/caddy-security@v1.1.19

FROM mcr.microsoft.com/powershell:latest
COPY --from=builder /usr/bin/caddy /usr/bin/caddy
WORKDIR /app
COPY ./launchdocker.ps1 ./launch.ps1
COPY Caddyfile .

COPY ./public ./public
COPY ./cgi ./cgi

RUN ["chmod","-R","+x","/app/cgi"]
RUN ["chmod","-R","+r","/app"]
CMD ["pwsh","launch.ps1"]
EXPOSE 9054
