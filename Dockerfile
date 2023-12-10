FROM rust:1.74 as builder

# Setup base
ARG WOLAPP_VERSION="0.0.2"

WORKDIR /app

RUN wget https://github.com/Tchoupinax/wolapp/archive/refs/tags/v$WOLAPP_VERSION.tar.gz && \
    tar xvf v$WOLAPP_VERSION.tar.gz && \
    mv wolapp-$WOLAPP_VERSION/* .

RUN cargo build --release

###
###
###

ARG BUILD_FROM=ghcr.io/hassio-addons/base:15.0.1
FROM ${BUILD_FROM}

# Build arguments
ARG BUILD_ARCH
ARG BUILD_DATE
ARG BUILD_DESCRIPTION
ARG BUILD_NAME
ARG BUILD_REF
ARG BUILD_REPOSITORY
ARG BUILD_VERSION

# Labels
LABEL \
    io.hass.name="${BUILD_NAME}" \
    io.hass.description="${BUILD_DESCRIPTION}" \
    io.hass.arch="${BUILD_ARCH}" \
    io.hass.type="addon" \
    io.hass.version=${BUILD_VERSION}
    
WORKDIR /app

COPY --from=builder /app/target/release/wolapp /app/wolapp
COPY --from=builder /app/views /app/views

EXPOSE 5644

CMD ["/app/wolapp"]
