# Dockerfile
FROM alpine:3.20

ARG PB_VERSION=0.36.2
ARG TARGETARCH

RUN apk add --no-cache ca-certificates unzip wget \
  && mkdir -p /pb

# Pick correct PocketBase binary for the build architecture
RUN case "$TARGETARCH" in \
      amd64) PB_ARCH="amd64" ;; \
      arm64) PB_ARCH="arm64" ;; \
      *) echo "Unsupported arch: $TARGETARCH" && exit 1 ;; \
    esac \
 && wget -qO /tmp/pb.zip "https://github.com/pocketbase/pocketbase/releases/download/v${PB_VERSION}/pocketbase_${PB_VERSION}_linux_${PB_ARCH}.zip" \
 && unzip /tmp/pb.zip -d /pb \
 && rm -f /tmp/pb.zip \
 && chmod +x /pb/pocketbase

EXPOSE 8090

# Azure App Service persists /home when WEBSITES_ENABLE_APP_SERVICE_STORAGE=true
CMD ["/bin/sh","-c","mkdir -p /home/pb_data && exec /pb/pocketbase serve --http=0.0.0.0:8090 --dir=/home/pb_data"]
