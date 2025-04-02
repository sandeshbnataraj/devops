Sure thing, Sandesh! Here's your **README.md** in full Markdown format — tailored for your `setup.sh` script, clean, clear, and ready for GitHub or any portfolio project. Just copy-paste into a file named `README.md`:

---

```md
# 🚀 DevOps EC2 Provisioner – setup.sh

Automate your EC2 instance like a DevOps pro.  
This `setup.sh` script provisions a fresh **Ubuntu EC2 instance** with everything you need to hit the ground running — packages, firewall, user/group setup, tool access restrictions, and dry-run safety built in.

---

## 🔧 Features

- ✅ **Package Management** (`apt install`, `remove`, `purge`, `autoremove`)
- 🔐 **Firewall Setup** using `ufw` with SSH-only default rules
- 👤 **User & Group Creation** with validation
- 📦 **Restrict Tools to Groups** (e.g. podman → devops)
- 🧪 **Dry Run Mode** for safe testing before execution
- 📜 **Logging** with timestamps to `~/provisioner/install.log`
- 📚 **DevOps Tool Installer** with interactive CLI menu

---

## 📁 Directory Structure

```
~/provisioner/
└── install.log         # Auto-generated install log file
```

---

## 🧪 Usage

Make the script executable:

```bash
chmod +x setup.sh
```

Run with any combination of flags:

```bash
./setup.sh --newlog --install curl --add-user-account devuser
```

---

## 📝 CLI Options

| Flag                           | Description                                       |
|-------------------------------|---------------------------------------------------|
| `--install <pkg>`             | Install a package (e.g. `git`, `curl`)            |
| `--remove <pkg>`              | Uninstall and clean a package                     |
| `--install-devops`            | Launch DevOps tools installer menu                |
| `--newlog`                    | Overwrite the existing install log                |
| `--dry-run`                   | Simulate all actions (no actual changes)          |
| `--add-user-account <user>`   | Create a system user                              |
| `--add-user-group <group>`    | Create a system group                             |
| `--assign-user-group <user> <group>` | Add user to a group                      |
| `--restrict-tool <group> <bin>` | Restrict access to a tool to specific group   |
| `--setup-firewall`            | Apply secure firewall defaults                   |
| `--enable-firewall`           | Enable UFW                                        |
| `--disable-firewall`          | Disable UFW                                       |
| `--firewall-status`           | Show UFW rule status                              |
| `--allow-port <port>`         | Open a port in firewall                           |
| `--block-port <port>`         | Block a port in firewall                          |
| `--help` / `-h`               | Display usage instructions                        |

---

## 📦 Example Commands

```bash
./setup.sh --newlog --install-devops
./setup.sh --add-user-account devuser --add-user-group devops
./setup.sh --assign-user-group devuser devops
./setup.sh --restrict-tool devops podman
./setup.sh --setup-firewall --enable-firewall
```

Use `--dry-run` to simulate actions safely:

```bash
./setup.sh --dry-run --install nginx
```

---

## 🛡️ Default Firewall Behavior

When using `--setup-firewall`, the script:

- Allows **only SSH** (`22/tcp`)
- Denies **all incoming** by default
- Allows **all outgoing** by default

You can open specific ports using `--allow-port <port>` as needed.

---

## ⚠️ Requirements

- Ubuntu 20.04+ (tested on EC2)
- `sudo` privileges

---

## 👨‍💻 Author

**Sandesh Nataraj**  
DevOps Learner | Automation Enthusiast | Cloud Explorer 🚀

---