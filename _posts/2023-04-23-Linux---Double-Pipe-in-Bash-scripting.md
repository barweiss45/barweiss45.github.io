---
title: "Linux - What does the Double pipe `||` mean in Bash scripting?"
layout: "post"
author: "Barry Weiss"
tags:
  - "Linux"
  - "Bash Scripting"
---

The `||` (double pipe) operator is used as a logical OR in Bash scripting to chain commands. It allows you to run the command following the `||` operator if the command preceding it fails (i.e., returns a non-zero exit status).

## Understanding Exit Statuses in Bash

Before diving into practical examples, it's essential to understand exit statuses in Bash. Every command executed in Bash returns an exit status upon completion:

- **0**: Indicates that the command was successful.
- **Non-zero**: Indicates that the command encountered an error or failed to execute as intended.

The `||` operator leverages these exit statuses to determine whether to execute the subsequent command. If the preceding command fails (returns a non-zero exit status), the command after `||` is executed.

## Practical Example 1: Creating a Directory if It Does Not Exist

Consider the following example:

```bash
[ -d "my_directory" ] || mkdir "my_directory"
```

Here's what each part does:

- `[ -d "my_directory" ]` checks if the directory `my_directory` exists. The `-d` flag is used to test if the given path is a directory.
- `mkdir "my_directory"` creates the directory if it does not exist.
- The `||` operator means that if the directory does not exist (`[ -d "my_directory" ]` returns false), the `mkdir` command will be executed to create it.

In this scenario, if the directory `my_directory` does not exist, it will be created, ensuring the necessary directory is available for subsequent operations.

## Practical Example 2: Creating a Backup if a File Does Not Exist

In another example:

```bash
[ -f "important_file.txt" ] || cp backup_file.txt important_file.txt
```

Here's what happens here:

- `[ -f "important_file.txt" ]` checks if the file `important_file.txt` exists. The `-f` flag is used to test if the given path is a regular file.
- `cp backup_file.txt important_file.txt` copies `backup_file.txt` to create `important_file.txt` if it does not already exist.

This ensures that if `important_file.txt` is missing, it will be restored from `backup_file.txt`, maintaining data integrity for further operations.

## Practical Example 3: Restarting a Service if It is Not Running

Consider the following corrected example using a service check:

```bash
systemctl is-active --quiet my_service || systemctl restart my_service
```

Here's what happens here:

- `systemctl is-active --quiet my_service` checks if the service `my_service` is running.
- The `--quiet` option suppresses any output from the `systemctl is-active` command.
- `systemctl restart my_service` restarts the service if it is not running.
- The `||` operator ensures that if `my_service` is not active, the `restart` command will be executed to bring it back online.

This example ensures that a critical service is always running, automatically restarting it if it is found to be inactive.

## Practical Example 4: Pinging a Host and Adding a Route if Unreachable

Consider the following example for network troubleshooting:

```bash
ping -c 1 192.168.1.1 > /dev/null || sudo ip route add 192.168.1.0/24 via 192.168.1.254
```

Here's what happens here:

- `ping -c 1 192.168.1.1 > /dev/null` sends a single ICMP echo request (`-c 1`) to the IP address `192.168.1.1` and redirects the output to `/dev/null` to suppress it.
- If the `ping` command fails (i.e., the host is unreachable), the `ip route add` command will be executed.
- `sudo ip route add 192.168.1.0/24 via 192.168.1.254` adds a route to the network `192.168.1.0/24` through the gateway `192.168.1.254`. Note: Adding routes typically requires root privileges, which is why `sudo` is used.

This example ensures that if the host at `192.168.1.1` is unreachable, an alternative route is added to try to restore network connectivity.

## Potential Pitfalls and When Not to Use ||

While the `||` operator is powerful, there are scenarios where its use might not be appropriate:

1. **Overuse Leading to Complexity**: Chaining multiple `||` operators can make scripts harder to read and maintain. It's essential to use them judiciously to maintain clarity.
2. **Ignoring Specific Errors**: Using `||` blindly might mask specific errors that should be handled differently. It's often better to handle different error cases explicitly.
3. **Race Conditions**: In some cases, especially in multi-threaded environments or when dealing with external resources, relying solely on `||` can introduce race conditions where the state changes between the check and the execution of the fallback command.
4. **Non-idempotent Commands**: If the command after `||` is not idempotent (i.e., it changes the system state in a way that cannot be repeated safely), using `||` might lead to unintended consequences if the fallback command is triggered multiple times.

## Reviewing Using the Double Pipe in Bash

The double pipe (`||`) in Bash scripting is a powerful tool for ensuring reliable script execution. By using `||`, you can specify an alternative command to run if the initial command fails, making your scripts more resilient to errors and interruptions.

Throughout this blog, we've seen several practical uses of `||`:

1. **Creating a Directory if It Does Not Exis**t - Ensuring necessary directories are available for subsequent operations.
2. **Creating a Backup if a File Does Not Exist** - Restoring a missing file to maintain data integrity.
3. **Restarting a Service if It is Not Running** - Automatically keeping critical services active.
4. **Pinging a Host and Adding a Route if Unreachable** - Maintaining network connectivity by adding routes as needed.

### Best Practices

- **Understand Exit Statuses**: Grasping how exit statuses work is crucial for effectively using `||`.
- **Use with Caution**: Be mindful of potential pitfalls and avoid overcomplicating scripts.
- **Require Necessary Permissions**: Ensure that commands requiring elevated privileges (like adding routes) are executed with the appropriate permissions, using tools like `sudo` when necessary.

Using `||` effectively can help you manage scenarios where commands might fail, allowing your scripts to continue running smoothly and making them more reliable overall.
