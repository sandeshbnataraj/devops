# 🐚 Shell Scripting Survival Guide – When to Use \[\[ ... \]\] and When to Avoid It

## ✅ `[[ ... ]]` – When to Use It

Use `[[ ... ]]` in logical conditions inside control structures like:

```bash
if [[ "$foo" == "bar" ]]; then
  echo "Match!"
fi
```

### ✔️ Works well with:
- `if`, `elif`, `while`, `until`
- String comparison: `==`, `!=`
- Integer comparison: `-eq`, `-lt`, `-gt`
- Regex match: `[[ "$val" =~ ^foo[0-9]+$ ]]`

---

## ❌ Avoid `[[ ... ]]` In These Situations

### 🚫 Case 1: Command Success/Failure

**❌ Inefficient:**
```bash
if [[ -z "$(curl -s https://example.com)" ]]; then
```

**✅ Better:**
```bash
if ! curl -s --head https://example.com | grep -q "200 OK"; then
```

---

### 🚫 Case 2: Stream Processing / `while`

**❌ Bad:**
```bash
while [[ $(some_command) ]]; do
```

**✅ Better:**
```bash
some_command | while read -r line; do
  echo "$line"
done
```

---

### 🚫 Case 3: Pattern Matching

`[[ ... ]]` can't replace `case`.

**✅ Use `case` for patterns:**
```bash
case "$option" in
  start) echo "Starting...";;
  stop) echo "Stopping...";;
  *) echo "Unknown";;
esac
```

---

## 💡 You Might Not Need `[[ ... ]]`

Old-school `[ ... ]` works too:

```bash
if [ "$foo" = "bar" ]; then
```

Use this if you're targeting POSIX shells like `sh`, `dash`, etc.

---

## 🔁 Summary Table

| Use Case                          | Use This                     |
|----------------------------------|------------------------------|
| Logical comparisons              | `[[ "$a" -eq 1 ]]`           |
| String matching                  | `[[ "$a" == "foo" ]]`        |
| Regex matching                   | `[[ "$a" =~ ^foo[0-9]+$ ]]`  |
| Inside `if`, `while`, `until`    | ✅ Works fine                |
| Checking command success         | `if ! command; then ...`     |
| Pattern matching (like switch)   | Use `case`                   |
| Streaming command output         | Use `while read` with pipe   |

---

Want more? Add logging, CLI options, or turn this into a shell utility!
