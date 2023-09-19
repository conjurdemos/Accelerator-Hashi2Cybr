# syntax=docker/dockerfile:1
FROM golang:1.21 as build

ARG TARGETOS TARGETARCH

RUN mkdir -p /src/bin
RUN cat /etc/os-release

WORKDIR /src
RUN git clone https://github.com/infamousjoeg/cybr-cli.git
RUN git clone https://github.com/davidh-cyberark/vault-safe-cli.git

# Cybr CLI - <https://github.com/infamousjoeg/cybr-cli>
WORKDIR /src/cybr-cli
RUN CGO_ENABLED=0 GOOS=$TARGETOS GOARCH=$TARGETARCH make build
RUN chmod +x ./bin/cybr && cp ./bin/cybr /src/bin/cybr

# Safe - <https://github.com/davidh-cyberark/vault-safe-cli>
WORKDIR /src/vault-safe-cli
RUN CGO_ENABLED=0 GOOS=$TARGETOS GOARCH=$TARGETARCH make build
RUN chmod +x ./safe && cp ./safe /src/bin/safe


# Scripts that implement the steps to migrate 
COPY ["./migrate.sh", "/src/bin/migrate.sh"]
COPY ["./export.sh", "/src/bin/export.sh"]
COPY ["./account_upload.sh", "/src/bin/account_upload.sh"]

RUN chmod +x /src/bin/migrate.sh
RUN chmod +x /src/bin/export.sh
RUN chmod +x /src/bin/account_upload.sh


# Create running image
FROM alpine:latest

COPY --from=build /src/bin/* /bin

RUN apk update
RUN apk add --no-cache bash jq

# Mount point for tmpfs
RUN mkdir /data

WORKDIR /data

CMD ["/bin/migrate.sh"]
