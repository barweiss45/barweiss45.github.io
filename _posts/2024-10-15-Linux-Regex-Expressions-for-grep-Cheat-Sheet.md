---
title: "Linux - Common Regex Expressions for grep Cheat Sheet"
author: "Barry Weiss"
layout: "post"
tags:
  - "Linux"
  - "Regex"
  - "Cheat Sheet"
---

This introductory guide serves as a handy reference for common regular expressions (regex) you can use with the `grep` command. If you're just starting out or need a quick refresh, this cheat sheet will make it easy to get the hang of the essential regex patterns that go hand in hand with `grep`.

## Basic Patterns
- `.`: Matches any single character
  - Example: `grep "h.t" file.txt` matches "hat", "hot", "hit", etc.

- `^`: Matches the start of a line
  - Example: `grep "^The" file.txt` matches lines starting with "The"

- `$`: Matches the end of a line
  - Example: `grep "end$" file.txt` matches lines ending with "end"

- `*`: Matches zero or more occurrences of the previous character
  - Example: `grep "ca*t" file.txt` matches "ct", "cat", "caat", etc.

## Character Classes
- `[abc]`: Matches any single character in the set
  - Example: `grep "[aeiou]" file.txt` matches any vowel

- `[^abc]`: Matches any single character not in the set
  - Example: `grep "[^0-9]" file.txt` matches any non-digit

- `[a-z]`: Matches any single character in the range
  - Example: `grep "[A-Z]" file.txt` matches any uppercase letter

- `[a-zA-Z]`: Matches any lowercase or uppercase letter
  - Example: `grep "[a-zA-Z]" file.txt` matches any letter

Note: Character classes are case-sensitive unless used with the `-i` flag.

## Basic vs Extended Regular Expressions
- Use `grep -E` for extended features such as `+`, `?`, and `|`.
- For basic usage, use `grep` without the `-E` flag, though it has more limited regex capabilities.

## Extended Regex Features (use with grep -E)
- `+`: Matches one or more occurrences of the previous character
  - Example: `grep -E "ca+t" file.txt` matches "cat", "caat", but not "ct"

- `?`: Matches zero or one occurrence of the previous character
  - Example: `grep -E "colou?r" file.txt` matches both "color" and "colour"

- `|`: Alternation (OR)
  - Example: `grep -E "cat|dog" file.txt` matches lines containing either "cat" or "dog"

## Quantifiers
- `{n}`: Matches exactly n occurrences
  - Example: `grep -E "a{3}" file.txt` matches "aaa"

- `{n,}`: Matches n or more occurrences
  - Example: `grep -E "a{2,}" file.txt` matches "aa", "aaa", etc.

- `{n,m}`: Matches between n and m occurrences
  - Example: `grep -E "a{2,4}" file.txt` matches "aa", "aaa", "aaaa"

## Special Characters
- `\`: Escapes special characters
  - Example: `grep "\." file.txt` matches actual periods

- `\b`: Matches word boundaries
  - Example: `grep "\bthe\b" file.txt` matches "the" but not "there" or "other"

## Practical Examples
1. Find all IP addresses:
   ```
   grep -E "\b([0-9]{1,3}\.){3}[0-9]{1,3}\b" file.txt
   ```

2. Match email addresses:
   ```
   grep -E "[A-Za-z0-9._%+-]+@[A-Za-z0-9.-]+\.[A-Z|a-z]{2,}" file.txt
   ```

3. Find lines with dates (YYYY-MM-DD format):
   ```
   grep -E "^[0-9]{4}-[0-9]{2}-[0-9]{2}" file.txt
   ```

4. Match lines starting with "Error" or "Warning":
   ```
   grep -E "^(Error|Warning)" log.txt
   ```

5. Find words with at least eight characters:
   ```
   grep -E "\b[A-Za-z]{8,}\b" file.txt
   ```

6. Match lines that do not contain "Error" (inverse match):
   ```
   grep -v "Error" log.txt
   ```

7. Case-insensitive search for the word "hello":
   ```
   grep -i "hello" file.txt
   ```

## Backslash Characters
When using `grep -E` or `grep -P` (PCRE mode), the following backslash characters have special meanings:

- `\b`: Word boundary
  - Example: `grep -E "\bcat\b" file.txt` matches "cat" but not "category"

- `\B`: Non-word boundary
  - Example: `grep -E "\Bcat\B" file.txt` matches "cat" in "concatenate" but not "cat" alone

- `\d`: Any digit (equivalent to [0-9])
  - Example: `grep -E "\d{3}" file.txt` matches any three consecutive digits

- `\D`: Any non-digit (equivalent to [^0-9])
  - Example: `grep -E "\D+" file.txt` matches one or more non-digit characters

- `\s`: Any whitespace character (space, tab, newline)
  - Example: `grep -E "hello\sworld" file.txt` matches "hello world" with any whitespace between

- `\S`: Any non-whitespace character
  - Example: `grep -E "\S{5}" file.txt` matches any five consecutive non-whitespace characters

- `\w`: Any word character (alphanumeric + underscore, equivalent to [a-zA-Z0-9_])
  - Example: `grep -E "\w+" file.txt` matches one or more word characters

- `\W`: Any non-word character
  - Example: `grep -E "\W" file.txt` matches any single non-word character

- `\\`: Literal backslash
  - Example: `grep -E "\\" file.txt` matches a single backslash character

> ℹ️ **Note**: When using basic `grep` (without -E or -P), you may need to escape these special backslash characters with an additional backslash, like `\\s` or `\\d`.

### Practical Examples with Backslash Characters
1. Find words starting with "pre":
   ```
   grep -E "\bpre\w+" file.txt
   ```

2. Match phone numbers in format (xxx) xxx-xxxx:
   ```
   grep -E "\(\d{3}\)\s?\d{3}-\d{4}" file.txt
   ```

3. Find lines with exactly 3 words:
   ```
   grep -E "^\s*\S+\s+\S+\s+\S+\s*$" file.txt
   ```

4. Match email addresses using \w:
   ```
   grep -E "\b[\w.%+-]+@[\w.-]+\.[A-Za-z]{2,}\b" file.txt
   ```
