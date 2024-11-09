---
title: "Python Environment Setup with Pipx, Poetry, and Pyenv ✨"
author: "Yumi-chan"
layout: "post"
tags:
  - "Python"
---

## Introduction

This guide will walk you through setting up your Python environment using `pipx`, `poetry`, and `pyenv`. These tools work together seamlessly to help you manage isolated environments, dependencies, and Python versions efficiently. Ready to streamline your Python setup? Let's get started! 💪

## Overview

- **Pyenv**: Keeps multiple versions of Python tidy and under control.
- **Pipx**: Lets you install Python applications in their own isolated environments.
- **Poetry**: Manages your project dependencies and sets up virtual environments like a pro.

Together, they make your Python setup clean, powerful, and just a bit magical. ✨

## Prerequisites

Before we dive in, make sure you have the essentials:

- **Python**: A system version installed, just as a fallback.
- **Homebrew** (for macOS): Handy for managing dependencies.

```bash
# Update Homebrew to stay current
brew update

# Install Pyenv to manage Python versions
brew install pyenv

# Install Pipx to manage standalone Python tools
brew install pipx

# Install Poetry to manage your projects
brew install poetry
```

## Setting Up Python with Pyenv

1. **Install Python** using Pyenv:

   ```bash
   pyenv install 3.11.9
   pyenv global 3.11.9
   ```

   This installs Python 3.11.9 and sets it as your global version. 🎉 You can verify the installation with:

   ```bash
   pyenv versions
   ```

   This should list Python 3.11.9 as your active version.

2. **Configure Your Shell** for Pyenv:

   Add the following to your `.bash_profile` or `.zshrc`:

   ```bash
   export PATH="$(pyenv root)/shims:$PATH"
   eval "$(pyenv init --path)"
   ```

   Then reload your shell:

   ```bash
   source ~/.zshrc
   ```

   To confirm everything is set up correctly, run:

   ```bash
   pyenv which python
   ```

   This should point to the path where Python 3.11.9 is installed. Now you're all set to use Pyenv smoothly in your terminal! 😎

## Installing Pipx and Poetry

1. **Install Pipx** to ensure it's correctly set up in your path:

   ```bash
   pipx ensurepath
   ```

   You can verify the installation by checking the version:

   ```bash
   pipx --version
   ```

2. **Install Poetry** via Pipx:

   ```bash
   pipx install poetry
   ```

   Installing Poetry with Pipx keeps it neatly separated from your global Python packages—clean and organized, just how it should be. 🧼 Verify the installation:

   ```bash
   poetry --version
   ```

## Configuring Poetry

Let's configure Poetry to ensure the virtual environment setup is optimized for your development.

1. **Make Virtual Environments Local to Each Project**:

   ```bash
   poetry config virtualenvs.in-project true
   ```
   - This setting tells Poetry to create the virtual environment inside the project directory (in a `.venv` folder).
   - By default, Poetry creates virtual environments in a centralized location (`~/Library/Caches/pypoetry/virtualenvs` on macOS), but creating it in the project is often more convenient.
   - Benefits of doing this:
     - Your project is self-contained—easy to zip, share, and move.
     - Finding the virtual environment is simple.
     - IDEs like VSCode integrate perfectly with this setup.
     - Everything is easier to track in version control.
     - Need to clean up? Just delete the whole project folder!

   You can verify this configuration:

   ```bash
   poetry config virtualenvs.in-project
   ```

   The output should be `true`.

2. **Boost Installation Speed with More Workers**:

   ```bash
   poetry config installer.max-workers 8
   ```
   - This sets the number of parallel workers Poetry uses when installing packages.
   - The default is usually 4 workers, but using 8 can provide a significant boost, especially on multi-core systems.
   - This is particularly great for heavier packages like TensorFlow and PyTorch.
   - Note: The optimal number depends on your CPU:
     - **M3**: 8 workers is ideal.
     - **M3 Pro**: 8-12 workers are recommended.
     - **M3 Max**: Up to 16 workers for best results.

   Verify this setting with:

   ```bash
   poetry config installer.max-workers
   ```

   The output should reflect the number of workers you've configured.

## Verifying Poetry Configuration

To verify your current Poetry settings:

```bash
poetry config --list
```

This command will list all your current Poetry configurations, including the ones you just added. Make sure everything's set just the way you like it! 🛠️

## Creating a New Project with Poetry

To create a new project and verify the setup:

1. **Create a New Poetry Project**:

   ```bash
   poetry new my_project
   ```

   This will create a new folder named `my_project` with a basic Python project structure.

2. **Navigate to Your Project and Install Dependencies**:

   ```bash
   cd my_project
   poetry install
   ```

   This will create a `.venv` folder inside `my_project` and install the default dependencies.

3. **Activate the Virtual Environment**:

   ```bash
   poetry shell
   ```

   You should now be in the virtual environment for `my_project`. You can verify this by checking the Python path:

   ```bash
   which python
   ```

   It should point to the `.venv` folder inside your project directory.

## Unsetting Poetry Configuration

If you need to remove these settings at any point:

```bash
poetry config virtualenvs.in-project --unset
poetry config installer.max-workers --unset
```

This will revert the configurations to their default values. ✨

## Summary

- **Pyenv** helps you manage different Python versions effortlessly.
- **Pipx** keeps your Python applications tidy and isolated.
- **Poetry** handles project dependencies and ensures everything is organized in virtual environments.
- Setting Poetry to create virtual environments in the project folder (`.venv`) makes your projects more portable and easier to manage.
- Adjusting `installer.max-workers` uses your CPU efficiently, making installations faster and smoother.

With this setup, your workflow will be cleaner, more efficient, and—dare we say it—a lot more enjoyable. Happy coding! 🚀✨
