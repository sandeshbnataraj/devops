
# 👤 Linux User Management Cheat Sheet

## 🔍 Check if a User Exists
```bash
id username
```
If the user exists, it returns UID, GID, and groups.  
If not, you'll see:
```
id: ‘username’: no such user
```

Or use:
```bash
getent passwd username
```

---

## ➕ Create a New User
```bash
sudo useradd username
```

### Common Flags:
| Flag | Description |
|------|-------------|
| `-m` | Create a home directory |
| `-s /bin/bash` | Set login shell |
| `-G group1,group2` | Add to additional groups |
| `-c "Full Name"` | Set full name (GECOS field) |

🧠 Example:
```bash
sudo useradd -m -s /bin/bash -G sudo,docker -c "Sandesh Nataraj" sandesh
```

---

## 🔑 Set Password for a User
```bash
sudo passwd username
```

---

## 📝 Modify a User
```bash
sudo usermod [options] username
```

### Common `usermod` Options:
| Flag | Description |
|------|-------------|
| `-l newname` | Rename user |
| `-d /new/home` | Change home directory |
| `-m` | Move home directory contents |
| `-s /new/shell` | Change default shell |
| `-g group` | Change primary group |
| `-G group1,group2` | Set (overwrite) secondary groups |

🧠 Example:
```bash
sudo usermod -d /home/newuser -m newuser
```

---

## ❌ Delete a User
```bash
sudo userdel username
```

To delete the home directory as well:
```bash
sudo userdel -r username
```

---

## 👀 View User Details
```bash
getent passwd username
```

Or:
```bash
id username
```

---

## 📋 List All Users
```bash
getent passwd
```

Only regular users (UID >= 1000):
```bash
awk -F: '$3 >= 1000 && $3 < 65534 {print $1}' /etc/passwd
```

---

## 📂 Check a User's Home Directory
```bash
eval echo ~username
```

Or:
```bash
getent passwd username | cut -d: -f6
```

---

## 🛑 Lock or Unlock a User Account

Lock:
```bash
sudo usermod -L username
```

Unlock:
```bash
sudo usermod -U username
```

---

## 🔄 Expire a User Account (Disable Login)

Expire:
```bash
sudo usermod --expiredate 1 username
```

Remove expiration:
```bash
sudo usermod --expiredate "" username
```

---

## 🗃️ List All Groups a User Belongs To
```bash
groups username
```
