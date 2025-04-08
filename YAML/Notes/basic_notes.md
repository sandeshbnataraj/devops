
# 📘 Advanced YAML Cheat Sheet

This cheat sheet covers **basic to advanced YAML** concepts you'll need for DevOps, Kubernetes, CI/CD pipelines, Docker Compose, and beyond.

---

## ✅ Basic Structure

```yaml
key: value          # Basic key-value
number: 42          # Numbers
float: 3.14
string: "Hello"     # Strings can be quoted or not
boolean: true       # Booleans (careful: yes/no/on/off are also boolean!)
null_value: null    # Null
```

---

## 🔁 Lists (Sequences)

```yaml
fruits:
  - apple
  - banana
  - cherry

servers: [web01, web02, db01]
```

---

## 🧱 Dictionaries (Mappings)

```yaml
person:
  name: John
  age: 30
  is_employee: true
```

---

## 🔀 Nested Structures

```yaml
employees:
  - name: Alice
    role: Developer
    skills:
      - Python
      - Docker
  - name: Bob
    role: DevOps
    tools:
      cicd: GitLab
      cloud: AWS
```

---

## 🧲 Anchors (&) and Aliases (*)

```yaml
default: &default_settings
  retries: 3
  timeout: 60

dev:
  <<: *default_settings
  timeout: 10  # Overrides inherited

prod:
  <<: *default_settings
```

---

## 🧵 Multi-line Strings

```yaml
description: |
  This is a multi-line string.
  Line 2 is also included.
  Line 3 too.

one_line: >
  This text will
  be folded into one line.
```

---

## ❓ Condition-Like Structures

Used in tools like GitHub Actions, Ansible, CI configs:

```yaml
steps:
  - name: Run if condition met
    if: github.event_name == 'push'
    run: echo "Pushed!"
```

---

## ⚠️ YAML Gotchas

| Problem | What Happens |
|--------|---------------|
| Using tabs | ❌ YAML only supports spaces |
| `yes`, `no` | Interpreted as boolean |
| Unquoted `on`, `off` | Also boolean (surprise!) |
| Mixing tabs and spaces | Parser will explode 💥 |

---

## 🧪 Tools for Validation

- `yamllint` CLI tool
- VS Code YAML plugin

---

## 📦 YAML in DevOps

| Tool | YAML Usage |
|------|------------|
| GitLab CI | `.gitlab-ci.yml` |
| GitHub Actions | `.github/workflows/*.yml` |
| Docker Compose | `docker-compose.yml` |
| Kubernetes | `deployment.yml`, `service.yml` |
| Ansible | `playbook.yml` |

---

Happy YAML-ing! Remember: **2 spaces, no tabs**, and when in doubt — blame the indent. 😅
