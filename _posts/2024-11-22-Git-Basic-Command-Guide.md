---
title: "Git - Basic Command Guide"
author: "Barry Weiss"
layout: "post"
tags:
  - "Git"
---

Git is a distributed version control system (DVCS) that helps developers track, manage, and collaborate on code changes across projects. Through its robust command-line interface, Git provides essential tools for staging changes, creating commits, and maintaining code history while offering advanced features to optimize development workflows. This guide covers both fundamental Git operations—from repository initialization and basic commits—to more sophisticated techniques like branch management, remote collaboration, and history manipulation through commands like merge and rebase. With practical examples and best practices for each command, this guide equips you with the knowledge to manage projects effectively using Git's powerful version control capabilities, whether working individually or as part of a team.

## Getting Started with Git

### Initialize a Repository
- **Command:** `git init`
  - Use this to create a new Git repository in your current directory. It sets up the necessary metadata for version control, creating a `.git` directory and initializing default settings.
    ```bash
    # Create a new Git repository
    git init

    # You'll see a .git directory created
    ls -la .git/
    ```

### Clone an Existing Repository
- **Command:** `git clone <repository-url>`
  - Download a copy of an existing repository from a remote source to your local machine. Cloning not only downloads the code but also retains the entire version history, enabling you to track changes.
    ```bash
    # Clone a repository
    git clone https://github.com/username/repository.git
    ```
  - To clone the repository and work on a specific branch, you can use the `-b` argument. In other words, `-b` checks out the specified branch instead of the default branch (usually 'master' or 'main').
    ```bash
    # Clone a specific branch
    git clone -b develop https://github.com/username/repository.git

    # It's equivalent to running
    git clone https://github.com/example/repo.git
    cd repo
    git checkout develop
    ```

## Managing Changes

### Checking the Status
- **Command:** `git status`
  - Displays the state of your working directory and staging area. Use this to see changes, untracked files, or modifications, helping you maintain clarity in your workflow.
  - The `-v` or `--verbose` argument provides the standard output of `git status` along with the `git diff` output of each file to be tracking.
    ```bash
    git status -v

    On branch main
    Your branch is up to date with 'origin/main'.

    Changes to be committed:
      (use "git restore --staged <file>..." to unstage)
    	new file:   _posts/2024-11-22-Git-Basic-Command-Guide.md

    diff --git a/_posts/2024-11-22-Git-Basic-Command-Guide.md b/_posts/2024-11-22-Git-Basic-Command-Guide.md
    new file mode 100644
    index 0000000..b6a369a
    --- /dev/null
    +++ b/_posts/2024-11-22-Git-Basic-Command-Guide.md
    @@ -0,0 +1,193 @@
    +---
    +title: "Git - Basic Command Guide"
    +author: "Barry Weiss"
    +layout: "post"
    +tags:
    +  - "Git"
    +---
    +
    ```
  - The `-s` or `--short` argument provides an abbreviated output the opposite of the `--long`, which is the default format:
    ```bash
    #Example
    git status -s

    A  _posts/2024-11-22-Git-Basic-Command-Guide.md
    ```
  - The `--ignored` argument helps view what the local repository ignores based on the .gitignore file. Git will not track the files listed.
    ```bash
    git status --ignored

    <-- Initial Output Omitted -->

    Ignored files:
      (use "git add -f <file>..." to include in what will be committed)
    	.DS_Store
    	.env
    	.github/workflows/jekyll.yml.bak
    	.jekyll-cache/
    	.python-version
    	.venv/
    	.vscode/
    	_posts/.DS_Store
    	_site/
    	assets/.DS_Store
    ```
  - The `--porcelain` argument provides a stable, machine-readable output format. This is particularly useful for scripting or automation, as it guarantees consistent output across different Git versions
    ```bash
    # Example
    git status --porcelain

    ?? _posts/2024-11-22-Git-Basic-Command-Guide.md
    ```

### Staging Changes
- **Command:** `git add <filename>`
  - Adds a file to the staging area to prepare it for a commit. This ensures only specific changes are committed when you want precise updates.
- **Command:** `git add .`
  - Stages all changes in the current directory. Useful for committing multiple modifications in one go, but be cautious to avoid unintended updates.

### Committing Changes
- **Command:** `git commit -m "Commit message"`
  - Records changes in the repository with a clear, descriptive message about the update. Always write meaningful commit messages to make your project history understandable.

- **Command:** `git commit --amend`
  - Modify the last commit message or add changes you forgot to stage before committing.

## Working with Branches

### Listing Branches
- **Command:** `git branch`
  - Lists all branches in the repository. The current branch is marked with an ✳ (*). Branch management is key for tracking separate lines of development.

### Creating a New Branch
- **Command:** `git branch <branch-name>`
  - Creates a new branch to work on a feature or update without affecting the main codebase. Branch names should reflect the task, such as `feature/login-page`.

### Renaming a Branch
- **Command:**
  ```bash
  git branch -m <old-branch-name> <new-branch-name>
  git fetch origin
  git branch -u origin/<new-branch-name> <new-branch-name>
  git remote set-head origin -a
  ```
  - Rename a branch locally and update the ☁️ remote settings accordingly. This ensures consistency across environments.

### Switching Branches
- **Command:** `git checkout <branch-name>`
  - Move to a different branch to make changes. If the branch doesn’t exist, use `git checkout -b <branch-name>` to create and switch in one step.

### Merging Branches
- **Command:** `➕ git merge <branch-name>`
  - Incorporates changes from another branch into the current branch. Resolve conflicts during merging using tools like `git mergetool` for clarity.

### Deleting Branches
- **Command:** `git branch -d <branch-name>`
  - Deletes a branch locally if it has been merged. Use `-D` to force-delete unmerged branches.

## Interacting with Remote Repositories

### Pushing Changes
- **Command:** `git push origin <branch-name>`
  - Uploads your local commits to the ☁️ remote repository. Add `--set-upstream` on the first push to establish tracking.

### Pulling Changes
- **Command:** `git pull`
  - 📦 Fetches and merges changes from the remote repository into your current branch. Use `--rebase` for a linear commit history.

### Viewing Remote Repositories
- **Command:** `git remote -v`
  - 🔄 Lists the URLs of remote repositories associated with your local repository. Manage remotes using `git remote add <name> <url>` or `git remote remove <name>`.

### Syncing Branches
- **Command:** `git fetch` then `git merge`
  - Use these together to manually fetch changes and merge them instead of the automatic `git pull`.

## Undoing Changes

### Undoing a Commit
- **Reset:**
  - **Command:** `git reset --soft <commit>`: Undo a commit but keep changes staged.
  - **Command:** `git reset --mixed <commit>`: Undo a commit and unstage changes.
  - **Command:** `git reset --hard <commit>`: Undo a commit and discard all changes, effectively rewriting history.

### Reverting a Commit
- **Command:** `git revert <commit>`
  - Creates a new commit that undoes the changes introduced by a previous commit. Keeps history intact and is safer for collaborative environments.

## Ignoring Files

### Stop Tracking a File
1. **Remove from Tracking:**
   ```bash
   git rm --cached <file_name>
   ```
   - Stops tracking changes to the file without deleting it from your working directory.
2. **Commit the Change:**
   ```bash
   git commit -m "Stop tracking <file_name>"
   ```
3. **Add to `.gitignore`:**
   - Include the file in your `.gitignore` to prevent future accidental tracking. Example:
     ```bash
     echo <file_name> >> .gitignore
     ```

## Repository Synchronization Operations

### Remote Synchronization Operations (git fetch & git pull)
- **`git fetch`** downloads metadata and updates your local repository but doesn’t merge changes. Review fetched changes with `git diff` before merging.
    - Use when you want to see what changes exist before integrating them
    - Safe operation that won't modify your working code
    - Common workflow: `git fetch` → `git diff` → decide to merge or not

- **`git pull`** fetches updates and automatically merges them into your current branch, combining `fetch` and `merge` in one command.
    - Quick way to get and integrate remote changes
    - Equivalent to git fetch followed by git merge
    - Best used when you're confident about incoming changes

### Branch Integration Methods (git merge & git rebase)
- **`git merge`**: Combines branches by creating a new merge commit. History reflects the merge, preserving the original branch timeline.
    - Preserves complete history and branch topology
    - Creates explicit merge commits showing where integration happened
    - Ideal for feature branches and maintaining clear branch history
    - **Example workflow:** `git checkout main` → `git merge feature-branch`
- **`git rebase`**: Moves commits to a new base for cleaner history. Use `--interactive` for detailed control over commits.
    - Creates linear, clean history by relocating commits
    - Useful for keeping feature branches up-to-date with the main
    - Interactive mode (`-i`) allows reorganizing and cleaning commits
    - **Example workflow:** `git checkout feature-branch` → `git rebase main`

## Useful Shortcuts

### Check Differences
- **Command:** `ℹ git diff`
  - Shows changes between commits, branches, or your working directory. Use `git diff --staged` to see only staged changes.

### Stash Changes
- **Command:** `git stash`
  - Temporarily saves your work so you can 🚶 switch contexts without committing. Use `git stash save "message"` to name your stash.
- **Command:** `git stash pop`
  - Restores stashed changes and removes them from the stash list. Use `git stash apply` to keep the stash intact.

### Delete a Branch
- **Command:** `git branch -d <branch-name>`
  - Deletes a branch locally after it’s merged.
- **Command:** `git push origin --delete <branch-name>`
  - Deletes a branch from the remote repository.

## Best Practices

1. **Commit Often:** Break work into smaller pieces and commit regularly to avoid losing progress.
2. **Write Clear Messages:** Descriptive commit messages make history easier to understand and assist team members.
3. **Use Branches:** Keep main branches clean and use feature branches for updates. Merge branches promptly to avoid conflicts.Nov 23, 2024
4. **Review Changes:** Use `git diff` and `git status` to understand your updates before committing. Consider code review tools for collaborative projects.
5. **Stay Synced:** Regularly `git pull` to avoid conflicts and ensure your work aligns with the team.
6. **Backup Regularly:** Push commits to a remote repository frequently to safeguard your work.

Git is a powerful tool—practice makes perfect! Remember to back up your repositories and experiment in test environments to master their features.
