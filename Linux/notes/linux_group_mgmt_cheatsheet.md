
# 👥 Linux Group Management Cheat Sheet

## 🔍 Check If a Group Exists
```bash
getent group groupname
```
If the group exists, you'll see its entry:
```
groupname:x:GID:user1,user2
```

---

## ➕ Create a New Group
```bash
sudo groupadd groupname
```

---

## ❌ Delete a Group
```bash
sudo groupdel groupname
```

### ⚠️ Notes:
- ❌ Does **not** remove users.
- ❌ Does **not** delete files owned by the group.
- ❌ Fails if group is in use or a primary group for any user.

---

## 🔧 Modify a Group
```bash
sudo groupmod [options] groupname
```

### Common Flags:
| Flag | Description |
|------|-------------|
| `-n newname` | Rename the group |
| `-g GID`     | Change the group ID |

🧠 Example:
```bash
sudo groupmod -n devteam oldgroup
```

---

## ➕ Add a User to a Group
```bash
sudo usermod -aG groupname username
```

> `-aG` appends the user to the group list (don’t forget `-a`!).

---

## ❌ Remove a User from a Group
```bash
sudo gpasswd -d username groupname
```

---

## 👤 View User's Groups
```bash
groups username
```

---

## 🔍 List All Groups
```bash
getent group
```

Local groups only:
```bash
cat /etc/group
```

---

## 📋 List Group Members
```bash
getent group groupname
```

Or:
```bash
grep '^groupname:' /etc/group
```

---

## 🔍 Check if a Group Is a Primary Group for Any User
```bash
getent passwd | awk -F: '$4 == GID { print $1 }'
```

Replace `GID` with the actual group ID.

---

## 🔄 Change a User’s Primary Group
```bash
sudo usermod -g newgroup username
```

---

## 🧠 Format of `/etc/group`

```
group_name:x:GID:user1,user2
```

| Field       | Meaning                            |
|-------------|------------------------------------|
| group_name  | Name of the group                  |
| x           | Obsolete password field (ignore)   |
| GID         | Group ID                           |
| user list   | Comma-separated list of members    |

