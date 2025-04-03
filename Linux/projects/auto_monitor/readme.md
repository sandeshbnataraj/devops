Here's a `README.md` you can drop right into your project directory for `setup.sh`:  

---

```markdown
# EC2 System Health Monitor

This is a lightweight DevOps monitoring script for Ubuntu EC2 instances, created to provide system health details, alerts, summaries, and automated reporting using cron.

---

## 🛠 Features

- 📊 Full System Health Checks (Disk, Memory, CPU, Users, Services)
- 🚨 Alerting when thresholds are breached (Disk > 80%, Memory < 20%, CPU Overload)
- 📃 Summary Report
- 🔁 Cron-based Daemon Mode
- 🧹 Log Management with Timestamped Logging
- 🆘 Built-in Help Menu
- 🪵 Clean, consistent logging format with `[INFO]` and `[ERROR]` tags

---

## 🚀 Usage

```bash
./setup.sh [OPTIONS]
```

### Options

| Option             | Description                                                  |
|--------------------|--------------------------------------------------------------|
| `--check-health`   | Run a full system health check with details                  |
| `--summary`        | Print a concise summary of system metrics                    |
| `--alert`          | Show alerts if any resource thresholds are breached          |
| `--newlog`         | Clear the entire log directory                               |
| `--cron-run <min>` | Setup a cron job to run health summary and alert every N min |
| `--stop-cron`      | Stop/remove the current monitoring cron job                  |
| `-h, --help`       | Display usage instructions                                   |

---

## 🧾 Logs

Logs are created in:
```
/home/ubuntu/monitor_health/logs/
```

- `monitor-<timestamp>.log` – Info and summaries
- `errorlog-<timestamp>.log` – Errors and failures

---

## 📌 Example Commands

Run a full system health check:
```bash
./setup.sh --check-health
```

Set a cron job to run every 5 minutes:
```bash
./setup.sh --cron-run 5
```

Clear all logs:
```bash
./setup.sh --newlog
```

Stop the cron daemon:
```bash
./setup.sh --stop-cron
```

---

## 📦 Requirements

- `bash`
- `df`, `free`, `uptime`, `bc`, `who`, `systemctl`
- Cron (installed on most Ubuntu distros)

---

## 👨‍💻 Author

**Sandesh Nataraj**  
Created on: April 2, 2025  
For use on EC2 Ubuntu instances  
```

---