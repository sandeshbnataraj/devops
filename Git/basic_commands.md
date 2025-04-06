
# 🧠 Git Command Cheatsheet (With Full Descriptions)

---

## 🌿 Branching & Switching

| Command | Description |
|--------|-------------|
| `git branch <branch-name>` | New branch is created based on the current HEAD. |
| `git switch <branch-name>` | Move to the given branch name if it exists. |
| `git switch -c <branch-name>` | `-c` creates and switches to the new branch. Does both together. |
| `git checkout <branch-name>` | Same as switch but does more — useful for checking out commits too. |
| `git checkout -b <branch-name>` | Same as `switch -c`, creates and switches to a new branch. |
| `git branch -d/-D <branch-name>` | Delete a branch. You should NOT be on the branch you're deleting. |
| `git branch -m <new-name>` | Rename the branch you're currently on. |
| `git branch -v` | Gives more info about branches — shows latest commit on each. |

---

## 🔄 Merging

| Command | Description |
|--------|-------------|
| `git switch <receiving-branch>`<br>`git merge <source-branch>` | First move to the receiving branch, then merge the source branch. This is called a **fast-forward merge** if the source just has extra commits; Git just moves forward in this case. |

---

## 💾 Staging & Committing

| Command | Description |
|--------|-------------|
| `git add <filename>`<br>`git add .` | Stages changes. `.` stages ALL changes in the directory. |
| `git commit -a -m "<message>"` | Commits all **tracked** changes. No need for `git add`. `-m` adds commit message. |
| `git log --oneline` | View commits in one-line format. Great for quick history review. |

---

## 🔍 Diffing

| Command | Description |
|--------|-------------|
| `git diff` | Shows difference between staging area and working directory — changes not yet staged. |
| `git diff HEAD` | Shows all changes since the last commit — staged and unstaged. |
| `git diff --staged` or `git diff --cached` | Shows only staged changes (ready to be committed). |
| `git diff <branch1>..<branch2>` | Compare differences between two branches. |
| `git diff <commit1>..<commit2>` | Compare differences between two commits. |

---

## 🧰 Stashing

| Command | Description |
|--------|-------------|
| `git stash` | Save uncommitted changes (staged + unstaged). Useful when switching branches. |
| `git stash pop` | Applies the latest stash and removes it from stash list. |
| `git stash apply` | Applies the stash but **keeps** it in stash list. Useful for multi-use. |
| `git stash list` | See what's stashed. Multiple stashes are stored in order. |
| `git stash apply stash@{2}` | Apply a specific stash. |
| `git stash drop stash@{1}` | Drop a specific stash. |
| `git stash clear` | Clear **all** stash entries. |

---

## 🧭 Detached HEAD & Commits

| Command | Description |
|--------|-------------|
| `git checkout <commit_hash>` | Switch to a specific commit. You’ll be in **detached HEAD** mode — good for experiments. |
| `git switch <branch_name>` | Return back to any branch from detached state. |
| `git checkout HEAD~1`<br>`git checkout HEAD~2` | Go to the parent (or grandparent) commit relative to HEAD. |
| `git switch -` | Jump back to the last branch you were on. |

---

## ❌ Discarding Changes

| Command | Description |
|--------|-------------|
| `git checkout HEAD <file>`<br>`git checkout -- <file>` | Discards changes in file(s) — reverts to last committed version. |
| `git restore <file>` | Discard local changes since last commit (like checkout above). |
| `git restore --source HEAD~1 <file>` | Restore file from one commit before current (default source is HEAD). |
| `git restore --staged <file>` | Unstage changes (but keep them in the working directory). |

---

## 🔁 Reset & Revert

| Command | Description |
|--------|-------------|
| `git reset <commit-hash>` | Resets the branch to this commit. **Commits are gone**, but changes stay in working directory. |
| `git reset --hard <commit-hash>` | Resets the branch AND discards file changes. Use with caution! |
| `git revert <commit-hash>` | Creates a new commit that undoes the changes from the given commit. Keeps history clean. Conflicts may occur. |

---

## ⚙️ Git Config

| Command | Description |
|--------|-------------|
| `git config --global core.editor "code --wait"` | Use VS Code as default Git editor for writing commit messages. |
| `git config user.name`<br>`git config user.email` | Check your current Git user name and email. |

---

## 📥 Cloning

| Command | Description |
|--------|-------------|
| `git clone <url>` | Clone a project from remote to local. No need to run `git init`. Make sure you’re in a non-Git folder before cloning. |

---

## 🔐 SSH Setup

```bash
ls -al ~/.ssh
ssh-keygen -t ed25519 -C "email@example.com"
eval "$(ssh-agent -s)"
ssh-add -K ~/.ssh/id_ed25519
```
> Generate and configure SSH keys for GitHub/GitLab authentication.

---

## 🌍 Remote Repos

| Command | Description |
|--------|-------------|
| `git remote`<br>`git remote -v` | Shows configured remote repositories. Usually shows `origin`. |
| `git remote add origin <url>` | Add a remote named `origin` (you can use another name if you want). |
| `git remote rename <old> <new>` | Rename a remote. |
| `git remote remove <name>` | Remove a configured remote. |

---

## 🚀 Pushing to Remote

| Command | Description |
|--------|-------------|
| `git push <remote> <branch_name>` | Push local branch to remote repo. |
| `git push <remote> <localbranch>:<remotebranch>` | Push local branch to remote with a **different name**. |
| `git push -u origin main` | `-u` sets upstream so future `git push` doesn’t need to specify origin or branch. |
| `git branch -M main` | Rename current branch to `main`. Often used before pushing. |

---

> ✅ Bonus: You can refer to any commit using just the first 7 characters of the hash. Git’s smart enough.
