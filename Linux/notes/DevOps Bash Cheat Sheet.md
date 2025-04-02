# 🐧 DevOps Bash Cheat Sheet

---

## ✅ Default SSH Users for AMIs

| AMI Type              | Default SSH User     |
|----------------------|-----------------------|
| Ubuntu               | `ubuntu`              |
| Amazon Linux / 2     | `ec2-user`            |
| CentOS               | `centos`              |
| Debian               | `admin` or `debian`   |
| Fedora               | `fedora`              |
| RHEL (Red Hat)       | `ec2-user` or `root`  |
| SUSE Linux           | `ec2-user`            |

---

## 📦 APT & DPKG Basics

### List installed packages:
```bash
apt list --installed | wc -l  # Typically 500–700 on fresh box
```

### Check aliases:
```bash
cat ~/.bashrc | grep alias
```

### DPKG Command Summary
| Command | Description |
|---------|-------------|
| `dpkg -i <file>.deb` | Install a local .deb package |
| `dpkg -r <package>` | Remove a package (keep config) |
| `dpkg -P <package>` | Purge package (remove config too) |
| `dpkg -l` | List installed packages |
| `dpkg -s <package>` | Show detailed package info |
| `dpkg -L <package>` | List files from a package |
| `dpkg -S <filename>` | Find which package owns a file |

---

## 🔐 APT Source & Repositories

### See sources list:
```bash
cat /etc/apt/sources.list
ls /etc/apt/sources.list.d/
```

### Check package availability:
```bash
apt search podman
apt-cache policy podman
apt show podman
```

### If package not found:
- Check spelling
- Add missing repo or use Snap/official installer

### Fix broken installs:
```bash
sudo apt -f install
```

---

## 🧼 Clean Package Management

| Task | Command |
|------|---------|
| Remove package | `sudo apt remove <package>` |
| Purge config | `sudo apt purge <package>` |
| Remove dependencies | `sudo apt autoremove` |

---

## 🔁 SCP File Transfers (EC2)

### FROM EC2 → Local:
```bash
scp -i ~/Downloads/your-key.pem ubuntu@<EC2-IP>:~/provisioner/setup.sh .
```

### Local → EC2:
```bash
scp -i ~/Downloads/your-key.pem setup.sh ubuntu@<EC2-IP>:~/provisioner/
```

---

## 🧰 Bash Scripting Toolkit

### Argument Symbols
| Symbol | Description |
|--------|-------------|
| `$1`, `$2` | First, second argument |
| `$@` | All arguments (space-preserved) |
| `$*` | All arguments (single string) |
| `$#` | Count of arguments |

### Argument Tricks
```bash
shift 2  # Shifts arguments left by 2 positions
```

### Variable Tests & Defaults
```bash
[[ -z "$2" ]]  # Check if empty
: "${2:?message}"  # Auto-exit if unset/empty
: "${var:-default}"  # Use default if unset, don't assign
: "${var:=default}"  # Use and assign default if unset
```

### Function Scoping
```bash
create_log() {
  local filename="$1"
  echo "Creating log at $filename"
  # touch "$filename"
}
```

### Script Execution: source vs direct
| Command | Effect |
|---------|--------|
| `source setup.sh` or `. setup.sh` | Run in current shell (keep variables/functions) |
| `./setup.sh` | Subshell (variables/functions die at end) |

### Variable Behavior
| Declaration | Purpose |
|-------------|---------|
| `local` | Function-scoped |
| `export` | Share with subprocesses |
| `readonly` | Immutable value |
| `declare -i` | Integer only |
| `declare -a` | Array |
| `declare -A` | Associative array (Bash 4+) |

### Script Control
| Command | Scope |
|---------|--------|
| `return` | Exit from a function |
| `exit` | Exit whole script |

---

## 🧪 command -v
```bash
command -v python  # Checks command existence and path
```

---

## 🧠 Bash Logic Checks

### POSIX vs Bash
| Syntax | Purpose |
|--------|---------|
| `[[ -z "$2" ]]` | Bash empty check |
| `[ -z "$2" ]` | POSIX-compatible |
| `! $2` | ❌ DON'T (tries to execute $2) |

---

## 🚀 Best Practices
| Scenario | Tip |
|----------|-----|
| Inside a function | Use `local` |
| Sharing across scripts | Use `export` |
| Prevent mutation | Use `readonly` |
| Clean CLI parsing | Use `$@`, `shift` |
| Avoid global sprawl | Scope your stuff 🐍 |

---

## 📡 curl — DevOps Swiss Army Knife

| Flag | Description |
|------|-------------|
| `-f` | Fail silently on HTTP errors (don’t dump error HTML) |
| `-s` | Silent mode — no progress bar or output |
| `-S` | Show error **only if** `-s` is used — clean & quiet logging |
| `-L` | Follow redirects (HTTP 3xx) automatically |
| `-O` | Save file using its original name |
| `-o <filename>` | Save to a custom filename |
| `-X` | Specify HTTP method (GET, POST, PUT...) |
| `-H` | Add headers (like Auth) |
| `-d` | Send data (JSON, form fields, etc.) |
| `-I` | Fetch only headers |
| `--user` | Basic Auth (`username:password`) |
| `--retry` | Retry on network failures |

### Common Use Cases
- **Health check**: `curl http://localhost:8000/health`
- **Webhook/API**: `curl -X POST -H "Authorization: Bearer ..." -d '{"key":"value"}' URL`
- **Download**: `curl -LO https://example.com/tool.sh`
- **Docker**: Used in `HEALTHCHECK`
- **CI/CD**: Slack/GitHub notifications

### Best Practice Flag Combo
```bash
curl -fsSL <url>
```
- Clean ✅
- Quiet 🤫
- Reliable 🔁

---

## 🧾 System Info
```bash
lsb_release -a        # Show Ubuntu version
cat /etc/os-release   # Also shows version info
```

### GPG Key Conversion
```bash
gpg --dearmor <key>.asc > <key>.gpg
# APT needs binary format for authentication
```

---

# 🚀 Essential Command-Line Checks Cheat Sheet

| **Check**                              | **Command**                                                                 | **What It Does**                                                        |
|----------------------------------------|-----------------------------------------------------------------------------|-------------------------------------------------------------------------|
| ✅ Check if a command exists           | `command -v <cmd>`                                                          | Returns path if it exists, empty if not                                 |
| 🔎 Check command location              | `which <cmd>`                                                               | Returns the path of the command                                         |
| 📦 Check if a package is installed     | `dpkg -l | grep <package>` *(Debian/Ubuntu)*                                | Lists package info if installed                                         |
| 📦 Yum-based check                     | `rpm -qa | grep <package>` *(RHEL/CentOS/Fedora)*                            | Shows installed package from RPM                                        |
| 🛠 Check if a service is running       | `systemctl is-active <service>`                                             | Outputs `active`, `inactive`, or `failed`                               |
| 🧠 Check OS info                       | `cat /etc/os-release`                                                       | Shows OS name, version, ID                                              |
| 💻 Check CPU info                     | `lscpu`                                                                     | Shows CPU architecture and core info                                    |
| 🧮 Check memory                        | `free -h`                                                                   | Displays RAM usage in human-readable format                             |
| 💾 Check disk space                    | `df -h`                                                                     | Shows mounted disk usage in human-readable format                       |
| 📶 Check IP address                    | `ip a` or `hostname -I`                                                     | Displays network interface IP addresses                                 |
| 🧪 Test network connectivity           | `ping -c 4 <host>`                                                          | Sends 4 ICMP requests to check if a host is reachable                   |
| 🌐 Test DNS resolution                 | `nslookup <domain>` or `dig <domain>`                                       | Checks if a domain resolves                                             |
| 🔐 Check user existence                | `id <username>`                                                             | Returns UID/GID info if the user exists                                 |
| 🗂 Check directory exists              | `[[ -d /path/to/dir ]] && echo "Exists"`                                   | Checks if a directory exists                                            |
| 📄 Check file exists                   | `[[ -f /path/to/file ]] && echo "Exists"`                                  | Checks if a file exists                                                 |
| 🕳 Is port open?                       | `ss -tuln | grep :<port>` or `netstat -tuln | grep :<port>`                  | Shows if a port is being used 
---

Now go forth and script like a ninja 🥷💻


You're a legend for building this mega cheat sheet — here's that entire block, kept exactly as you asked and 100% Markdown-friendly for copy-paste:

---

### 🔤 Convert to Lowercase (and `select` Usage)

```bash
choice="${opt,,}"
```

Let’s say you have:

```bash
options=("Coffee" "Tea" "Juice" "Water" "Quit")
```

When you do:

```bash
select opt in "${options[@]}"
```

The terminal will show:

```
1) Coffee  
2) Tea  
3) Juice  
4) Water  
5) Quit  
#?
```

You type `2` and hit Enter → `opt` will be assigned the string `"Tea"`.

---

### 🧠 Bash Array Slicing Example

```bash
for tool in "${options[@]:0:6}"; do
  echo "$tool"
done
```

Let’s unpack it:
- `options[@]`: Refers to the full array.
- `:0:6`: Slice the array starting at index 0 and take 6 elements.
- Result: First 6 items of the array.

---

### 🧐 What Does `REPLY` Do in `select`?

When you use a `select` loop and the user inputs something, Bash stores the **raw input** (like the number or string typed) in a special variable:

```bash
$REPLY
```

Even if the user picks an invalid option, `REPLY` captures it. Very handy for validation.

---

### 🔚 Function Return vs Script Exit

| Command    | Effect                      |
|------------|-----------------------------|
| `return 0` | Ends function successfully  |
| `return 1` | Ends function with error    |
| `exit 0`   | Exits the whole script ✅     |
| `exit 1`   | Exits script with error 🔥     |

- Use `return` inside functions.
- Use `exit` in the main script logic.

---

### 📦 Package Installed Check

```bash
if dpkg -l | awk '$1 == "ii" && $2 == "'"$1"'"' | grep -q .; then
  log_stmt "Package '$1' already installed"
  return 0
fi
```

| Part         | What it Does                               |
|--------------|--------------------------------------------|
| `grep -q`    | Quiet mode (no output, just success/fail)  |
| `grep -q .`  | Checks if there's any line of output       |

---

### 🔠 String Handling Essentials

| Situation              | Example                            |
|------------------------|------------------------------------|
| Run command            | `$(command)`                       |
| Expand variable safely | `"$var"` or `"${var}"`             |
| Build strings          | `"Hello ${user}DevOps"`            |
| Literal strings        | `'This is literal $HOME'`          |
| Best practice          | Always quote your variables ✅      |

---

### 👥 Group Management & Membership

- To list all groups:
  ```bash
  getent group
  ```

- Local-only fallback:
  ```bash
  cat /etc/group
  ```

- See your user’s groups:
  ```bash
  groups
  ```

- See groups for another user:
  ```bash
  groups username
  ```

- Lookup a specific group:
  ```bash
  getent group groupname
  ```

- See who's in `audio` group:
  ```bash
  getent group audio
  ```

- Local lookup:
  ```bash
  grep '^audio:' /etc/group
  ```

---

### 🚫 Group Deletion and Cleanup

- Delete a group:
  ```bash
  sudo groupdel olddevs
  ```

⚠️ This does **not**:
- Remove users in the group
- Remove files owned by the group
- Work if the group is someone's primary group or used by a process

Check if it’s a primary group:
```bash
getent passwd | grep ':groupname$'
```

Change primary group:
```bash
sudo usermod -g newgroup username
```

Remove user from group:
```bash
sudo gpasswd -d username groupname
```

---

### 🕵️‍♂️ Primary Group Lookup

- Method 1:
  ```bash
  id sandesh
  ```

- Method 2:
  ```bash
  getent passwd sandesh
  ```

- Confirm group ID:
  ```bash
  getent group 100
  ```

Change a user’s primary group:
```bash
sudo usermod -g developers sandesh
```

Find all users with GID 1002:
```bash
getent passwd | awk -F: '$4 == 1002 { print $1 }'
```

---

### 👤 User & Group Management

| Action | Command |
|--------|---------|
| Delete user | `sudo userdel username` |
| Delete user + home | `sudo userdel -r username` |
| Remove from group | `sudo gpasswd -d username groupname` |

Check if user is logged in:
```bash
who | grep username
```

Force logout:
```bash
sudo pkill -u username
```

---

### 🛡️ Podman Access with Groups

```bash
sudo groupadd podman
sudo chgrp podman /usr/bin/podman
sudo chmod 750 /usr/bin/podman
sudo usermod -aG podman sandesh
```

Clean Docker-style control with group permissions.

---

You got it. Here comes the **next batch** in Markdown format — covering the **UFW Firewall + Port Control** section in full detail:

---

### 🔥 Step-by-Step: Firewall + SSH + Port Control (UFW)

---

#### ✅ Step 1: Install and Enable UFW
**Goal**: Make sure `ufw` is installed and running.

```bash
sudo apt install ufw
sudo ufw --force enable
```

> 🧠 Why: Even if EC2 security groups block ports, locking it down at the OS level adds a second layer. UFW is your server’s bodyguard.

---

#### ✅ Step 2: Allow Only Port 22 (SSH)
**Goal**: Explicitly allow SSH so you don’t get locked out.

```bash
sudo ufw allow OpenSSH
# OR
sudo ufw allow 22/tcp
```

> ✅ Log this step in your script with `log_stmt`

---

#### ✅ Step 3: Set Default Policies
**Goal**: Block all incoming by default, allow all outgoing.

```bash
sudo ufw default deny incoming
sudo ufw default allow outgoing
```

> 🔐 Principle: Whitelist what you need, block everything else.

---

#### ✅ Step 4: Create a Function to Open Specific Ports

**Example function**:

```bash
open_port() {
  local port="$1"
  local desc="${2:-No description}"
  [[ "$port" =~ ^[0-9]+$ ]] || {
    echo "Invalid port: $port" >&2
    return 1
  }
  sudo ufw allow "$port"
  log_stmt "Opened port $port for $desc"
}
```

> 🔧 You can use this for HTTP (80), HTTPS (443), internal DBs (5432), etc.

---

#### ✅ Step 5: Add CLI Flag to Open a Port

Example usage in your script:
```bash
./setup.sh --open-port 8080
./setup.sh --open-port 8080 "My Web App"
```

> 🧠 Why: Let users dynamically allow ports without editing your script manually.

---

#### ✅ Step 6: Add UFW Status Function

```bash
firewall_status() {
  sudo ufw status numbered
}
```

> 📋 Handy for confirming what's currently open. Log it too!

---

#### ✅ Optional: Block or Remove Rules

To block/remove a port:

```bash
sudo ufw delete allow 8080
```

> 💥 Pro-mode tip: Build a `block_port` function for dynamic cleanup.

---

### 🔚 What You'll End Up With

| Command | Description |
|---------|-------------|
| `./setup.sh --setup-firewall` | Enables UFW, allows SSH only |
| `./setup.sh --open-port 8080` | Opens port 8080 |
| `./setup.sh --firewall-status` | Shows current firewall status |
| `./setup.sh --block-port 5000` | (Optional) Blocks previously open port |

---
🔥 Coming in hot — here's the **next block** of your cheat sheet, covering `curl`, system info, command checks, and essential diagnostics in clean Markdown format:

---

## 📡 `curl` — The DevOps Swiss Army Knife

---

### 🧰 Useful `curl` Flags

| Flag | Description |
|------|-------------|
| `-f` | Fail silently on HTTP errors (no dump of HTML error) |
| `-s` | Silent mode — no progress bar or extra output |
| `-S` | Show error **only if** `-s` is used (great for logging) |
| `-L` | Follow redirects (HTTP 3xx) automatically |
| `-O` | Save file using the original filename |
| `-o <filename>` | Save to a custom filename |
| `-X` | Specify HTTP method (GET, POST, PUT...) |
| `-H` | Add headers (e.g. Authorization) |
| `-d` | Send data (JSON, forms, etc.) |
| `-I` | Fetch only headers |
| `--user` | Basic Auth in `username:password` format |
| `--retry` | Retry on network failures |

---

### 🛠 Common `curl` Use Cases

- **Health check**:
  ```bash
  curl http://localhost:8000/health
  ```

- **Webhook/API POST**:
  ```bash
  curl -X POST -H "Authorization: Bearer <token>" -d '{"key":"value"}' <url>
  ```

- **Download a tool/script**:
  ```bash
  curl -LO https://example.com/tool.sh
  ```

- **Dockerfile HEALTHCHECK**:
  ```dockerfile
  HEALTHCHECK CMD curl -f http://localhost/health || exit 1
  ```

- **Slack/GitHub notifications in CI/CD**:
  ```bash
  curl -X POST -H "Content-Type: application/json" -d '{"text":"Build passed"}' <webhook_url>
  ```

---

### ✅ Best Practice `curl` Combo

```bash
curl -fsSL <url>
```

- **f**: Fail on error  
- **s**: Silent mode  
- **S**: Show error if `-s` is used  
- **L**: Follow redirects

This combo is the ninja move for scripting and automation.

---

## 🧾 System Info & Diagnostics

---

### 🖥️ OS Info

```bash
lsb_release -a
cat /etc/os-release
```

> Shows distro, version, and pretty name.

---

### 🧠 CPU Info

```bash
lscpu
```

> Architecture, cores, threads, virtualization, model name.

---

### 💾 Memory Info

```bash
free -h
```

> Human-readable RAM and swap usage.

---

### 💿 Disk Space

```bash
df -h
```

> Mount points and available space in human-friendly format.

---

### 🌐 Network Info

```bash
ip a
hostname -I
```

> Shows all IP addresses on interfaces.

---

### 🧪 Check Connectivity

```bash
ping -c 4 google.com
```

> Sends 4 pings — confirms internet access.

---

### 🔍 DNS Lookup

```bash
nslookup example.com
# or
dig example.com
```

> Confirms DNS resolution works.

---

### 🔐 Check if User Exists

```bash
id username
```

> Returns UID/GID and groups if user exists.

---

### 🗂 Directory Exists?

```bash
[[ -d /path/to/dir ]] && echo "Directory exists"
```

---

### 📄 File Exists?

```bash
[[ -f /path/to/file ]] && echo "File exists"
```

---

### 🔌 Is a Port in Use?

```bash
ss -tuln | grep :<port>
# or
netstat -tuln | grep :<port>
```

> Shows if a port is actively listening.

---

When you're ready, I’ll send the final blocks — they include:
- `command -v` and `which` differences
- full command checks table
- everything wrapped up with "Go forth and script like a ninja 🥷💻"


Alright Sandesh, let’s wrap this masterpiece up with the **final block** of the cheat sheet — including full command-line sanity checks, `command -v`, group tricks, and a mic-drop DevOps outro 🥷💥

---

## 🧠 Essential Command-Line Checks Cheat Sheet

| ✅ Check | 🔧 Command | 💡 Description |
|---------|------------|----------------|
| Command exists | `command -v <cmd>` | Returns path if it exists, blank if not |
| Command location | `which <cmd>` | Shows the binary's location |
| Debian pkg check | `dpkg -l | grep <package>` | Confirms installed package |
| RPM-based pkg check | `rpm -qa | grep <package>` | Same thing, Red Hat style |
| Service running? | `systemctl is-active <service>` | Outputs `active`, `inactive`, or `failed` |
| OS details | `cat /etc/os-release` | Basic system info |
| CPU info | `lscpu` | Architecture, cores, etc. |
| Memory info | `free -h` | RAM and swap |
| Disk usage | `df -h` | Storage per mount point |
| IP Address | `ip a` or `hostname -I` | Lists all IPs |
| Ping test | `ping -c 4 <host>` | Simple reachability test |
| DNS check | `nslookup <domain>` or `dig <domain>` | Resolves domain names |
| User exists | `id <username>` | UID/GID if the user exists |
| Directory exists | `[[ -d /path ]]` | True if directory exists |
| File exists | `[[ -f /file ]]` | True if file exists |
| Port open? | `ss -tuln | grep :<port>` | Checks if a port is listening |

---

## 🧪 `command -v` vs `which`

```bash
command -v git
which git
```

| Tool | Behavior |
|------|----------|
| `command -v` | Built-in, POSIX-compliant, safe for scripts ✅ |
| `which` | External binary, less predictable ❌ |

> Use `command -v` when in doubt — it works in POSIX sh too.

---

## 🧠 Final Tips Before You Script Like a Ninja

### ✅ Group Dump (all groups)
```bash
getent group
```

### ✅ Find your user’s groups
```bash
groups
groups username
```

### ✅ Group details
```bash
getent group audio
grep '^audio:' /etc/group
```

### ✅ GID → Primary user list
```bash
getent passwd | awk -F: '$4 == 1002 { print $1 }'
```

### ✅ Delete groups/users (carefully!)
```bash
sudo groupdel devteam
sudo userdel -r olduser
```

### ✅ Remove user from group
```bash
sudo gpasswd -d username groupname
```

---

## 🥷 Bonus: Script Like a Ninja

You’ve got the power now. Combine these tools with clean scripting logic, logging, argument parsing, and dry-run support… and you’ll be DevOps-ing like a boss:

```bash
[[ -z "$1" ]] && { echo "Usage: $0 <something>"; exit 1; }
```

```bash
log_stmt() {
  echo "[$(date +'%F %T')] $*"
}
```

```bash
DRYRUN=true
$DRYRUN && echo "Would run: command"
```

---