🧠 TL;DR:
Goal	Command	Notes
Current users (basic)	who	Great for scripts
Current users + activity	w	Best for full detail
Login history	last	Good for forensics/auditing


Command	What it shows
uptime	System load avg (1, 5, 15 min)
cat /proc/loadavg	Just the load numbers
top, mpstat	Real-time CPU usage (%)

df -hT | grep -E '^/dev'
🔍 What it does:
df → shows disk space usage

-h → human-readable (e.g., GB/MB)

-T → shows filesystem type

grep -E '^/dev' → filters to only mounted devices (like /, /home, etc.)


Ohh buddy — you're about to unlock the **Swiss Army knife of system management**: `systemctl`. This command basically **rules the world** on any system running `systemd` (which is most modern Linux distros).

Here’s a curated list of **must-know `systemctl` commands**, from casual checks to pro-level firepower. 🛠️⚙️

---

### 🔍 **Basic Status & Info**

| Purpose                    | Command                              | Description                                  |
|----------------------------|--------------------------------------|----------------------------------------------|
| Check if service is active | `systemctl is-active <service>`     | Just tells if it's `active`, `inactive`, etc.|
| Check if service is enabled| `systemctl is-enabled <service>`    | Will it auto-start on boot?                  |
| Full status report         | `systemctl status <service>`        | Logs + process info + status                 |
| List all units             | `systemctl list-units`              | Shows all running systemd "units"            |
| Show only services         | `systemctl list-units --type=service` | Filters to just services                    |

---

### 🚀 **Start / Stop / Restart Stuff**

| Action      | Command                             |
|-------------|-------------------------------------|
| Start       | `sudo systemctl start <service>`    |
| Stop        | `sudo systemctl stop <service>`     |
| Restart     | `sudo systemctl restart <service>`  |
| Reload      | `sudo systemctl reload <service>`   |
| Reload-or-restart | `sudo systemctl reload-or-restart <service>` |

---

### 🔄 **Enable / Disable at Boot**

| Action        | Command                              |
|---------------|--------------------------------------|
| Enable on boot| `sudo systemctl enable <service>`    |
| Disable on boot| `sudo systemctl disable <service>`  |
| Mask (fully block usage) | `sudo systemctl mask <service>` |
| Unmask       | `sudo systemctl unmask <service>`     |

---

### 📜 **Logs & Journal**

| Action          | Command                                    |
|-----------------|--------------------------------------------|
| View recent logs| `journalctl -u <service>`                  |
| Follow logs live| `journalctl -u <service> -f`               |
| Show since boot | `journalctl -b`                            |
| Show errors     | `journalctl -p err -b`                     |

---

### 💡 **System-wide Commands**

| Purpose                         | Command                  |
|----------------------------------|---------------------------|
| Reboot the system                | `sudo systemctl reboot`   |
| Power off                        | `sudo systemctl poweroff` |
| Reload all daemons              | `sudo systemctl daemon-reexec` |
| Show system boot targets         | `systemctl list-units --type=target` |
| Default boot target (like runlevel)| `systemctl get-default`   |

---

### 🧠 Pro Tip:
Use `tab` completion. `systemctl <tab><tab>` is your best friend when in doubt.

---

### 🔥 Want to check multiple services at once?

```bash
for svc in sshd cron nginx; do
    systemctl status "$svc" --no-pager | head -n 5
done
```
Perfect, Sandesh — here’s your **🔥 Bash Comparison Cheat Sheet** — 2025 edition — tuned for DevOps scripts, clean logic, and sanity-saving syntax.

---

## ⚔️ `[[ ... ]]` → String comparisons + logical conditions

Use this for:
- Checking strings
- File tests
- Combining conditions (`&&`, `||`)

```bash
if [[ "$name" == "sandesh" ]]; then
  echo "Hi, Sandesh!"
fi

if [[ -z "$input" || "$input" == "exit" ]]; then
  echo "Exit condition met"
fi
```

---

## 🔢 `(( ... ))` → Math and numeric comparisons

Use this for:
- Disk usage %
- Counts
- Loops
- Thresholds

```bash
x=75
if (( x > 70 )); then
  echo "Disk usage high"
fi

(( y = x + 5 ))
```

Supports all standard math: `+`, `-`, `*`, `/`, `%`, `++`, `--`, etc.

---

## 🧪 `[ ... ]` → The OG POSIX test command (old-school)

This is the legacy form. You **can** use it, but it’s **clunkier** and less safe:
```bash
if [ "$a" = "$b" ]; then
  echo "Equal"
fi
```

Avoid it in modern scripts unless you're writing for ultra-minimal shells (like Alpine BusyBox).

---

## ⚠️ Differences At-a-Glance

| Expression      | Meaning                           | Use When...                          |
|-----------------|------------------------------------|----------------------------------------|
| `[[ ... ]]`     | Advanced string test (safe)       | Checking file existence, strings, logic |
| `[ ... ]`       | Basic/legacy test (POSIX)         | Portability required                  |
| `(( ... ))`     | Arithmetic/math comparison         | You're working with numbers only      |

---

## 💡 Pro Tip for Scripting:
Use these together smartly:

```bash
if [[ "$1" == "--alert" ]]; then
  if (( disk_usage > 80 )); then
    log_stmt "🔥 Disk alert: $disk_usage% used"
  fi
fi
```

> Strings wrapped in `[[ ]]`, numbers inside `(( ))`. That’s Bash best practice.

---

Absolutely, Sandesh! Here's a detailed explanation of your validation logic, formatted in a clean **Markdown (`.md`) format** so you can save it in your notes or documentation.

---

## 📘 Bash Condition Breakdown: Validating Disk Usage Output

```bash
if [[ -z "$highest" || ! "$highest" =~ ^[0-9]+$ ]]; then
    log_error "Disk usage value invalid or missing: '$highest'"
fi
```

---

### 🧠 Purpose:

This condition ensures that the variable `highest` contains a **valid numeric value** (e.g., `45`, `83`, etc.) before using it in a math operation.

Without this check, your script could:
- Fail silently
- Throw weird comparison errors
- Log misleading alerts

---

### 🧩 Component Breakdown

| Expression                            | Meaning                                                                 |
|----------------------------------------|-------------------------------------------------------------------------|
| `[[ ... ]]`                            | Bash test command for advanced string and pattern evaluations           |
| `-z "$highest"`                        | Checks if `highest` is **empty** (i.e., not set or null)                |
| `||`                                   | Logical **OR** — if either condition is true, the whole test passes     |
| `! "$highest" =~ ^[0-9]+$`             | Uses regex to check if `highest` **does not contain only digits**       |
| `^[0-9]+$`                             | Regex: Match **one or more digits**, start to end (i.e., a whole number)|
| `log_error "Disk usage invalid..."`    | Logs the failure and exits the script                                   |

---

### ✅ What It Prevents

| Scenario                      | What Happens                       |
|-------------------------------|------------------------------------|
| `highest` is empty            | Error logged, script exits         |
| `highest` is `null` or `%`    | Error logged, script exits         |
| `highest` is `abc45` or `45%` | Regex fails, error logged          |
| `highest` is `45`             | ✅ Passes, script continues         |

---

### 💡 Real Example

```bash
highest="82"
[[ -z "$highest" || ! "$highest" =~ ^[0-9]+$ ]]   # FALSE → continues

highest="85%"
[[ -z "$highest" || ! "$highest" =~ ^[0-9]+$ ]]   # TRUE → log_error triggers

highest=""
[[ -z "$highest" || ! "$highest" =~ ^[0-9]+$ ]]   # TRUE → log_error triggers
```

---

### 🔐 Pro Tip

This kind of validation is **essential** in production scripts — especially when:
- Parsing CLI command outputs (`df`, `free`, `uptime`)
- Doing numeric operations (`-gt`, `(( ))`)
- Logging system health checks

---
 GNU grep (with -E for extended regex):
bash
Copy
Edit
grep -E '^[0-9]+Mi$'


Perfect — now you’re speaking fluent **Ops-speak** 🔥

You're not talking about system uptime anymore — you're talking about **load average** (aka **system usage**) that you get *from* `uptime`.

Let me show you what that means and how to alert on it like a pro.

---

## ⚙️ The Real Usage: Load Average

When you run:

```bash
uptime
```

You'll see something like this:

```bash
10:44:23 up 5 days,  2:10,  1 user,  load average: 0.42, 0.30, 0.15
```

That last part is your target:
```
load average: 0.42, 0.30, 0.15
```

These are the average system load (number of processes waiting to run) over:

- **1 minute**
- **5 minutes**
- **15 minutes**

---

## 🔍 What’s “High” Load?

The **load average is relative to the number of CPU cores**.

So:
- On a 1-core system: load of **1.00** means full usage
- On a 4-core system: **4.00** = full load

🧠 Rule of thumb:
- **> 1.0** on 1-core = system is overloaded
- **> #cores** = usage exceeds capacity

Use:
```bash
nproc
```
To get the number of CPU cores.

---

## ✅ What You Should Alert On

Let's say you're on a 2-core EC2 instance.

You might want to:
```bash
If 1-minute load avg > 2.5 → ALERT: High CPU usage
```

Why? Because it's higher than your total CPU capacity, which means things are backing up — sluggishness, possible crash, etc.

---

## 🧪 TL;DR - Your Alert Logic

1. Run `uptime`
2. Extract 1-minute load avg
3. Get `nproc` (CPU cores)
4. If load avg > threshold, log alert

---

## 🧠 Bonus

This type of alert is **better than just CPU %**, especially on servers, because it accounts for:
- Tasks waiting
- Scheduling delays
- Overall pressure on system

---

Ahhh, you’re asking the right questions again, Sandesh! Let’s break it down properly.

---

## 🔥 Can You Return Two Values Like This?

```bash
echo "$remload $load"
```

Yes — **you can echo multiple values** from a Bash function, and the caller can capture them.

But Bash doesn’t support true “returns” like other languages. It uses **standard output** (via `echo`) and positional parameters (`$1`, `$2`, etc.).

---

### ✅ Example: Returning Two Values

#### In the function:
```bash
cpu_usage() {
  local load=$(uptime | awk '{print $(NF-2)}' | tr -d ',')
  local core=$(nproc)
  local remload=$(echo "$core - $load" | bc -l)
  echo "$remload $load"
}
```

#### In the caller:
```bash
read reml loadavg <<< "$(cpu_usage)"
```

Now:
- `$reml` will have the **available headroom**
- `$loadavg` will have the **raw load**

You can use them like:
```bash
echo "Headroom: $reml"
echo "Load: $loadavg"
```

---

### 🧠 Important Notes:

- Use `echo` with a **single line** output like `echo "$val1 $val2"` (separated by space).
- Use `read` to **split** the values.
- Don’t use `return` — in Bash, it’s only for **exit status** (`0` to `255`).

---

### 💡 Bonus Tip: For more complex returns

You can also return structured data using arrays:
```bash
my_func() {
  echo "foo bar"
}
arr=($(my_func))
echo "${arr[0]}"  # foo
echo "${arr[1]}"  # bar
```

But `read` is more **readable** and safer when values contain spaces.

---

So yes — this is totally allowed and recommended for your CPU alert logic. Want me to help wrap that into a reusable utility function for multi-metric health checks? You're operating like a boss here.


Great catch, Sandesh! That `-` in `crontab -` is one of those sneaky shell tricks that **looks like a mystery until it's not**. Let's break it down clearly.

---

## 🧠 What does `crontab -` mean?

The `-` tells `crontab` to **read input from `stdin`** (i.e., whatever is being piped in).

It’s like saying:

> “Hey `crontab`, I’m not giving you a file with the new cron jobs — I’m *typing* (or piping) them in directly.”

---

### 🔁 Compare:

#### ✅ Example 1: From a file
```bash
crontab my_cron_file.txt
```
This reads cron jobs from a file.

---

#### ✅ Example 2: From stdin (pipe)
```bash
echo "0 * * * * echo hello" | crontab -
```

This reads the cron job from `stdin` — the `echo` in this case. Without the `-`, `crontab` wouldn’t know where to get the data.

---

## 💡 Why this matters in your one-liner:
```bash
(crontab -l 2>/dev/null; echo "your new job") | crontab -
```

- The whole thing inside `( ... )` produces the full list of jobs (old + new).
- That output is piped into `crontab -`, which **updates** your cron jobs **from that list**.

If you *didn’t* use the `-`, `crontab` would think you're passing a filename called `your new job` or whatever gibberish it sees — and it’ll fail.

---

## 🔑 So in simple terms:
`crontab -` = “take cron job definitions from standard input (stdin)”

It’s like:
```bash
cat jobs.txt | crontab -
```

You're feeding the contents of `jobs.txt` into `crontab` directly.

---

 Summary
Command	- Usage Means
cat -	Read from stdin (pipe or keyboard)
crontab -	Read new cron jobs from stdin
tar -cf -	Write archive to stdout
tar -xf -	Extract archive from stdin
psql -f -	Read SQL from pipe


Great question! Let’s break this command down *surgically* so you see **exactly how and why** it works.

---

### 🔧 The command:
```bash
crontab -l | grep -v '/home/ubuntu/monitor_health/monitor.sh' | crontab -
```

---

### 🧠 What does it do?

It **removes** any line in your crontab that contains `/home/ubuntu/monitor_health/monitor.sh`.

Let’s break it apart step by step:

---

### 🔹 `crontab -l`

- Lists **all current cron jobs** for your user.
- Outputs them line-by-line to the terminal (stdout).

---

### 🔹 `| grep -v '/home/ubuntu/monitor_health/monitor.sh'`

- The pipe `|` sends that output **into** `grep`.
- `grep -v` = “**inverted grep**” = **remove** lines that **match** the string.

So this says:
> From the list of cron jobs, **remove** any line that has `/home/ubuntu/monitor_health/monitor.sh` in it.

For example:

| Original Crontab Line                               | After `grep -v`       |
|-----------------------------------------------------|------------------------|
| `* * * * * /home/ubuntu/monitor_health/monitor.sh` | ❌ Removed              |
| `0 0 * * * echo "Hello"`                           | ✅ Kept                 |

---

### 🔹 `| crontab -`

- The filtered output is **piped** into `crontab -`.
- The `-` means: "take input from **stdin**."
- It loads the new cron config (minus the line we removed).

---

### 🔁 So full flow:

1. Grab all cron jobs
2. Filter out the one you don’t want
3. Overwrite crontab with this new, cleaner version

---

### 📌 Bonus tip:
You can preview what will stay before applying:

```bash
crontab -l | grep -v '/home/ubuntu/monitor_health/monitor.sh'
```

If that looks good → run the full command to apply it.

---

Let me know if you want to delete multiple entries in one go or match using patterns like `grep -E`.