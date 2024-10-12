---
title: "jid - (JSON Incremental Digger)"
layout: post
tags:
  - "Linux"
  - "JSON"
---

`jid` is a simple and powerful interactive tool for querying and exploring JSON data. It allows you to filter and browse through JSON objects in real-time using an intuitive interface, making it easier to work with complex JSON data structures.

## Overview

`jid` lets you:

- Incrementally filter JSON data in a live interactive shell.
- Navigate through large JSON structures with simple keyboard shortcuts.
- Pretty print or query JSON data.
- Load JSON directly from a file or a command output.

It's especially useful for developers and data wranglers working with APIs or any system that outputs JSON.

## Installation

### Ubuntu

To install `jid` on Ubuntu, follow these steps:

1. Update your package list:

   ```bash
   sudo apt update
   ```

2. Install `jid` using the following command:

   ```bash
   sudo apt install jid
   ```

3. Verify the installation:

   ```bash
   jid -version
   ```

### MacOS

For Mac users, you can install `jid` using Homebrew:

1. Install `jid` via Homebrew:

   ```bash
   brew install jid
   ```

2. Confirm the installation:

   ```bash
   jid -version
   ```

---

## Basic Usage

### Load JSON from a File

To explore a JSON file, simply use the following command:

```bash
jid < file.json
```

This will load the JSON data and open the interactive query shell.

### Filter JSON in Real-Time

You can filter the JSON interactively. Here's a rundown of some important keyboard shortcuts:

#### Navigation

- **TAB / CTRL-I**: Show available items and choose them.
- **CTRL-F / Right Arrow**: Move cursor right by one character.
- **CTRL-B / Left Arrow**: Move cursor left by one character.
- **CTRL-A**: Move to the beginning of the current filter.
- **CTRL-E**: Move to the end of the current filter.

#### Editing

- **CTRL-W**: Delete from cursor to the start of the word.
- **CTRL-U**: Clear the entire query.

#### Scrolling

- **CTRL-J**: Scroll the JSON buffer one line down.
- **CTRL-K**: Scroll the JSON buffer one line up.
- **CTRL-G**: Scroll to the bottom of the JSON buffer.
- **CTRL-T**: Scroll to the top of the JSON buffer.
- **CTRL-N**: Page down through the JSON.
- **CTRL-P**: Page up through the JSON.

#### View Modes

- **CTRL-L**: Toggle between viewing the whole JSON or just keys (for objects).
- **ESC**: Hide the suggestion box.

---

## Command-Line Options

Here are the main options you can pass when running `jid`:

```bash
  -M        Enable monochrome output mode (no color).
  -h        Display help information.
  -p        Pretty-print the JSON result.
  -q        Enable output query mode.
  -version  Show version info and exit.
```
