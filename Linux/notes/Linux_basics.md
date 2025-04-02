# LINUX BASCIS

Linux is **case sensitive**.

---

### 🗃️ Linux File Types

Files that begin with a character indicate the type:

| Symbol | Type           | Description |
|--------|----------------|-------------|
| `-`    | Regular File   | Standard file (text, binary, etc.) |
| `d`    | Directory      | Folder containing files |
| `l`    | Link           | Shortcut to another file |
| `c`    | Character Device File| Represents hardware devices as files (e.g., keyboard, mouse, CPU, memory) |
| `b`    | Block Device File | Devices that handle data in blocks (e.g., hard drive, USB drive) |
| `s`    | Socket         | Used for network communication |
| `p`    | Named Pipe (FIFO) | Inter-process communication in FIFO order |
| `+`    | Access Control List (ACL) | Indicates a ACL permission has been set on the file/directory. |

#### 🔗 Links
- **Soft Link**: Like a shortcut. Breaks if the target is deleted.
- **Hard Link**: Another name for the same file. Doesn’t break if the original is deleted.

---

### 🫚 Root
- Root as `/` : very first direcotory also referred as root directory.
- Root home directory : `/root `

---

### 🔐 Linux File Permissions Table

The table below assigns numbers to permission types:

| Number | Permission Type        | Symbol |
|--------|------------------------|--------|
| 0      | No Permission          | ---    |
| 1      | Execute                | --x    |
| 2      | Write                  | -w-    |
| 3      | Execute + Write        | -wx    |
| 4      | Read                   | r--    |
| 5      | Read + Execute         | r-x    |
| 6      | Read + Write           | rw-    |
| 7      | Read + Write + Execute| rwx    |

---

### 📜 Common Linux Commands

---

#### 📁 File, Permissions & Redirection

| Command | Description |
|---------|-------------|
| `touch <filename>` | Create an empty file. |
| `mkdir <directory>` | Create a new directory. |
| `cp <source> <destination>` | Copy a file to another location. |
| `cp -R <source> <destination>` | Recursively copy a directory and its contents. |
| `vi <filename>` | Open or create a file using the `vi` editor. |
| `chmod` | Modify file permissions. |
| `chmod u+rw <filename>` | Add read and write permissions for the user (owner). |
| `chmod g-w <filename>` | Remove write permission from the group. |
| `chmod a-r <filename>` | Remove read permission from user, group, and others. |
| `chmod 777 <filename>` | Grant full read/write/execute permissions to all. |
| `drwxrwxrwx` | Permission string: first set for user, second for group, third for others. |
| `chown` | Change file ownership (user). |
| `chgrp` | Change file group ownership. |
| `chown <username> <file>` | Assign file to a specific user. |
| `chgrp <groupname> <file>` | Assign file to a specific group. |
| `setfacl` / `getfacl` | Set or view ACLs for users outside standard user/group permissions. |
| `getfacl <file>` | View ACLs on a file. |
| `setfacl -m u:<user>:rwx <file>` | Grant ACL permissions to a user. |
| `setfacl -m g:<group>:rwx <file>` | Grant ACL permissions to a group. |
| `setfacl -Rm "<entry>" <path>` | Recursively apply ACL entries. |
| `setfacl -x u:<user> <file>` | Remove ACL for a user. |
| `setfacl -b <file>` | Remove all ACLs from a file. |
| ⚠️ *Note:* | ACL write permission doesn't allow file deletion unless the user has write permission on the parent directory. |
| `>` / `>>` | Redirect (overwrite) or append output to a file. |
| `echo "text" > file` / `echo "text" >> file` | Write or append text to a file. |
| `cat <file>` | Display file contents. |
| `ls -l /root 2> file` | Redirect error output (stderr) to a file. |
| `ls -l \| tee file1 file2` | Show output and write to multiple files. |
| `echo "text" \| tee -a file` | Append piped output using `tee`. |
| `more`, `less`, `head`, `tail` | View file content. `head -2`, `tail -2` shows first/last 2 lines. |
| `vi <file> +<line>` | Open a file at a specific line number. |

---

#### 🔍 Text Processing, Searching & Sorting

| Command | Description |
|---------|-------------|
| `cut -c 1 <file>` | Get the first character of each line. |
| `cut -c 1,2,4 <file>` | Get specific characters from each line. |
| `cut -c 1-5 <file>` | Get a range of characters. |
| `cut -d: -f6 <file>` | Use ':' delimiter and get the 6th field. |
| `ls -l \| cut -c2-4` | Pipe output and cut specific character columns. |
| `awk '{print $1}' <file>` | Print the first column. Use `$NF` for last column. |
| `ls -l \| awk '{print $1, $3}'` | Print multiple columns from command output. |
| `awk '/text/ {print}' <file>` | Search for lines containing specific text. |
| `awk -F: '{print $1}' <file>` | Use ':' delimiter and print the first column. |
| `echo "Hello Tom" \| awk '{$2="Adam"; print $0}'` | Replace second word in a string. |
| `cat file \| awk '{$2="Adam"; print $0}'` | Replace second column in a file's content. |
| `awk '{if($9=="val") print $0;}'` | Conditional printing based on column value. |
| `awk '{print NF}'` | Print number of fields in each line. |
| `grep <word> <file>` | Search for keyword in file. |
| `grep -c <word> <file>` | Count occurrences of the word. |
| `grep -i <word> <file>` | Case-insensitive search. |
| `grep -n <word> <file>` | Show line numbers with matches. |
| `grep -v <word> <file>` | Show lines that **do not** contain the word. |
| `egrep -i "word1\|word2" <file>` | Search for multiple words. |
| `sort <file>` | Sort file content alphabetically. Use `-r` for reverse, `-k2` for sorting by 2nd field. |
| `uniq <file>` | Remove duplicates. Use `sort file \| uniq`. Add `-c` for counts, `-d` to show only duplicates. |
| `wc <file>` | Show line, word, and byte count. Use `-l`, `-w`, `-c` for specific counts. |
| `sed 's/Kenny/Lenny/g' <filename>` | Replace all occurrences of 'Kenny' with 'Lenny' in the file. <br>`s` = substitute, `g` = global (apply to every match). Displays the changes without modifying the original file. |
| `sed -i 's/Kenny/Lenny/g' <filename>` | Replace all occurrences of 'Kenny' with 'Lenny' directly in the file. <br>The `-i` option means in-place editing, making the changes permanent. |
| `sed '/seinf/d' <filename>` | Delete all lines containing the word 'seinf'. |
| `sed -i '/^$/d' <filename>` | Remove all empty lines from the file. <br>`^$` matches lines that start and end with nothing (i.e., empty). |
| `sed -i '1d' <filename>` | Delete the first line of the file. <br>Use `1,2d` to delete the first two lines. |
| `sed -n '12,18p' <filename>` | Display only lines 12 to 18 from the file. <br>`-n` suppresses automatic printing, `p` prints only the selected lines. |
| `sed '12,18d' <filename>` | Show all lines **except** lines 12 to 18. |
| `alias ls="ls -al"` | Creates a shortcut (alias) for `ls` that automatically runs `ls -al`. |
| `alias pl="pwd; ls"` | Creates a custom alias that runs multiple commands in sequence (`pwd` and then `ls`). Separate commands with a semicolon. |
| `unalias <name>` | Removes a specific alias from the current shell session. |
| Add alias to `~/.bashrc` | To make an alias **permanent for a specific user**, add it to `/home/username/.bashrc`. |
| Add alias to `/etc/bashrc` | To make an alias **available system-wide**, add it to `/etc/bashrc`. |
| `history` | Displays a list of all previously executed commands in the current shell session. You can re-run a command by using `!<number>` (e.g., `!105` runs command #105). |
| `if [ condition ]; then ... else ... fi` | Standard `if-else` condition in shell scripting. Executes the `then` block if the condition is true, otherwise runs the `else` block. |
| `for i in 1 2 3; do ... done` | Loop structure to iterate over a list of items. Runs the code inside the loop for each value of `i`. |
| `while [ condition ]; do ... done` | Runs the loop **as long as** the condition is true. Great for repeated checks or input loops. |
| `read <var_name>` | Reads input from the user and stores it in the specified variable. |
| `case $var in a) ... ;; b) ... ;; *) ... ;; esac` | Used to match a variable against multiple patterns. Acts like a switch-case in other languages. `*` is the default case. |

---

#### 🔎 File Search, Archiving, System Admin & Wildcards

| Command | Description |
|---------|-------------|
| `find . -name "<file>"` | Search for file starting from current directory. |
| `locate <file>` | Locate file using the system database. Run `updatedb` if needed. |
| `*` / `?` / `[cd]` | Wildcards: `*` = any, `?` = single char, `[cd]` = matches c or d. |
| `ls -l *[cd]*` | List files with `c` and `d` in their names. |
| `diff <f1> <f2>` | Show differences between two files. |
| `cmp <f1> <f2>` | Compare files byte-by-byte with mismatch position. |
| `tar cvf archive.tar <file\|dir>` | Create tar archive. `.` to include current dir. |
| `tar xvf archive.tar` | Extract tar archive. |
| `gzip <file>` | Compress file with `.gz` extension. |
| `gzip -d <file>.gz` / `gunzip <file>.gz` | Decompress `.gz` file. |
| `truncate -s 10 <file>` | Resize file to 10 bytes. Increases size if file is smaller. |
| `cat file1 file2 > file3` | Combine multiple files into one. |
| `split -l 300 <file> prefix` | Split file into chunks of 300 lines. Output uses prefix (e.g., prefixaa, prefixab...). |
| `cmd1; cmd2; cmd3` | Run multiple commands sequentially using semicolons. |
| `df -h` | Displays disk partition usage in a human-readable format (e.g., GB/MB). |
| `dmesg` | Shows system messages, including hardware-related warnings, errors, and logs — great for troubleshooting. |
| `iostat` | Displays input/output statistics for CPU and devices — useful for monitoring disk I/O performance. |
| `ip route` | Shows routing table information. For cleaner output, you can pipe it through `\| column -t`. |
| `ss` | Displays active socket connections on the system (like a modern replacement for `netstat`). |
| `shutdown` | Brings down the system safely. Use `man shutdown` to explore timing and user warning options. |
| `reboot` | Reboots the system immediately. |
| `halt` | Halts the system — similar to physically holding the power button to shut down the machine. |
| `hostname` | Displays the current hostname of your system. |
| `hostnamectl set-hostname <name>` | Changes the system's hostname. The new name is saved in `/etc/hostname`. |
| `uname -a` | Displays detailed information about the operating system and kernel. You can also use `cat /etc/redhat-release` to view OS release details. |
| `dmidecode` | Provides detailed hardware information about the system, including BIOS, CPU, memory, and more. |
| `arch` | Displays the system's architecture (e.g., x86_64, arm64). |
| `clear` | Clears the terminal screen. |
| `exit` | Exits the current shell, terminal session, or user session. |
| `script <filename>` | Records all terminal activity into a log file. If no filename is provided, it defaults to `typescript`. |
| `sosreport` | Collects diagnostic and configuration information from a CentOS Linux system, including details about installed applications. |
| `printenv` or `env` | Lists all environment variables available in the current session. |
| `echo $<variable>` | Displays the value of a specific environment variable. |
| `export <variable>` | Sets an environment variable for the current session. <br> To make it **permanent for a specific user**, add `export VARIABLE='value'` to `~/.bashrc`. <br> To set it **globally**, modify `/etc/profile` or `/etc/bashrc`. |
| `dnf install epel-release` | Enables the EPEL repository required to install extra packages on CentOS. |
| `dnf install screen` | Installs the `screen` terminal multiplexer. |
| `screen` | Starts a new screen session, allowing multiple shell sessions inside one terminal. |
| `Ctrl+a` then `Shift+\|` | Splits the screen **vertically** in a screen session. |
| `Ctrl+a` then `Shift+S` | Splits the screen **horizontally** in a screen session. |
| `Ctrl+a` then `Tab` | Switches focus between split windows. |
| `Ctrl+a` then `c` | Creates a new shell session within screen. |
| `screen -r` | Lists detached screen sessions and reattaches them. You can also reattach with `screen -r <session_id>`. |
| `dnf install tmux -y` | Installs `tmux`, an alternative terminal multiplexer to screen. |
| `tmux` | Starts a new `tmux` session. |
| `Ctrl+b` then `Shift+%` | Splits the `tmux` window **vertically**. |
| `Ctrl+b` then `Shift+"` | Splits the `tmux` window **horizontally**. |
| `Ctrl+b` then arrow keys | Moves between split panes. |
| `Ctrl+b` then `d` | Detaches the current session (it keeps running in the background). |
| `tmux ls` | Lists all active tmux sessions. |
| `tmux a` or `tmux attach-session -t <name>` | Reattaches to the last or a named tmux session. |
| `tmux new -s <name>` | Creates a new tmux session with a custom name. |
| `tmux kill-session -t <name>` | Kills the specified tmux session. |
| `Ctrl+d` | Closes the current tmux pane/window. |
| `init 0–6` | Changes the system runlevel:<br>• `0` – Halt (shutdown)<br>• `1` – Single-user mode<br>• `2` – Multi-user mode (no GUI, no NFS)<br>• `3` – Full multi-user mode (no GUI)<br>• `4` – Undefined (user-definable)<br>• `5` – Multi-user mode with GUI<br>• `6` – Reboot system<br><br>Run `man init` for more juicy details. |
| `who -r` | Shows the current system runlevel—because knowing your level is half the battle. |
| **Power → CPU → BIOS (POST: Power-On Self Test) → CMOS → MBR → Applications → CPU** | This is the **basic bootstrapping flow**—aka how your machine wakes up and says, “Let’s get to work.” |
| **BIOS → MBR → GRUB → Kernel → Systemd → Runlevel** | The **Linux Boot Process**, marching in perfect formation from firmware to user space. |
| `df -h` | Displays disk storage in **human-readable** format. No more deciphering raw byte counts—your brain deserves a break. |
| `fdisk -l` | Lists **detailed partition info** of all disks. Great for snooping into your storage setup like a pro. |


---

#### 🌐 Links, Metadata, Process Management & Networking

| Command | Description |
|---------|-------------|
| `inode` | Show inode number (metadata pointer) of a file. |
| `ls -li` | List files with their inode numbers. |
| `ln <src> <dest>` | Create a hard link (same inode). |
| `ln -s <src> <dest>` | Create a soft (symbolic) link (points to path). |
| `ip a` | Show IP address and network interfaces. |
| `ps` | Display processes running in the current shell/session. |
| `ps -e` | Show all running processes. Use `ps aux` for BSD-style output, and `ps -ef` for full-format listing (commonly used). |
| `ps -u <username>` | Show all processes owned by the specified user. |
| `top` | Display real-time system processes and resource usage. |
| `top -u <username>` | Show only processes owned by a specific user. <br>Within `top`: press `Shift + C` to view full command paths, `Shift + K` to kill a process by PID, `Shift + M` to sort by memory, and `Shift + P` to sort by CPU usage. |
| `kill -l` | List all available signal names and their corresponding numbers. |
| `kill -1 <pid>` | Restart a process (SIGHUP). <br>`-2` sends an interrupt signal (like `Ctrl+C`), `-15` requests a graceful termination (default), and `-9` forcefully kills the process immediately. |
| `crontab -e` | Edit the current user's crontab file. |
| `crontab -l` | List the current user's crontab entries. |
| `crontab -r` | Remove the current user's crontab. |
| `crond` | The cron daemon/service that manages scheduled jobs. |
| `systemctl status crond` | Check the status of the `crond` service. |
| `at` | just like crontab but schedlue the job only once. |
| `at HH:MM [AM\|PM]` | Schedule a one-time job to run at the specified time. You'll be prompted to enter the command(s) to run. Press `Ctrl+D` to save and exit. |
| `atq` | List the currently scheduled `at` jobs for the user. |
| `atrm <job_number>` | Remove a specific `at` job using its job number (from `atq`). |
| `atd` | The background daemon that executes scheduled `at` jobs. |
| `systemctl status atd` | Check the status of the `atd` service (should be running to execute scheduled jobs). |
| `bg` | moves a job and runs it in the background. |
| `jobs` | Lists all jobs started in the current shell that are running or in the background. |
| `fg` | Brings the most recent background job (or a specified one) to the foreground. |
| `nohup sleep 75 &` | Starts a process in the background and ensures it keeps running even if the terminal is closed. |
| `nohup sleep 100 > /dev/null 2>&1 &` | Runs a process in the background and silences all output and errors by redirecting them to `/dev/null`. |
| `nice -n 5 sleep 10` | Starts a process with a "nice" value of 5. Nice values range from `-20 (high priority)` to `19 (low priority)`. |
| `pkill` | Terminates a process by name. |
| `wget http://website.com/filename` | Downloads a file from the internet using `wget`. |
| `curl http://website.com/filename` <br> `curl -O http://website.com/filename` | Uses `curl` to fetch content from a URL. The `-O` flag saves the file with its original name. |
| `rpm -qa \| grep ftp` | Lists all installed packages and filters for any related to FTP (e.g., to check if `vsftpd` is installed). |
| `yum install vsftpd` | Installs the `vsftpd` FTP server package using `yum`. |
| `scp <filename> <username>@<ip>:<dest_location>` | Securely copies a file from your local server to a remote server using SSH (`sshd` runs on port 22). |
| `rsync` | Transfers files from one server to another based on differences in file size and modification time. Uses SSH protocol (`sshd` on port 22). Efficient for syncing large files — only the changed parts are transferred. |
| `rsync <options> <source> <destination>` | General syntax for running `rsync` commands. |
| `yum install rsync` (CentOS) <br> `apt-get install rsync` (Ubuntu/Debian) | Installs the `rsync` package on the respective Linux distributions. |
| `rsync -avz <file>.tar <username>@<ip>:<destination>` | Sends a file from the local machine to a remote machine using `rsync` over SSH. |
| `rsync -azvh <source> <destination>` | Transfers a **directory** within the same machine. For files, use `-zvh` instead. |
| `rsync -avzh <user>@<ip>:<remote_path> <local_path>` | Pulls files or directories from a **remote machine to the current machine**. |
| `yum` / `dnf` | `dnf` is the modern package manager for CentOS (replaces `yum`, which is now deprecated). Equivalent to `apt-get` on Debian/Ubuntu systems. |
| `rpm` | Used to install a package from a downloaded file. <br>`rpm -qa` lists all installed packages. <br>`rpm -e <package>` removes a package. |
| `rpm -ivh <package_name>` | Installs an `.rpm` package with verbose and hash progress (`-i` = install, `-v` = verbose, `-h` = progress bar). |
| `rpm -qi <package_name>` | Displays detailed information about an installed package. |
| `rpm -qc <package_name>` | Lists configuration files provided by the package. |
| `rpm -qf /usr/bin/<command>` | Identifies which installed package a particular command belongs to. Use `which <command>` first to find the command's full path. |
| `dnf remove <package>` | Removes a package using `dnf`. |
| `dnf update <package>` / `yum update <package>` | Updates a package to its latest version while preserving previously installed versions. Add `-y` to skip confirmation prompts. |
| `dnf upgrade <package>` / `yum upgrade <package>` | Upgrades installed packages and removes obsolete ones. |
| `yum history undo <id>` | Reverts all changes made by a specific ID. Useful for rolling back package updates. |
| `PTR Record` | Resolves an IP address to a hostname (reverse DNS). |
| `A Record` | Maps a hostname to an IPv4 address. |
| `CNAME Record` | Maps one hostname to another (canonical name). |
| `named` | Daemon that runs the DNS server (part of BIND). |
| `nslookup <website>` / `dig <website>` | Queries DNS records for a domain. `dig` provides more detailed output. |
| `traceroute <website>` | to trace teh package and troubleshoot. |
| `ipconfig snp0s3` | Ip for all interfaces running.|
| `podman` | Used for managing containers, pods, and images. Supports operations like running, stopping, starting containers, checking status (`ps`), attaching to containers, etc. |
| `buildah` | Focused on building, pushing, and signing container images. Complements `podman` by handling image creation tasks. |
| `skopeo` | Used for copying, inspecting, deleting, and signing images — especially useful when interacting with remote container registries. |
| `runc` | Low-level container runtime used by `podman` and `buildah` to run and build containers. |
| `crun` | An alternative OCI-compatible runtime with enhanced flexibility, performance, and security — particularly suited for running **rootless containers** (containers that do not require root privileges). |
| `podman -v` | Displays the version of Podman installed. The output may vary depending on the operating system version. |
| `podman --help` | Lists all available commands and options for Podman. Useful for quick reference. |
| `man podman` | Opens the manual page for Podman, just like with other Linux commands. Great for detailed usage info. |
| `podman info` | Displays Podman's environment configuration, including storage drivers, registries, and default settings. <br>When pulling an image, Podman checks the local machine first, then attempts registries in the listed order. |
| `podman search <image>` | Searches for container images in the default or specified registry. |
| `podman images` | Lists all container images available on the local system. |
| `podman pull <image>` | Downloads the specified image from a container registry. |
| `podman ps` | Displays all currently running containers. |
| `podman run -dt -p 8080:80/tcp <image_registry>` | Runs a container in detached mode (`-d`) with a pseudo-TTY (`-t`), and maps port `8080` on the host to port `80` inside the container. |
| `podman logs -l` | Shows logs for the most recently created container. |
| `podman stop <container_id or name>` | Stops a running container. |
| `podman create --name <name> <image_registry>` | Creates a container from an image without starting it. Assigns it a custom name. |
| `podman generate systemd --new --files --name <container_name>` | Generates a systemd unit file to manage the container as a service. |
| `cp /root/container-httpd.service /etc/systemd/system` | Copies the generated systemd unit file to the appropriate directory. |
| `systemctl enable container-httpd.service` | Enables the container service so it starts automatically on boot. |
| `ssh-keygen -t rsa -b 4096 -C "your_email@example.com" ` | 
ssh-add -l	List keys loaded into agent
ssh-add -L	Show full public keys
ssh-add ~/.ssh/keyname	Add key to agent
ssh-add -D	Remove all keys
eval "$(ssh-agent -s)"	Start a new agent in your shell

---

### 📅 Crontab Schedule Syntax

```cron
# ┌───────────── minute (0 - 59)
# │ ┌───────────── hour (0 - 23)
# │ │ ┌───────────── day of the month (1 - 31)
# │ │ │ ┌───────────── month (1 - 12)
# │ │ │ │ ┌───────────── day of the week (0 - 6) (Sunday to Saturday)
# │ │ │ │ │                                 (7 is also Sunday on some systems)
# │ │ │ │ │
# * * * * * <command to execute>


---