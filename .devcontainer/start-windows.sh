#!/bin/bash
set -e

VM_DIR="/workspace/vm"
ISO_DIR="/workspace/iso"
DISK_FILE="$VM_DIR/windows11.qcow2"
DISK_SIZE="32G"
RAM="4G"
CPUS="2"
VNC_PORT=8006

echo "============================================="
echo "  Windows 11 on GitHub Codespace"
echo "============================================="

# Create virtual disk if it doesn't exist
if [ ! -f "$DISK_FILE" ]; then
    echo "[*] Creating virtual disk ($DISK_SIZE)..."
    qemu-img create -f qcow2 "$DISK_FILE" "$DISK_SIZE"
fi

# Check for Windows ISO
ISO_FILE=$(find "$ISO_DIR" -name "*.iso" -type f | head -1)

# Build QEMU command
QEMU_ARGS=(
    -machine type=q35,accel=kvm:tcg
    -cpu max
    -smp "$CPUS"
    -m "$RAM"
    -drive "file=$DISK_FILE,format=qcow2,if=virtio"
    -bios /usr/share/ovmf/OVMF.fd
    -device virtio-net-pci,netdev=net0
    -netdev user,id=net0,hostfwd=tcp::3389-:3389
    -vnc :0
    -device virtio-vga
    -device virtio-tablet-pci
    -boot d
    -daemonize
)

# Add ISO if found
if [ -n "$ISO_FILE" ]; then
    echo "[*] Found Windows ISO: $ISO_FILE"
    QEMU_ARGS+=(-cdrom "$ISO_FILE")
else
    echo ""
    echo "⚠️  No Windows ISO found!"
    echo ""
    echo "To get started, download a Windows 11 ISO:"
    echo "  1. Go to: https://www.microsoft.com/software-download/windows11"
    echo "  2. Download the ISO file"
    echo "  3. Upload it to: $ISO_DIR/"
    echo "  4. Re-run this script: start-windows.sh"
    echo ""
    echo "Or use wget to download directly (if you have a direct link):"
    echo "  wget -O $ISO_DIR/windows11.iso 'YOUR_DOWNLOAD_LINK'"
    echo ""
    
    # Still start QEMU (will boot to UEFI shell)
    echo "[*] Starting QEMU without ISO (will boot to UEFI shell)..."
fi

echo "[*] Starting QEMU VM..."
echo "    RAM: $RAM | CPUs: $CPUS | Disk: $DISK_SIZE"
qemu-system-x86_64 "${QEMU_ARGS[@]}"

echo "[*] Starting noVNC on port $VNC_PORT..."
# Start websockify to bridge noVNC to QEMU's VNC
/usr/share/novnc/utils/novnc_proxy --vnc localhost:5900 --listen $VNC_PORT &

echo ""
echo "============================================="
echo "  ✅ Windows 11 VM is running!"
echo "============================================="
echo ""
echo "  Access via browser: Open forwarded port $VNC_PORT"
echo "  (Check the Ports tab in your Codespace)"
echo ""
echo "  To stop the VM: kill \$(pgrep qemu)"
echo "============================================="

# Keep the script running
wait
