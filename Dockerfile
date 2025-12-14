# Stage 1: Builder
FROM ubuntu:24.04 AS builder

# Install necessary tools
RUN apt-get update && \
    apt-get install -y curl tar && \
    rm -rf /var/lib/apt/lists/*

# Set working directory
WORKDIR /tmp

# Download NixOS WSL tarball
RUN curl -L -o nixos.tar.gz https://github.com/nix-community/NixOS-WSL/releases/download/2505.7.0/nixos.wsl

# Extract tarball
RUN mkdir rootfs && tar -xzf nixos.tar.gz -C rootfs

# Stage 2: Final image
FROM scratch

# Copy extracted root filesystem from builder
COPY --from=builder /tmp/rootfs/ /

# Set default command
CMD ["/bin/sh"]
