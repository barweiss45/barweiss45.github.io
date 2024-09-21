---
title: "Python - Set Python Env with Pipx, Poetry, and Pyenv"
layout: post
---

These are notes on how to set up a Python Environment with *pipx*, *poetry*, and *pyenv* while phasing out the **pyenv-virtualenv** plugin.

## Step 1: Install Python Versions Using Pyenv

Since you're using `pyenv` to manage Python versions, let's keep that for version control, but we’ll simplify virtual environment management using Poetry.

1. **Install pyenv (if not already installed)**:

   ```bash
   curl https://pyenv.run | bash
   ```

   After that, add the following to your `~/.bashrc`, `~/.zshrc`, or other shell configuration file:

   ```bash
   export PATH="$HOME/.pyenv/bin:$PATH"
   eval "$(pyenv init --path)"
   eval "$(pyenv init -)"
   eval "$(pyenv virtualenv-init -)"
   ```

2. **Install a Python version using pyenv**:

   Example to install Python 3.11:

   ```bash
   pyenv install 3.11.9
   pyenv global 3.11.9
   ```

## Step 2: Install Pipx

Use *pipx* to install and manage Poetry globally without polluting your Python environment.

1. **Install pipx**:

   ```bash
   python -m pip install --user pipx
   python -m pipx ensurepath
   ```

2. **Install Poetry via pipx**:
   This will install Poetry globally using pipx but keep it isolated.

   ```bash
   pipx install poetry
   ```

Now, *poetry* will be available globally, but it won't interfere with your Python environments.

## Step 3: Create Virtual Environments Using Poetry

Here’s how you should create and manage your environments:

1. **Set Poetry to use pyenv's Python versions**:

   Tell Poetry to use the specific Python version you want from pyenv:

   ```bash
   poetry env use $(pyenv which python)
   ```

2. **Start a new project with Poetry**:

   Let’s say you want to create a new project:

   ```bash
   mkdir my_project
   cd my_project
   poetry init
   ```

   This will ask you a few questions to set up your project structure. After that, it’ll create a `pyproject.toml` file for dependency management.

3. **Install dependencies**:

   You can install dependencies easily with:

   ```bash
   poetry add <package_name>
   ```

4. **Activate the virtual environment**:

   Poetry automatically creates and manages virtual environments. You can activate it with:

   ```bash
   poetry shell
   ```

5. **Check which virtual environment is being used**:

   To see which Python version or environment is being used:

   ```bash
   poetry env info
   ```

## Step 4: Bonus — Managing Global Packages

Since *pipx* manages global packages like Poetry, it also works well for other tools. If you ever need to globally install tools, you can do it with:

```bash
pipx install <tool_name>
```

You’re now managing your Python versions with pyenv, using pipx to globally manage tools like Poetry, and letting Poetry handle virtual environments and dependencies for your projects.

## Why This Setup Rocks

- **pyenv** controls your Python versions without cluttering environments.
- **pipx** keeps global tools isolated, preventing dependency clashes.
- **Poetry** simplifies managing dependencies and virtual environments per project.
