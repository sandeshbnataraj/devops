# 🐳 Podman Installation Guide (Ubuntu)

This guide walks you through two clean and supported ways to install **Podman** on Ubuntu:

---

## ⚙️ Method 1: Install Podman via APT (Official Repo)

This installs Podman using the **official upstream APT repository**, with full system integration.

### ✅ Best For:
- System-wide usage
- Servers / Production
- Full control over configuration

### 🧭 Steps:

#### 1. Check Ubuntu Version
```bash
. /etc/os-release
echo "Ubuntu Version: $VERSION_ID"
```

#### 2. Add Podman APT Source
```bash
echo "deb https://download.opensuse.org/repositories/devel:/kubic:/libcontainers:/stable/xUbuntu_${VERSION_ID}/ /" \
  | sudo tee /etc/apt/sources.list.d/podman.list
```

#### 3. Add GPG Key (Security!)
```bash
curl -fsSL https://download.opensuse.org/repositories/devel:/kubic:/libcontainers:/stable/xUbuntu_${VERSION_ID}/Release.key \
  | gpg --dearmor \
  | sudo tee /usr/share/keyrings/libcontainers-archive-keyring.gpg > /dev/null
```

#### 4. Update and Install Podman
```bash
sudo apt update
sudo apt install -y podman
```

---

## 🚀 Method 2: Install Podman via Snap

This installs Podman using **Snap**, which is sandboxed and easy to manage.

### ✅ Best For:
- Developer machines
- Quick setups
- Minimal system interference

### 🧭 Step:

```bash
sudo snap install podman --classic
```

---

## ⚔️ Comparison: APT vs Snap

| Feature                    | APT Method            | Snap Method            |
|----------------------------|------------------------|-------------------------|
| Requires repo setup        | ✅ Yes                 | ❌ No                   |
| Needs GPG key              | ✅ Yes                 | ❌ No                   |
| Gets system updates        | ✅ Yes                 | ✅ Yes                  |
| Sandboxed                  | ❌ No                  | ✅ Yes                  |
| Launch speed               | ✅ Fast                | ⚠️ Slower on first run  |
| Best for                   | Servers / Production   | Dev / Quick Use         |

---

## 💡 Tip:
Start with Snap if you're experimenting. Move to APT when you want full control.

