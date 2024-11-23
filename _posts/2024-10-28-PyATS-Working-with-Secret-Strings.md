---
title: "pyATS - Working with PyATS Secret Strings"
author: "Barry Weiss"
layout: "post"
tags:
  - "Python"
  - "pyATS"
---

## Overview
PyATS provides a secure way to handle sensitive information like passwords and credentials in your `testbed.yaml` files using "secret strings" encryption. This feature prevents exposure of sensitive data even if the testbed file is accidentally shared or accessed by unauthorized users.

## Prerequisites
1. PyATS installed in your environment.
2. The cryptography package:

    ```bash
    pip install cryptography
    ```

## PyATS Configuration File Locations

pyATS allows you to set various component/feature configurations and defaults in a standard INI-style config file.

PyATS uses a hierarchical configuration system, checking multiple locations for configuration files. Files loaded later override settings from earlier files:

- On Linux/macOS, the default server-wide configuration file is `/etc/pyats.conf`.

- Inside a virtual environment, the file is `$VIRTUAL_ENV/pyats.conf`.

- The per-user configuration file is `$HOME/.pyats/pyats.conf`.

- Setting environment variable export `PYATS_CONFIGURATION=path/to/pyats.conf`.

- The CLI argument `--pyats-configuration` can be used to specify a configuration file.

If multiple configuration files are found, then they are combined in the following order:

1. The server-wide file is read.
2. The virtual environment–specific file is read.
3. The per-user file is read.
4. The file specified by the environment variable `PYATS_CONFIGURATION` is read.
5. The file specified by the CLI argument `–pyats-configuration` is read.


### Project-Specific Configuration
Recommended project structure:
```
your_project/
├── pyats.conf          # Project-specific configuration (gitignored)
├── pyats.conf.template # Template for configuration (version controlled)
├── testbed.yaml        # Your testbed file
├── tests/
└── .gitignore         # Include pyats.conf here
```

Example `pyats.conf.template`:
```ini
[secrets]
string.representer = pyats.utils.secret_strings.FernetSecretStringRepresenter
string.key = REPLACE_WITH_YOUR_KEY
```

Example `.gitignore` entry:
```
# PyATS configuration
pyats.conf
```

## Basic Setup Process

### 1. Initial Configuration
Create your PyATS configuration file in your preferred location (system, user, or project directory):

```ini
[secrets]
string.representer = pyats.utils.secret_strings.FernetSecretStringRepresenter
```

### 2. Generate Encryption Key
Generate a cryptographic key using the PyATS CLI:

```bash
pyats secret keygen
```

This will output something like:
```
The following is a newly generated key:
dSvoKX23jKQADn20INt3W3B5ogUQmh6Pq00czddHtgU=
```

### 3. Update Configuration with Key
Add the generated key to your chosen pyats.conf:

```ini
[secrets]
string.representer = pyats.utils.secret_strings.FernetSecretStringRepresenter
string.key = dSvoKX23jKQADn20INt3W3B5ogUQmh6Pq00czddHtgU=
```

### 4. Secure the Configuration
Restrict permissions on your configuration file:

```bash
chmod 600 pyats.conf
```

## Managing Multiple Environments

### Development vs Production
For different environments, you can:

1. Use environment-specific project configurations:
```
your_project/
├── config/
│   ├── pyats.conf.dev
│   ├── pyats.conf.prod
│   └── pyats.conf.template
├── tests/
└── testbed.yaml
```

2. Use environment variables to switch configurations:
```bash
# Development
export PYATS_CONFIGURATION=/path/to/project/config/pyats.conf.dev

# Production
export PYATS_CONFIGURATION=/path/to/project/config/pyats.conf.prod
```

### CI/CD Integration
For CI/CD pipelines:
1. Store your encryption key securely in your CI/CD system's secrets management
2. Generate the pyats.conf dynamically during pipeline execution:

```bash
# Example CI/CD script
echo "[secrets]" > pyats.conf
echo "string.representer = pyats.utils.secret_strings.FernetSecretStringRepresenter" >> pyats.conf
echo "string.key = $PYATS_SECRET_KEY" >> pyats.conf
```

## Working with Encrypted Strings

### Encoding Passwords
You have two options for encoding passwords:

1. Interactive mode:
```bash
pyats secret encode
Password: MySecretPassword
```

2. Direct string mode:
```bash
pyats secret encode --string MySecretPassword
```

Both methods will output an encoded string like:
```
gAAAAABdsgvwElU9_3RTZsRnd4b1l3Es2gV6Y_DUnUE8C9y3SdZGBc2v0B2m9sKVz80jyeYhlWKMDwtqfwlbg4sQ2Y0a843luOrZyyOuCgZ7bxE5X3Dk_NY=
```

###
