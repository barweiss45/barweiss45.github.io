---
title: "Linux - Verifying GPG Keys and Displaying Public Key Information"
author: "Barry Weiss"
layout: "post"
tags:
  - "Linux"
  - "Security"
---


This guide provides a script that verifies GPG keys stored in `/usr/share/keyrings/`, showing detailed information, including expiration dates, key capabilities, and the full public key block. By the end, you will be able to view each `.gpg` file’s public key details, understand its expiration dates, and check its intended usage.

### Updated Script to Verify GPG Keys and Display Public Key

```bash
#!/bin/bash

# List all GPG files in the /usr/share/keyrings directory
ls -1 /usr/share/keyrings/*.gpg | while read -r file; do
  echo "File: $file"

  # Display public key information with expiration dates and key usage capabilities
  gpg --show-keys "$file" 2>/dev/null | grep -E 'pub|exp' | awk '
  /pub/ {
    # Print public key info
    print "Public Key Info:", $0
  }
  /exp/ {
    # Print expiration date
    print "Expiration Date:", $NF
  }'

  # Show the full public key block
  echo "Public Key Block:"
  gpg --show-keys "$file" 2>/dev/null

  echo "---------------------"
done
```

## How the Script Works

1. **List the GPG Files**: The script uses `ls -1` to list all GPG keyring files in the `/usr/share/keyrings/` directory.
2. **Public Key Information**: It extracts key information using `gpg --show-keys` and filters the lines to show the public key (`pub`) and expiration date (`exp`). The information includes the key type (e.g., RSA 4096), creation date, and capabilities (e.g., `[SC]`, `[SCEA]`).
3. **Expiration Date**: The expiration date is printed if the key has one.
4. **Full Public Key Block**: The script outputs the full public key block using `gpg --show-keys` so you can view the actual public key data.

## Example Output

Let’s look at an example output to understand the data provided:

```bash
File: /usr/share/keyrings/githubcli-archive-keyring.gpg
Public Key Info: pub   rsa4096 2022-09-06 [SC] [expires: 2026-09-05]
Expiration Date: 2026-09-05
Public Key Block:
pub   rsa4096 2022-09-06 [SC] [expires: 2026-09-05]
      0F3E 97D6 3A0A 90B4 A8E1  7B68 5B53 C6B4 1234 5678
uid           [ unknown] GitHub CLI <noreply@github.com>
sub   rsa4096 2022-09-06 [E] [expires: 2026-09-05]

---------------------
File: /usr/share/keyrings/runner_gitlab-runner-archive-keyring.gpg
Public Key Info: pub   rsa4096 2020-03-02 [SC] [expires: 2026-02-27]
Expiration Date: 2026-02-27
Public Key Block:
pub   rsa4096 2020-03-02 [SC] [expires: 2026-02-27]
      AABB CCDD 1122 3344 5566  7788 99AA BBCC DDEE FF00
uid           [ unknown] GitLab Runner <support@gitlab.com>
sub   rsa4096 2020-03-02 [E] [expires: 2026-02-27]

---------------------
```

## Detailed Explanation of the Output

- **File**: Each `.gpg` file in `/usr/share/keyrings/` is listed, allowing you to know which key you are inspecting.

#### Public Key Information Section
- **Public Key Info**:
  - `pub   rsa4096 2022-09-06 [SC] [expires: 2026-09-05]`
    - `pub`: Denotes a public key.
    - `rsa4096`: Specifies the key's algorithm (RSA) and the key length (4096 bits).
    - `2022-09-06`: The date when the key was created.
    - `[SC]`: Key usage flags, which indicate what the key can be used for (more details below).
    - `[expires: 2026-09-05]`: The expiration date of the key.

#### Key Capabilities
The letters in brackets, such as `[SC]` or `[SCEA]`, indicate what the key is capable of doing:

- **S**: Sign — The key can sign data.
- **C**: Certify — The key can certify other keys, verifying their authenticity.
- **E**: Encrypt — The key can encrypt data.
- **A**: Authenticate — The key can authenticate (e.g., logging into systems).

For example:
- `[SC]` means the key can **Sign** and **Certify**.
- `[SCEA]` means the key can **Sign**, **Certify**, **Encrypt**, and **Authenticate**.

#### Expiration Date
- **Expiration Date**: The expiration date is shown as `Expiration Date: YYYY-MM-DD` if the key has one. For example, the GitHub CLI key expires on `2026-09-05`.

#### Public Key Block
- **Public Key Block**: This shows the actual public key in a standard ASCII-armored format:
  - `pub   rsa4096 2022-09-06 [SC] [expires: 2026-09-05]`: The public key info.
  - `0F3E 97D6 3A0A 90B4 A8E1  7B68 5B53 C6B4 1234 5678`: This is the key’s fingerprint, a unique identifier for the key.
  - `uid           [ unknown] GitHub CLI <noreply@github.com>`: The user identifier (UID) associated with the key.
  - `sub   rsa4096 2022-09-06 [E] [expires: 2026-09-05]`: A subkey used for encryption (`E`), which also has an expiration date.

Each key may have multiple subkeys, and the `uid` provides information about the entity that the key belongs to (e.g., GitHub CLI, GitLab Runner).

### Conclusion

This script provides a detailed view of each GPG key in the `/usr/share/keyrings/` directory, including public key information, expiration dates, key capabilities, and the full public key block. It’s useful for auditing, verifying key expiration, and checking the key’s intended usage to ensure it aligns with your security needs.
