# Stage 1: Build
FROM golang:1.17.3-alpine3.15 AS build

ARG VERSION
ENV VERSION=${VERSION:-development}

ENV LIBVIRT_EXPORTER_PATH=/libvirt-exporter
ENV LIBVIRT_DOMAIN_LABEL=name

# Install Build packages
RUN apk add --no-cache ca-certificates g++ git libnl-dev make libvirt-dev

WORKDIR $LIBVIRT_EXPORTER_PATH
COPY . .

# Build Go binary (small binary option: -s -w)
RUN go build -ldflags="-X 'main.Version=${VERSION}' -s -w" -trimpath -mod vendor -o libvirt-exporter

# Stage 2: Runtime
FROM alpine:3.15

RUN apk add --no-cache ca-certificates libvirt

COPY --from=build /libvirt-exporter /

EXPOSE 9177
ENTRYPOINT [ "/libvirt-exporter" ]
