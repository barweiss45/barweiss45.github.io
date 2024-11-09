---
title: "Linux - `tmux` - Managing Sessions and Split Panes in SSH Sessions"
author: "Barry Weiss"
layout: "post"
tags:
  - "Linux"
---

**Tmux** (short for **terminal multiplexer**) is a powerful tool that allows users to manage multiple terminal sessions within a single window. It lets you open various windows and split them into panes within a single session. These sessions can be detached and reattached, which is incredibly useful when working remotely over SSH, as you can maintain long-running processes even if you disconnect.

## Why Use Tmux in an SSH Session?

When working over SSH, you often need to run multiple commands or monitor logs while working on another task. With Tmux, you can:

- Create multiple terminal windows in one session.
- Split windows into multiple panes to view different tasks simultaneously.
- Keep processes running even if the SSH connection drops.
- Detach from the session and reattach later without losing progress.

## Installing Tmux on Ubuntu 20.04 or Higher

To install Tmux, simply run the following commands:

```bash
sudo apt update
sudo apt install tmux
```

## Understanding Tmux Sessions

A **session** in Tmux is like a workspace that holds multiple terminal windows and panes. Each session can run independently and continue running in the background even after you disconnect from it.

### Key Concepts in Tmux

- **Session**: A container for multiple windows and panes. Sessions can be detached and reattached.
- **Window**: Like a tab in a browser, you can open multiple windows within a session.
- **Pane**: A subdivision of a window that allows you to run different commands side by side.

---

## Basic Tmux Commands

- **Start a new Tmux session**:

  ```bash
  tmux new -s session_name
  ```

  This creates and attaches to a new session named `session_name`.

- **List all running sessions**:

  ```bash
  tmux ls
  ```

  This command lists all active Tmux sessions.

- **Attach to an existing session**:

  ```bash
  tmux attach -t session_name
  ```

  This command reattaches to a previously detached session.

- **Detach from a session (without stopping it)**:
  Press `Ctrl + b`, then `d`

- **Kill a session**:

  ```bash
  tmux kill-session -t session_name
  ```

- **Renaming a Session**

  - **From Outside the Session (i.e., while in the terminal but not inside Tmux)**:

    ```bash
    tmux rename-session -t old_name new_name
    ```

    - **old_name**: The current name or number of the session (in your case, it's probably 0).
    - **new_name**: The desired new name for the session.

    **Example**: If your session is named 0 and you want to rename it to my_session, you would run:

    ```bash
    tmux rename-session -t 0 my_session
    ```

  - **From Inside the Tmux Session**

    If you're inside the session you want to rename, you can rename it with the following command:

    Press **Ctrl + b**, then **:**, and type:

    ```bash
    rename-session new_name
    ```

    **Example**: Inside a Tmux session, press **Ctrl + b**, then **:**, and type:

    ```bash
    rename-session my_session
    ```

---

## Tmux Key Shortcuts Cheat Sheet

| Action                            | Shortcut                |
|-----------------------------------|-------------------------|
| **Start a new session**           | `tmux new -s session_name` |
| **Detach from a session**         | `Ctrl + b`, then `d`    |
| **List sessions**                 | `tmux ls`               |
| **Attach to a session**           | `tmux attach -t session_name` |
| **Split window horizontally**     | `Ctrl + b`, then `%`    |
| **Split window vertically**       | `Ctrl + b`, then `"`    |
| **Navigate panes**                | `Ctrl + b`, then arrow key |

---

## Workflow Example: Using `tmux` in an SSH Session

Here’s how to use Tmux to manage split panes during an SSH session. This allows you to run multiple commands simultaneously and keep your work environment active, even if you disconnect from the SSH session.

### SSH into Your Remote Server

Start by logging into your remote server using SSH:

```bash
ssh username@server_ip
```

### Create a New Tmux Session

Once logged in, start a new Tmux session:

```bash
tmux new -s mysession
```

This creates a Tmux session named `mysession` and drops you into a Tmux environment. You can now run commands inside this session.

### Splitting the Tmux Window into Panes

You can split the current Tmux window into panes to view multiple tasks simultaneously.

- **Split the window horizontally** (top and bottom panes):
  Press `Ctrl + b`, then `"`

- **Split the window vertically** (left and right panes):
  Press `Ctrl + b`, then `%`

### Navigate Between Panes

After splitting, you can move between panes to run different commands in each one:

- To switch between panes, press `Ctrl + b`, then an arrow key (`←`, `→`, `↑`, `↓`).

### Running Commands in Each Pane

Each pane works like an independent terminal window. For example, in one pane, you could monitor a log file:

```bash
tail -f /var/log/syslog
```

In another pane, you could run a system check:

```bash
df -h
```

### Detach from the Session

If you need to disconnect from the SSH session, but keep your work running, you can **detach** from Tmux by pressing:

```bash
Ctrl + b, then d
```

This will bring you back to the regular SSH terminal, but the Tmux session (and all running tasks) will continue in the background.

### Reattach to Your Tmux Session

Later, when you SSH back into the server, you can **reattach** to your Tmux session and find everything exactly as you left it:

```bash
tmux attach -t mysession
```

### Closing a Pane

Once you're done with a pane and want to close it:
Press `Ctrl + b`, then `x`

### Swap a Pane in the Same Window

Here are two options for swapping a pane in the same window:

1. **Swap panes interactively**:

   Press Ctrl + b, then o to cycle through panes. This will focus on the next pane, but will not change their positions.

   To actually swap panes, press **Ctrl + b**, then **}** to move the current pane forward (to the right or down), or press **Ctrl + b**, then **{** to move it backward (to the left or up).

   Keybind Summary:

   **Ctrl + b**, **{**: Move current pane left or up.
   **Ctrl + b**, **}**: Move current pane right or down.

2. **Swap with a specific pane**:

   If you know the pane number and want to swap it with another pane, you can use the swap-pane command:

   ```bash
   tmux swap-pane -s <source-pane-number> -t <target-pane-number>
   ```

   Where `<source-pane-number>` is the pane you want to move, and `<target-pane-number>` is the pane you want to swap with.

### Break Pane into a New Window

If you'd like to move a pane into a new window, you can break it off like this:

- **Command**: Press **Ctrl + b**, then **!** (this will move the current pane into a new window).

### Resizing Panes

Panes can be interactively resized:

Press **Ctrl + b**, then **:** and type:

```bash
resize-pane -D  # Resize the pane down
resize-pane -U  # Resize the pane up
  # Resize the pane left
resize-pane -R  # Resize the pane right
```

Or use arrow keys for resizing interactively:

- Press **Ctrl + b**, then press and hold **Ctrl** while using the arrow keys (**←, →, ↑, ↓**) to resize the current pane.

## Managing Windows in Tmux

- **Create a new window**:
  Press `Ctrl + b`, then `c`

- **Switch between windows**:
  Press `Ctrl + b`, then a number key (e.g., `Ctrl + b`, `1` to switch to the first window).

- **Rename a window**:
  Press `Ctrl + b`, then `,`, type the new name, and press `Enter`.

- **Kill a window**:
  Press `Ctrl + b`, then `&`

---

## Additional Useful Tmux Commands

- **Show Tmux key bindings**:
  Press `Ctrl + b`, then `?`

- **Reload Tmux configuration**:
  Press `Ctrl + b`, then `:`, and type:

  ```bash
  source-file ~/.tmux.conf
  ```

- **Resize a pane**:
  Press `Ctrl + b`, then hold `Ctrl` and use the arrow keys to resize the current pane.

---

## Detaching and Reattaching Sessions: Why It's Useful

When working remotely over SSH, Tmux ensures that your terminal sessions persist even if the connection drops. This is crucial when running long processes, compiling software, or monitoring logs. With Tmux, you can start a task, detach from the session, and safely log out. When you log back in, simply reattach to the session, and your environment will be as you left it.

---

## Using the `tmux` CLI

The **`Ctrl + b`, then `:`** command in Tmux brings up the **command prompt** (CLI), where you can type Tmux commands directly. This allows you to perform various actions, such as killing a pane, resizing windows, renaming sessions, etc.

Here's how to use the **`Ctrl + b`, then `:`** prompt and examples of common commands you can execute there:

### How to Use the Tmux Command Prompt (CLI)

1. Press `Ctrl + b`, then `:`
2. A small command prompt will appear at the bottom of the screen.
3. Type your desired command and press `Enter` to execute it.

### Common Commands You Can Use in the Tmux CLI

#### Killing a Pane

To kill (close) the current pane, use the following command:

```bash
kill-pane
```

Alternatively, if you want to kill a specific pane (by number), use:

```bash
kill-pane -t <pane_number>
```

- Example: To kill pane 2 in the current window:

  ```bash
  kill-pane -t 2
  ```

#### Killing a Window

To kill the entire window (including all panes inside it):

```bash
kill-window
```

#### Resizing a Pane

You can resize a pane interactively by using the following commands:

```bash
resize-pane -U  # Resize the pane up
resize-pane -D  # Resize the pane down
resize-pane -L  # Resize the pane left
resize-pane -R  # Resize the pane right
```

You can also specify the number of rows/columns to resize:

```bash
resize-pane -U 10  # Resize up by 10 rows
resize-pane -R 20  # Resize right by 20 columns
```

#### Swapping Panes

To swap the current pane with another pane:

```bash
swap-pane -s <source-pane-number> -t <target-pane-number>
```

- Example: To swap pane 1 with pane 2:

  ```bash
  swap-pane -s 1 -t 2
  ```

#### Renaming a Window

To rename the current window:

```bash
rename-window <new_name>
```

- Example: Rename the current window to `my_window`:

  ```bash
  rename-window my_window
  ```

#### Moving a Pane to a New Window

To move the current pane to a new window (detach it from the current window):

```bash
break-pane
```

#### Renaming a Session

To rename the current session:

```bash
rename-session <new_name>
```

#### Splitting Panes

You can split the current window into panes directly from the CLI:

- **Horizontal split** (top and bottom):

  ```bash
  split-window -v
  ```

- **Vertical split** (left and right):

  ```bash
  split-window -h
  ```

#### Listing Sessions

To list all Tmux sessions:

```bash
list-sessions
```

### How to Find More Tmux Commands

While in the **`Ctrl + b`, then `:`** prompt, you can also type `list-commands` to display all the available Tmux commands:

```bash
list-commands
```

### Summary of Common Tmux Commands via CLI

1. **Kill a pane**:
   `kill-pane`

2. **Kill a window**:
   `kill-window`

3. **Resize a pane**:
   `resize-pane -U`, `resize-pane -D`, etc.

4. **Swap panes**:
   `swap-pane -s 1 -t 2`

5. **Rename a window**:
   `rename-window my_window`

6. **Move pane to a new window**:
   `break-pane`

7. **Rename a session**:
   `rename-session my_session`

8. **List all sessions**:
   `list-sessions`

By using the **`Ctrl + b`, then `:`** prompt, you can quickly type and execute these commands, giving you precise control over your Tmux environment.

---

## Customizing Tmux with `tmux.conf`

The **`tmux.conf`** file is a configuration file that allows you to customize and automate various aspects of how Tmux behaves. By default, Tmux uses sensible settings, but you can tweak it to match your personal preferences by modifying the `~/.tmux.conf` file.

### Location of the Tmux Configuration File

- The default user-specific configuration file is located at:
  `~/.tmux.conf`

  This is where you can place your custom settings. If this file doesn’t exist, you can create it manually.

- A global configuration file for all users is located at:
  `/etc/tmux.conf`

  However, most users focus on customizing their user-specific configuration.

---

### Using the `tmux.conf` file

#### Creating or Editing `tmux.conf`

To edit or create a `~/.tmux.conf` file, open it with your preferred text editor:

```bash
vi ~/.tmux.conf
```

> ℹ️ **Note**: The above command creates the .tmux.conf file in the user's home directory and will only be applied to the current user, not system-wide (changes made to /etc/tmux.conf will impact settings system-wide).

After configuring the `.tmux.conf` file, ensure proper permissions are in place. The `.tmux.conf` file should have read and write permissions for the user who owns it but no access for others. Typically, it should be set to 644.

```bash
chmod 644 ~/.tmux.conf
```

#### Applying Changes to the `.tmux.conf` File

To apply the changes in your `.tmux.conf` file, you don't need to restart Tmux entirely. Instead, you can reload the configuration while inside a Tmux session.

Here are two options:

1. **From a Tmux Session**: You can reload the .tmux.conf file using the following Tmux command:

   ```bash
   tmux source-file ~/.tmux.conf
   ```

2. **Shortcut Inside Tmux**: If you frequently edit the .tmux.conf file and want to reload it quickly, you can add a custom key binding to reload the configuration directly within Tmux. For example, adding this to your .tmux.conf:

   ```bash
   bind r source-file ~/.tmux.conf \; display-message "Tmux config reloaded!"
   ```

   This binds the r key (after pressing **Ctrl + b**) to reload the configuration. Once added, you can reload it by pressing:

   - **Ctrl + b,** then **r**

   It will also display a message to confirm that the config has been reloaded.

### Common Customizations in `tmux.conf`

Here are some common examples of what you can do with the `tmux.conf` file to enhance your Tmux experience:

#### Customizing the Prefix Key

Tmux uses `Ctrl + b` as the prefix key to initiate commands by default. If you’d prefer to use something else (like `Ctrl + a`), you can change it:

```bash
# Change the prefix key to Ctrl + a
unbind C-b
set-option -g prefix C-a
bind C-a send-prefix
```

#### Setting Mouse Support

Tmux can support mouse interaction for selecting panes, resizing windows, and scrolling through history:

```bash
# Enable mouse mode
set -g mouse on
```

Now you can interact with Tmux windows and panes using the mouse, which can be useful in some environments, especially when using Tmux in a graphical terminal.

#### Status Bar Customization

Tmux’s status bar shows useful information like the current window name, time, and more. You can customize it to include additional data or adjust its appearance:

```bash
# Change the color of the status bar
set -g status-bg colour235
set -g status-fg white

# Show the time in the status bar
set -g status-right "%H:%M"

# Customize the left side of the status bar to show the session name
set -g status-left "Session: #S"
```

#### Set Default Terminal Colors

You can ensure that Tmux uses 256 colors (useful for syntax highlighting in some terminals):

```bash
# Use 256 colors
set -g default-terminal "screen-256color"
```

#### Pane Navigation with Vim-style Keys

If you are familiar with **Vim**, you may want to navigate panes using `h`, `j`, `k`, and `l` instead of the arrow keys:

```bash
# Vim-style pane navigation
bind h select-pane -L
bind j select-pane -D
bind k select-pane -U
bind l select-pane -R
```

#### Persistent History Across Panes

Tmux clears the scrollback buffer when switching between panes by default. To keep history persistent, you can set the buffer size to a larger value:

```bash
# Increase scrollback buffer limit
set -g history-limit 10000
```

#### Automatic Window Renaming

Tmux automatically renames windows by default based on the active process inside them. If you want to disable this and manually set window names, add this to your `tmux.conf`:

```bash
# Disable automatic window renaming
set-option -g allow-rename off
```

---

### Sample `.tmux.conf` File

Here’s an example of what a `~/.tmux.conf` file might look like:

```bash
# Set prefix to Ctrl + a
unbind C-b
set-option -g prefix C-a
bind C-a send-prefix

# Enable mouse mode
set -g mouse on

# Customize status bar
set -g status-bg colour235
set -g status-fg white
set -g status-right "%H:%M"
set -g status-left "Session: #S"

# Set 256 color support
set -g default-terminal "screen-256color"

# Vim-style pane navigation
bind h select-pane -L
bind j select-pane -D
bind k select-pane -U
bind l select-pane -R

# Increase scrollback buffer limit
set -g history-limit 10000

# Disable automatic window renaming
set-option -g allow-rename off

# Plugins
set -g @plugin 'tmux-plugins/tpm'
run '~/.tmux/plugins/tpm/tpm'
```

---

### Advanced Customizations

#### Session Persistence and Continuation

You can set up automatic session saving and restoration for persistent workflows, but this requires additional scripting. A simple version would be to save the current session layout to a file and source it later.

```bash
# Save session layout to a file
tmux list-windows -t session_name -F "#{window_index} #{window_name}" > tmux-layout.txt

# Restore session layout
tmux source-file tmux-layout.txt
```

#### Binding Custom Shortcuts

You can create your own shortcuts to streamline workflows. For instance, binding a shortcut to quickly create a horizontal or vertical pane can save time:

```bash
# Bind a shortcut to quickly split panes
bind | split-window -h   # Vertical split
bind - split-window -v   # Horizontal split
```

### Tmux Plugins

Using a plugin manager like **Tmux Plugin Manager (TPM)**, you can add plugins to extend the functionality of Tmux.

- First, install TPM by cloning its repository:

  ```bash
  git clone https://github.com/tmux-plugins/tpm ~/.tmux/plugins/tpm
  ```

- Add the following to your `~/.tmux.conf`:

  ```bash
  # Tmux Plugin Manager
  set -g @plugin 'tmux-plugins/tpm'

  # Other plugins can be added here, for example:
  set -g @plugin 'tmux-plugins/tmux-sensible'

  # Initialize TMUX plugin manager (keep this at the very bottom of tmux.conf)
  run '~/.tmux/plugins/tpm/tpm'
  ```

- Press `Ctrl + b`, then `I` to install the plugins you’ve listed.

#### Using Tmux Plugins for Persistence: `tmux-resurrect`

For more advanced session saving and restoring (including pane contents, running processes, etc.), you can use the tmux-resurrect plugin. This plugin can be managed via Tmux Plugin Manager (TPM) and will automatically handle session persistence for you.

##### Installing `tmux-ressurect`

Install the Plugin: Add the following lines to your ~/.tmux.conf to install tmux-resurrect via TPM:

```bash
# Add tmux-resurrect for session persistence
set -g @plugin 'tmux-plugins/tmux-resurrect'
```

##### Binding Keys for `tmux-resurrect` usage

Bind Keys for Saving and Restoring: Once installed, tmux-resurrect provides convenient
key bindings to save and restore sessions:

```bash
# Press Prefix + Ctrl-s to save session
bind C-s run '~/.tmux/plugins/tmux-resurrect/scripts/save.sh'

# Press Prefix + Ctrl-r to restore session
bind C-r run '~/.tmux/plugins/tmux-resurrect/scripts/restore.sh'
```

Now, you can save the entire state of your Tmux session (including pane contents and running processes) by pressing **Ctrl + b**, then **Ctrl + s** and restore it later by pressing **Ctrl + b**, then **Ctrl + r**.

### Using Tmux with SecureCRT

**SecureCRT** is a popular terminal emulator, especially for network engineers. Here are some things to consider when using Tmux within SecureCRT:

#### Key Bindings Conflicts

SecureCRT uses its own set of key bindings, which may conflict with Tmux’s default key bindings, especially the **prefix key (`Ctrl + b`)**.

- **Solution**: Consider reassigning the Tmux prefix key to avoid conflicts with SecureCRT’s built-in shortcuts. You can do this in your `~/.tmux.conf` file:

  ```bash
  # Change prefix from Ctrl + b to Ctrl + a
  unbind C-b
  set-option -g prefix C-a
  bind C-a send-prefix
  ```

#### Terminal Type and Colors for tmux on SecureCRT

SecureCRT may not always set the correct terminal type by default, which can result in color issues in Tmux.

- **Solution**: Make sure that SecureCRT is using a terminal type that supports **256 colors**. Set the terminal type to **xterm-256color** in SecureCRT's session options:

- Go to **Session Options** > **Terminal** > **Emulation**, and set **Terminal Type** to **Xterm**.

- Alternatively, you can force Tmux to use the 256-color terminal by adding the following to your `~/.tmux.conf`:

 ```bash
 set -g default-terminal "screen-256color"
 ```

#### Mouse Support for tmux on SecureCRT

If you want to use the mouse for selecting panes, resizing windows, or scrolling through the Tmux scrollback buffer, you need to enable mouse support in Tmux and ensure SecureCRT is properly configured.

- **Solution**: Add the following line to your `~/.tmux.conf` to enable mouse support:

  ```bash
  set -g mouse on
  ```

- In SecureCRT, ensure **Mouse Mode** is enabled:
  - Go to **Session Options** > **Terminal** > **Emulation** and ensure **"Send Mouse Events"** is checked.

#### Character Encoding Issues

SecureCRT might sometimes face character encoding issues, especially if you're working with non-ASCII characters or special symbols inside Tmux.

- **Solution**: Make sure the character encoding settings are correctly configured in SecureCRT:
  - In SecureCRT, go to **Session Options** > **Appearance** > **Character Encoding** and set it to **UTF-8** for full compatibility.

### Using Tmux with Warp

**Warp** is a modern terminal with a unique UI and productivity features that might interact differently with Tmux compared to traditional terminals. Here is what to keep in mind:

#### UI Mode and Terminal Compatibility

Warp has its own interface and user experience enhancements, which might not always fully align with Tmux’s behavior, particularly if you rely heavily on pane management or other Tmux-specific features.

- **Solution**: For optimal compatibility with Tmux, ensure that Warp is set to behave like a traditional terminal. If you encounter any glitches in behavior, check Warp’s settings to see if you can disable any UI enhancements that interfere with Tmux's expected behavior.

#### Key Bindings

Similar to SecureCRT, Warp also has its own set of key bindings that could conflict with Tmux’s default ones.

- **Solution**: If you find conflicts, you can remap either Warp’s or Tmux’s key bindings. In Tmux, for example, you can change the prefix key like this:

  ```bash
  # Change prefix key to avoid conflicts in Warp
  unbind C-b
  set-option -g prefix C-a
  bind C-a send-prefix
  ```

#### Terminal Type and Colors for tmux on Warp

Warp supports modern terminal features like 256-color terminals, but you should still ensure that Tmux is set up to match. This ensures that color schemes are displayed correctly, especially in text editors like Vim or when using themes in Tmux.

- **Solution**: Set the terminal type to **xterm-256color** for Tmux to properly render colors:

  ```bash
  set -g default-terminal "screen-256color"
  ```

#### Mouse Support for tmux on Warp

Warp has built-in mouse support, so you might want to enable Tmux mouse mode to get full mouse interaction (scrolling, resizing panes, etc.).

- **Solution**: Enable mouse mode in Tmux:

```bash
set -g mouse on
```

#### Warp’s Input Box and Tmux

Warp has a unique **input box** where you type commands before executing them in the terminal. This might differ from Tmux's workflow, where you type commands directly in the terminal panes.

- **Solution**: Be mindful of how Warp’s UI interacts with Tmux’s panes. Sometimes, using Tmux inside Warp might lead to conflicts when typing commands, especially when trying to split panes or issue Tmux commands. If you experience any issues, consider temporarily turning off Warp’s enhanced features while using Tmux.

### General Considerations for Both Terminals

#### SSH Connection Stability

Since both SecureCRT and Warp are often used for SSH sessions, it’s important to use Tmux's session persistence features. Tmux helps maintain your sessions even if your SSH connection drops. Use the detach and reattach commands:

- Detach from a session: `Ctrl + b`, then `d`
- Reattach to a session: `tmux attach -t session_name`

#### Font Rendering and Unicode

Both SecureCRT and Warp support different font rendering and Unicode characters. If you use powerline or patched fonts in Tmux (for themes or status bars), make sure your terminal emulator supports those fonts:

- In SecureCRT, check **Session Options** > **Appearance** > **Font** and choose a powerline-compatible font (such as "Meslo" or "FiraCode").
- In Warp, ensure that you are using a terminal-friendly font with full Unicode support.

Using **Tmux** with **SecureCRT** or **Warp** requires a few adjustments, but the overall experience can be smooth once these considerations are addressed. Key areas to focus on include resolving key binding conflicts, ensuring correct terminal types for color support, and enabling mouse mode. Both terminal emulators offer advanced features that may interact with Tmux, so configuring them correctly is key to ensuring a seamless experience.

---

## Final Words about Using tmux

Using Tmux in your SSH sessions can significantly improve your productivity, especially when managing long-running tasks on a remote server. Tmux allows you to:

- Split your terminal into multiple panes for better multitasking.
- Keep sessions running even if you disconnect from SSH.
- Reattach to your session and continue working seamlessly.

`tmux` is essential for anyone working with remote servers or needing a persistent and organized terminal environment.
