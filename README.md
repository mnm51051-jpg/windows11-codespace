# 🖥️ Windows 11 on GitHub Codespaces

Run Windows 11 inside a GitHub Codespace using QEMU/KVM and access it through your browser via noVNC!

![Windows 11](https://img.shields.io/badge/Windows-11-0078D6?style=for-the-badge&logo=windows11&logoColor=white)
![GitHub Codespaces](https://img.shields.io/badge/GitHub-Codespaces-181717?style=for-the-badge&logo=github&logoColor=white)

## 🚀 Quick Start

### 1. Create a GitHub Repository

Push this project to a new GitHub repository:

```bash
git init
git add .
git commit -m "Initial commit: Windows 11 Codespace"
git remote add origin https://github.com/YOUR_USERNAME/windows11-codespace.git
git branch -M main
git push -u origin main
```

### 2. Launch the Codespace

1. Go to your repository on GitHub
2. Click the green **"<> Code"** button
3. Select the **"Codespaces"** tab
4. Click **"Create codespace on main"**
5. **⚠️ Important:** Select at least a **4-core** machine type (8-core recommended)

### 3. Access Windows 11

Once the Codespace starts:

1. Wait for the containers to initialize (~2-3 minutes)
2. The forwarded port **8006** should appear in the **Ports** tab
3. Click the **globe icon** 🌐 next to port 8006 to open noVNC in your browser
4. Windows 11 installation will begin automatically!
5. The full installation takes **~15-20 minutes** — be patient!

## ⚙️ Configuration

You can customize the VM by editing `docker-compose.yml`:

| Variable    | Default | Description              |
|-------------|---------|--------------------------|
| `VERSION`   | `win11` | Windows version          |
| `RAM_SIZE`  | `8G`    | RAM allocated to VM      |
| `CPU_CORES` | `4`     | CPU cores for VM         |
| `DISK_SIZE` | `32G`   | Virtual disk size        |

### Supported Windows Versions

| Value      | Version              |
|------------|----------------------|
| `win11`    | Windows 11 Pro       |
| `win10`    | Windows 10 Pro       |
| `win11e`   | Windows 11 Enterprise|
| `win10e`   | Windows 10 Enterprise|
| `ltsc10`   | Windows 10 LTSC      |

## 📋 Requirements

- **GitHub account** with Codespaces access
- **Codespace machine type:** 4-core minimum (8-core recommended)
- **Patience:** Windows installation takes 15-20 minutes

## 🔧 How It Works

```
GitHub Codespace (Linux VM)
  └── Docker
       └── dockur/windows container
            ├── QEMU/KVM (hardware virtualization)
            │    └── Windows 11 VM
            └── noVNC (web-based VNC at port 8006)
```

1. **GitHub Codespace** provides a Linux cloud VM with Docker
2. **dockur/windows** runs a QEMU virtual machine inside Docker
3. **KVM** provides hardware-accelerated virtualization
4. **noVNC** gives you browser-based access to the Windows desktop

## ⚠️ Important Notes

- **Performance:** Windows will run slower than native since it's virtualized inside a container inside a cloud VM
- **Costs:** Codespaces usage counts toward your monthly included hours. Larger machine types cost more
- **Storage:** The VM state persists within the Codespace but is lost when the Codespace is deleted
- **Auto-shutdown:** Codespaces auto-stop after inactivity. Your Windows VM state is preserved on restart
- **Licensing:** This uses Windows evaluation/trial. For production use, you need a valid license

## 🎯 Tips

- Use a **8-core / 32GB** machine type for the best experience
- Close unused browser tabs to free up resources
- The **RDP port (3389)** is also exposed if you prefer using an RDP client
- You can pass a custom Windows ISO by adding `DISK_PATH` environment variable

## 📜 Credits

- [dockur/windows](https://github.com/dockur/windows) — Windows inside Docker
- [GitHub Codespaces](https://github.com/features/codespaces) — Cloud development environments
