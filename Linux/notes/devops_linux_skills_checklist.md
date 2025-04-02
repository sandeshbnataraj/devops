# ✅ DevOps-Ready Linux Skills Checklist

## 🔹 1. Terminal Navigation & File Operations
- [ ] `cd`, `ls`, `pwd`, `mkdir`, `touch`, `rm`, `cp`, `mv`
- [ ] Use `find`, `locate`, `which`, `basename`, `dirname`
- [ ] Redirection: `>`, `>>`, `<`, `|`, `tee`

## 🔹 2. File Permissions & Ownership
- [ ] Understand and use `chmod`, `chown`, `chgrp`
- [ ] Set `umask`, use symbolic vs numeric modes (`chmod 755`, `chmod u+x`)
- [ ] Know SUID, SGID, sticky bit

## 🔹 3. Text Processing & Filters
- [ ] Master `grep`, `awk`, `sed`, `cut`, `tr`, `sort`, `uniq`
- [ ] Use `head`, `tail`, `less`, `more`, `wc`
- [ ] Combine them in pipes to filter and analyze output

## 🔹 4. Users & Groups
- [ ] Add/remove users (`useradd`, `usermod`, `passwd`, `deluser`)
- [ ] Manage groups (`groupadd`, `gpasswd`, `id`, `groups`)
- [ ] Switch users (`su`, `sudo`)

## 🔹 5. Process & Job Management
- [ ] List processes: `ps`, `top`, `htop`
- [ ] Kill/reprioritize: `kill`, `killall`, `nice`, `renice`
- [ ] Background jobs: `&`, `jobs`, `fg`, `bg`

## 🔹 6. Package Management
- [ ] Debian-based: `apt`, `dpkg`
- [ ] RHEL-based: `yum`, `dnf`, `rpm`
- [ ] Understand package installs, removals, and updates

## 🔹 7. Networking Basics
- [ ] IP info: `ip a`, `hostname`, `nmcli`, `ifconfig` (legacy)
- [ ] Routing: `ip r`, `route`
- [ ] Test connectivity: `ping`, `curl`, `wget`, `nc`, `telnet`, `traceroute`
- [ ] Open ports: `ss -tuln`, `netstat` (legacy)

## 🔹 8. Disk & Filesystem Management
- [ ] View disk space: `df -h`, `du -sh`
- [ ] Partition tools: `fdisk`, `lsblk`, `mount`, `umount`
- [ ] Modify `/etc/fstab` (with care!)

## 🔹 9. Systemd & Services
- [ ] Check service status: `systemctl status nginx`
- [ ] Start/stop/restart services: `systemctl start/stop/restart`
- [ ] Enable services at boot: `systemctl enable`
- [ ] View boot logs: `journalctl -xe`, `dmesg`

## 🔹 10. Cron Jobs & Scheduling
- [ ] Edit user crontab: `crontab -e`
- [ ] List and remove jobs: `crontab -l`, `crontab -r`
- [ ] Understand cron time format (`*/15 * * * *`)

## 🔹 11. Bash Scripting (Automation MVP)
- [ ] Write scripts with `#!/bin/bash`, variables, conditionals, loops
- [ ] Pass arguments with `$1`, `$@`, `$#`
- [ ] Use `exit`, `trap`, and error handling
- [ ] Automate daily tasks (backups, log cleanup, etc.)

## 🔹 12. Logs & Debugging
- [ ] Know where to look: `/var/log/syslog`, `/var/log/messages`, `/var/log/nginx/`, etc.
- [ ] Use `tail -f`, `grep`, and `journalctl` to investigate issues

## 🎯 Score Yourself
- **0–20%**: Linux Tourist 🚶‍♂️ – Welcome, but buckle up!
- **21–50%**: Linux Apprentice 🛠 – You’re building a strong foundation.
- **51–80%**: Linux Sidekick 🤖 – You can hold your own.
- **81–100%**: DevOps Ready 🧠 – Release the Kraken. You’re in.
