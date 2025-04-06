# 🚀 DevOps

Welcome to my **DevOps** project — a structured and evolving repository of notes, scripts, and automation tools as I build hands-on expertise across the DevOps ecosystem.

This repo starts with Linux fundamentals and scripting, and will grow to include containerization, CI/CD pipelines, infrastructure as code, monitoring, and more.

---

## 📂 Repository Structure

```bash
devops/
├── Linux/
│   ├── notes/                  # Core Linux notes, guides, and cheat sheets
│   └── projects/             # Hands-on Linux-based automation projects
│       └── auto_provision/     # EC2 provisioning, firewall setup, and SSH hardening
│       └── auto_monitor/       # System monitoring and alerting setup
├── Git/
│   ├── notes/                  # Git basics, SSH setup, and remote repo management
│   └── projects/               # (coming soon) Git automation scripts and workflows
├── Docker/                     # (Coming soon) Containerization workflows
├── CI-CD/                      # (Coming soon) GitLab/Jenkins pipelines and automation
├── Kubernetes/                # (Coming soon) K8s manifests and cluster experiments
├── Monitoring/                # (Coming soon) Prometheus, Grafana, logging setup
└── README.md
```

---

## ✅ What’s Included So Far


### 🔧 Linux Notes & Guides

- [Linux Basics](Linux/notes/Linux_basics.md)
- [Shell Scripting Survival Guide](Linux/notes/shell_scripting_survival_guide.md)
- [Podman Installation (via External APT)](Linux/notes/podman_installation_guide.md)
- [DevOps Linux Skills Checklist](Linux/notes/devops_linux_skills_checklist.md)
- [Adding External APT Repositories](Linux/notes/add_external_apt_repo_guide.md)
- [Adding PPAs on Ubuntu](Linux/notes/add_ppa_ubuntu_guide.md)
- [User Management Cheat Sheet](Linux/notes/linux_user_mgmt_cheatsheet.md)
- [Group Management Cheat Sheet](Linux/notes/linux_group_mgmt_cheatsheet.md)
- [DevOps Bash Cheat Sheet](Linux/notes/devOps_bash_cheat_sheet.md)


### ⚙️ Automation Projects
- [`auto_provision`](Linux/projects/auto_provision/setup.sh): Bash script that provisions an EC2-like environment with:
  - Secure user and group setup
  - UFW-based firewall configuration
  - Port control with dry-run support
  - SSH key setup
  - Logging and validations

- [`auto_monitor`](Linux/projects/auto_monitor/monitor.sh): Bash script that provisions a monitoring setup with:
  - Full System Health Checks (Disk, Memory, CPU, Users, Services)
  - Alerting when thresholds are breached (Disk > 80%, Memory < 20%, CPU Overload)
  - Summary Report
  - Cron-based Daemon Mode
  - Log Management with Timestamped Logging
  - Built-in Help Menu
  - Clean Logging Format with [INFO] and [ERROR] tags

---

### 🔧 GIT Notes & Guides

   - [Git Bascis](Git/notes/basic_commands.md)

---

## 📦 Coming Soon

- Dockerfile-based service packaging
- GitLab CI/CD workflows for code and infrastructure
- Kubernetes deployment templates
- Monitoring and alerting with Prometheus & Grafana
- Infrastructure hardening and auditing

---

## 🛠️ Tech Stack

- Bash & Shell Scripting
- Git + GitHub (SSH workflows)
- Docker (planned)
- GitLab CI/CD (planned)
- SQL Server validation in containers
- Linux (Ubuntu, Debian)

---

## 📌 How to Use

1. Clone the repo:
   ```bash
   git clone git@github.com:sandeshbnataraj/devops.git
   ```

2. Explore the structure:
   ```bash
   cd devops/Linux/notes
   ```

3. Run scripts:
   ```bash
   bash Linux/project(s)/auto_provision/setup.sh --dry-run
   ```

4. Use, improve, automate, repeat 💥

---

## 👋 About Me

I’m Sandesh, a developer transitioning into DevOps with a goal to master CI/CD, infrastructure as code, container orchestration, and secure automation. This repo documents my journey, learnings, and hands-on builds.

---

## 📬 Feedback & Collaboration

Have suggestions or ideas? Open an issue or connect if you want to collaborate on DevOps tooling or projects.

---

## 📖 License

This project is licensed under the [MIT License](LICENSE).

---

_“Build it. Automate it. Harden it. Learn it.”_
