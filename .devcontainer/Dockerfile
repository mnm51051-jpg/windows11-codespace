FROM mcr.microsoft.com/devcontainers/base:ubuntu

# Install QEMU, KVM tools, and dependencies
RUN apt-get update && apt-get install -y \
    qemu-system-x86 \
    qemu-utils \
    ovmf \
    wget \
    curl \
    unzip \
    python3 \
    python3-pip \
    novnc \
    websockify \
    net-tools \
    procps \
    && apt-get clean \
    && rm -rf /var/lib/apt/lists/*

# Create workspace directories
RUN mkdir -p /workspace/vm /workspace/iso

# Copy the startup script
COPY start-windows.sh /usr/local/bin/start-windows.sh
RUN chmod +x /usr/local/bin/start-windows.sh

EXPOSE 8006
