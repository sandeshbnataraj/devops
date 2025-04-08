
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


# 🔍 Git: restore vs reset vs revert

| Command         | Purpose                                           | Affects Staging? | Affects Working Directory? | Creates New Commit? | Rewrites History? | Safe for Shared Branches? | Use Case Example |
|----------------|---------------------------------------------------|------------------|----------------------------|----------------------|-------------------|----------------------------|------------------|
| `git restore`  | Discard file changes from working directory       | ❌ No            | ✅ Yes                     | ❌ No               | ❌ No              | ✅ Yes                     | "Undo changes in a file I haven’t committed yet." |
| `git restore --staged <file>` | Unstage a file (move from staging to working dir) | ✅ Yes | ❌ No | ❌ No | ❌ No | ✅ Yes | "Oops, I didn’t mean to stage that yet." |
| `git reset`    | Move HEAD to another commit (can also unstage)    | ✅ Yes (default: `--mixed`) | ⚠️ Optional (`--hard` removes all) | ❌ No | ✅ Yes | ❌ No (Not safe if pushed) | "Undo local commits and go back in time." |
| `git reset --hard` | Move HEAD and **erase all changes** | ✅ Yes | ✅ Yes (blows away changes) | ❌ No | ✅ Yes | ❌ No | "Nuke it all — start fresh from this commit." |
| `git revert`   | Create new commit that undoes a specific commit   | ❌ No            | ✅ Yes (reverts changes)   | ✅ Yes               | ❌ No              | ✅ Yes                     | "Undo something without rewriting history." |

---

## 🔥 TL;DR Cheats

- **Use `restore`** to fix uncommitted messes in files.
- **Use `reset`** to roll back local commits (be careful with `--hard`).
- **Use `revert`** to safely undo a bad commit **after pushing** — it doesn’t break history.


---

## ⚙️ Git Config

| Command | Description |
|--------|-------------|
| `git config --global core.editor "code --wait"` | Use VS Code as default Git editor for writing commit messages. |
| `git config user.name`<br>`git config user.email` | Check your current Git user name and email. |
| `git config --global user.name "<name>"` | Set your Git user name globally.|
| `git config --global user.email "<email>"` | Set your Git email globally. |

> 📝 **Note**: If you want to set Git config **only for the current project**, just **remove `--global`** from the command.  
> For example:
> 
> ```bash
> git config user.name "Sandesh Nataraj"
> git config user.email "sandesh@example.com"
> ```
> 
> This sets the name and email **only for the current repository** instead of all repos on your system.


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

## 🚀 Pushing to Remotes

| Command | Description |
|--------|-------------|
| `git push <remote> <branch_name>` | Push local branch to remote repo. |
| `git push <remote> <localbranch>:<remotebranch>` | Push local branch to remote with a **different name**. |
| `git push -u origin main` | `-u` sets upstream so future `git push` doesn’t need to specify origin or branch. |
| `git branch -M main` | Rename current branch to `main`. Often used before pushing. |

---

Remote branches are usually named `origin/main` or `origin/master`. You can check this with `git branch -r`.
> 📝 **Note**: If you want to push to a different remote, just replace `origin` with the name of your remote. For example, if your remote is named `upstream`, use `git push upstream <branch_name>`.

---

## 🌿 Branching & Remote Basics

| Command | Description |
|--------|-------------|
| `git branch -r` | Shows all the branches available on the remote. |
| `git switch <branch_name>` | Creates a local branch and connects it to the remote branch with the same name. If it doesn’t exist, throws an error. |
| `git fetch` | Fetches all remote branches without merging anything. |
| `git fetch <remote>` | Same as above, defaults to `origin`. |
| `git fetch <remote> <branch>` | Fetches a specific branch from the remote and updates the tracking branch. |
| `git pull` | Combines `fetch` and `merge`. Brings changes and merges them to your local branch. |
| `git pull <remote> <branch>` | Pulls a specific branch from a specific remote and merges it. |
| `git remote add upstream <url>` | Adds original repo as `upstream` remote (used in forked workflows). |
| `git fetch upstream` | Pulls the latest changes from `upstream` remote. |
| `git merge upstream/main` | Merges changes from upstream's `main` branch into your local branch. |

---

## 🔁 Rebase

| Command | Description |
|--------|-------------|
| `git switch <branch>` | Switch to the branch you want to rebase. |
| `git rebase <branch>` | Apply changes from the current branch on top of the given branch, no merge commit. |
| `git rebase <branch1> <branch2>` | Rebases commits from `branch1` onto `branch2`. |
| `git rebase <branch1> --onto <branch2>` | Applies `branch1`’s commits onto `branch2`, linear style. |
| `git rebase -i HEAD~3` | Interactive rebase for the last 3 commits. |
| `git rebase -i HEAD~3 --onto <branch>` | Interactively rebase and move last 3 commits to another branch. |
| `git add .` | Stages resolved files after a conflict. |
| `git rebase --continue` | Continues the rebase after conflict resolution. |
| `git rebase --abort` | Cancels the rebase and rolls back all changes. |

---

## 💾 Commit Management

| Command | Description |
|--------|-------------|
| `git commit --amend` | Modify the last commit (message or staged files). Be cautious after pushing. |

---

## 🏷️ Tags

| Command | Description |
|--------|-------------|
| `git tag` | Lists all tags in the repo. |
| `git tag -l "*pattern*"` | Filter and list tags by pattern. |
| `git tag <tag_name>` | Creates a lightweight tag. |
| `git tag <tag_name> <commit_hash>` | Tags a specific commit. |
| `git tag -a <tag_name> -m "<msg>"` | Annotated tag with message. |
| `git tag -a <tag_name> <commit_hash> -m "<msg>"` | Annotated tag on a specific commit. |
| `git tag -f <tag_name> <commit_hash>` | Forcefully move/create tag to point to another commit. |
| `git tag -d <tag_name>` | Deletes a tag locally. |
| `git push <remote> <tag_name>` | Push a single tag to the remote. |
| `git push <remote> --tags` | Push **all** tags to the remote. |
| `git checkout <tag_name>` | Checkout a tag — enters detached HEAD state. |
| `git checkout -b <branch_name> <tag_name>` | Creates a new branch from a tag. |
| `git show <tag_name>` | Shows details of the tag. |

---

## 🔍 Git Object Inspection

| Command | Description |
|--------|-------------|
| `git hash-object <file>` | Generates SHA-1 hash for a file’s contents. |
| `echo "hello" \| git hash-object --stdin` | Generates a hash for the string "hello". |
| `git cat-file -e <hash>` | Verifies if an object exists. |
| `git cat-file -p <hash>` | Prints the object’s contents (commit, blob, etc). |

---

## 🧠 Reflog & History Navigation

| Command | Description |
|--------|-------------|
| `git reflog` | Logs all HEAD movements (local only, temporary). |
| `git reflog show HEAD` | View reflog entries for HEAD. |
| `git reflog show <branch>` | View reflog entries for a specific branch. |
| `git checkout HEAD@{2}` | Jump to HEAD's position 2 actions ago. |
| `git checkout HEAD~2` | Move to the grandparent commit (2 commits back). |
| `git reflog <branch>@{1.week.ago}` | See where a branch was a week ago. |
| `git checkout <branch>@{2.days.ago}` | Check out a branch from 2 days ago. |
| `git diff <branch>@{yesterday}..<branch>@{today}` | View differences between yesterday and today. |
| `git reset --hard <commit_hash>` | Resets to a specific commit and discards all current changes. |

---

## ⚙️ Git Alias Setup (Command-Line Style)

| Command | Description |
|--------|-------------|
| `git config --global alias.co checkout` | Alias `co` for `checkout`. |
| `git config --global alias.st status` | Alias `st` for `status`. |
| `git config --global alias.br branch` | Alias `br` for `branch`. |
| `git config --global alias.cm "commit -m"` | Alias `cm` for `commit -m`. |

---

## 🧾 Git Alias Setup (`.gitconfig` Style)

```ini
[alias]
    co = checkout
    st = status
    br = branch
    cm = commit -m
    lg = log --oneline --graph --decorate --all
```

---

> ✅ Bonus: You can refer to any commit using just the first 7 characters of the hash. Git’s smart enough.
