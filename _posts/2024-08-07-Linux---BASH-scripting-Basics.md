---
title: "Linux - Bash Scripting Basics"
layout: post
---

These notes cover essential concepts such as creating and structuring basic Bash scripts. It explains how to use variables and basic operators, and introduces conditional statements like if-else and comparison operators. It also delves into the use of loops, including for and while, for handling repetitive tasks. Additionally, the document covers how to define and use functions, including how to pass arguments, manage return values, and understand variable scope. Several practical examples are included, such as file management, file operations, and output processing tasks like factorial calculation, to illustrate the application of these concepts in real-world scripting.

- [Basic Concepts](#basic-concepts)
  - [Introduction to BASH Scripting](#introduction-to-bash-scripting)
    - [Basic Structure of a BASH Script](#basic-structure-of-a-bash-script)
    - [Creating a Simple Script](#creating-a-simple-script)
  - [Variables and Basic Operators](#variables-and-basic-operators)
    - [Variables](#variables)
    - [Basic Operators](#basic-operators)
  - [Conditional Statements](#conditional-statements)
    - [If-Else Statement](#if-else-statement)
    - [Comparison Operator](#comparison-operator)
  - [Loops](#loops)
    - [For Loop](#for-loop)
    - [While Loop](#while-loop)
  - [Practical Example: File Management](#practical-example-file-management)
- [Functions in a BASH script](#functions-in-a-bash-script)
  - [Basics of Functions in BASH](#basics-of-functions-in-bash)
    - [Defining a Function](#defining-a-function)
    - [Calling a Function](#calling-a-function)
  - [Example of a Simple Function](#example-of-a-simple-function)
  - [Returning Values from Functions](#returning-values-from-functions)
    - [Using `echo` for Output](#using-echo-for-output)
    - [Using `return` for Status Codes](#using-return-for-status-codes)
  - [Scope of Variables in Functions](#scope-of-variables-in-functions)
  - [Functions with Arguments and Default Values](#functions-with-arguments-and-default-values)
    - [Default Values for Arguments](#default-values-for-arguments)
    - [Full Example of a Function with Arguments and Default values](#full-example-of-a-function-with-arguments-and-default-values)
  - [Practical Example: File Operations](#practical-example-file-operations)
  - [Practical Example: Processing Output](#practical-example-processing-output)
    - [Factorial Calculation and Decision Making](#factorial-calculation-and-decision-making)
  - [Practical Example: Output in Complex Scripts](#practical-example-output-in-complex-scripts)
    - [Data Validation and Processing](#data-validation-and-processing)
- [If-Else Statement Conditionals](#if-else-statement-conditionals)
  - [Comparison Operators for Numbers](#comparison-operators-for-numbers)
  - [String Comparison Operators](#string-comparison-operators)
  - [File Test Operators](#file-test-operators)
  - [Logical Operators](#logical-operators)
  - [Arithmetic Comparison with `(( ... ))`](#arithmetic-comparison-with---)
  - [String Pattern Matching with `[[ ... ]]`](#string-pattern-matching-with---)
  - [Combining Conditions](#combining-conditions)
- [Grep Command](#grep-command)
  - [Basic Syntax and Usage](#basic-syntax-and-usage)
  - [Simple Search](#simple-search)
    - [Search for a Word](#search-for-a-word)
  - [Using Regular Expressions](#using-regular-expressions)
    - [Search for a Pattern](#search-for-a-pattern)
  - [Case Sensitivity](#case-sensitivity)
    - [Case-Insensitive Search](#case-insensitive-search)
  - [Counting Matches](#counting-matches)
    - [Count Matching Lines](#count-matching-lines)
  - [Displaying Line Numbers](#displaying-line-numbers)
    - [Show Line Numbers](#show-line-numbers)
  - [Inverting Matches](#inverting-matches)
    - [Example 6: Invert Match](#example-6-invert-match)
  - [Matching Whole Words](#matching-whole-words)
    - [Match Whole Words](#match-whole-words)
  - [Matching Lines Exactly](#matching-lines-exactly)
    - [Exact Line Match](#exact-line-match)
  - [Recursive Search](#recursive-search)
  - [Displaying Only Filenames](#displaying-only-filenames)
    - [Show Filenames Only](#show-filenames-only)
  - [Context Lines](#context-lines)
  - [Extended Regular Expressions](#extended-regular-expressions)
    - [Extended Regex](#extended-regex)
  - [Grep with Pipes](#grep-with-pipes)
    - [Using Pipes](#using-pipes)
  - [Suppressing Errors](#suppressing-errors)
    - [Suppress Errors](#suppress-errors)
  - [Practical Examples](#practical-examples)
    - [Searching Logs for Errors](#searching-logs-for-errors)
    - [Counting TODO Comments in Code](#counting-todo-comments-in-code)
  - [Practical Example: Check for a Regular File](#practical-example-check-for-a-regular-file)
- [Awk command](#awk-command)
  - [Basic Syntax and Usage for `awk`](#basic-syntax-and-usage-for-awk)
    - [Print Specific Columns](#print-specific-columns)
    - [Print Lines Matching a Pattern](#print-lines-matching-a-pattern)
  - [Field Separator](#field-separator)
    - [Custom Field Separator](#custom-field-separator)
  - [Built-in Variables](#built-in-variables)
    - [Print Line Number and Content](#print-line-number-and-content)
  - [Arithmetic Operations](#arithmetic-operations)
    - [Sum a Column](#sum-a-column)
  - [Advanced Pattern Matching](#advanced-pattern-matching)
    - [Lines Containing a Specific String](#lines-containing-a-specific-string)
    - [Start and End Pattern Matching](#start-and-end-pattern-matching)
  - [User-defined Functions and External Commands](#user-defined-functions-and-external-commands)
    - [External Command](#external-command)
  - [Writing to Files](#writing-to-files)
    - [Redirect Output](#redirect-output)
  - [BEGIN and END Blocks](#begin-and-end-blocks)
  - [Regular Expressions in `awk`](#regular-expressions-in-awk)
  - [Basic Regex Syntax in `awk`](#basic-regex-syntax-in-awk)
  - [Finding Patterns](#finding-patterns)
    - [Matching Lines Containing a Specific Word\*\*](#matching-lines-containing-a-specific-word)
    - [Matching Lines Starting with a Specific Word](#matching-lines-starting-with-a-specific-word)
    - [Matching Lines Ending with a Specific Word\*\*](#matching-lines-ending-with-a-specific-word)
    - [Matching Lines with a Specific Pattern](#matching-lines-with-a-specific-pattern)
  - [Using Regex for Field Matching](#using-regex-for-field-matching)
    - [Example 5: Matching a Pattern in a Specific Column](#example-5-matching-a-pattern-in-a-specific-column)
  - [Using Regex in BEGIN and END Blocks](#using-regex-in-begin-and-end-blocks)
    - [Counting Lines Matching a Pattern\*\*](#counting-lines-matching-a-pattern)
  - [Inverting Matches](#inverting-matches-1)
    - [Excluding Lines Matching a Pattern](#excluding-lines-matching-a-pattern)
  - [Combining Patterns and Actions](#combining-patterns-and-actions)
    - [Extracting and Modifying Data](#extracting-and-modifying-data)
    - [Substituting Text](#substituting-text)
  - [Advanced Regex Features](#advanced-regex-features)
    - [Using Backreferences](#using-backreferences)
  - [Practical Example: Log File Analysis](#practical-example-log-file-analysis)
  - [Case-Insensitive Matching](#case-insensitive-matching)
  - [Combining Conditions and Patterns](#combining-conditions-and-patterns)
    - [Complex Condition](#complex-condition)
- [Parsing output from Commands with `awk`](#parsing-output-from-commands-with-awk)
  - [Parsing `ls` Output with `awk`](#parsing-ls-output-with-awk)
    - [Extracting Filenames](#extracting-filenames)
    - [Extracting File Sizes](#extracting-file-sizes)
    - [Total Size of Files](#total-size-of-files)
  - [Parsing `grep` Output with `awk`](#parsing-grep-output-with-awk)
    - [Extracting Line Numbers](#extracting-line-numbers)
    - [Counting Matching Lines](#counting-matching-lines)
  - [Combining Commands with Awk](#combining-commands-with-awk)
    - [Files Larger Than a Certain Size](#files-larger-than-a-certain-size)
    - [Find and Extract Specific Information](#find-and-extract-specific-information)
    - [Practical Example: Disk Usage Analysis](#practical-example-disk-usage-analysis)
  - [Using Variables and Functions with `awk`](#using-variables-and-functions-with-awk)
    - [Using Variables](#using-variables)
    - [Using Functions](#using-functions)
- [Sed Command](#sed-command)
  - [Basic Syntax and Usage of `sed`](#basic-syntax-and-usage-of-sed)
  - [Basic Substitution](#basic-substitution)
    - [Substituting Text](#substituting-text-1)
    - [Global Substitution](#global-substitution)
  - [Using `-i` with a Backup Suffix and In-place Editing](#using--i-with-a-backup-suffix-and-in-place-editing)
    - [In-place Editing](#in-place-editing)
    - [About Automatic Backup](#about-automatic-backup)
    - [Example: Backup Before Substitution](#example-backup-before-substitution)
    - [Specifying a Custom Backup Suffix](#specifying-a-custom-backup-suffix)
    - [Example: Custom Suffix](#example-custom-suffix)
    - [No Backup Suffix (Overwrites Original)](#no-backup-suffix-overwrites-original)
    - [Example: No Backup](#example-no-backup)
    - [Example: macOS Syntax](#example-macos-syntax)
  - [Addressing Lines](#addressing-lines)
    - [Substitution on a Specific Line\*\*](#substitution-on-a-specific-line)
    - [Substitution in a Range of Lines](#substitution-in-a-range-of-lines)
    - [Substitution Using a Pattern](#substitution-using-a-pattern)
  - [Deleting Lines](#deleting-lines)
    - [Delete a Specific Line](#delete-a-specific-line)
    - [Delete Lines Matching a Pattern](#delete-lines-matching-a-pattern)
  - [Inserting and Appending Text](#inserting-and-appending-text)
    - [Insert Text Before a Line](#insert-text-before-a-line)
    - [Append Text After a Line](#append-text-after-a-line)
  - [Changing Lines](#changing-lines)
    - [Example 10: Replace a Line](#example-10-replace-a-line)
  - [Advanced Regular Expressions with `sed`](#advanced-regular-expressions-with-sed)
    - [Matching and Substitution with Regex](#matching-and-substitution-with-regex)
    - [Grouping and Referencing](#grouping-and-referencing)
    - [Using Extended Regex](#using-extended-regex)
  - [Multi-line and Contextual Operations](#multi-line-and-contextual-operations)
    - [Multi-line Matching](#multi-line-matching)
    - [Contextual Deletion](#contextual-deletion)
  - [Replacing a Chunk of Lines with Sed](#replacing-a-chunk-of-lines-with-sed)
    - [Example: Replace Lines from Line 2 to Line 4](#example-replace-lines-from-line-2-to-line-4)
  - [Using a Variable for the Replacement Content](#using-a-variable-for-the-replacement-content)
    - [Example: Using a Shell Variable](#example-using-a-shell-variable)
  - [Complex Example Multiline Replacement with Dynamic Content](#complex-example-multiline-replacement-with-dynamic-content)
    - [Example: Replacing with Dynamic Content](#example-replacing-with-dynamic-content)
  - [Handling Special Characters In multiline replacement](#handling-special-characters-in-multiline-replacement)
    - [Example: Handling Slashes](#example-handling-slashes)
    - [Summary of multi-line substitution](#summary-of-multi-line-substitution)
  - [Using Sed Scripts](#using-sed-scripts)
  - [Practical Example: Extracting IP Addresses](#practical-example-extracting-ip-addresses)
- [Read command](#read-command)
  - [Basic Usage of `read`](#basic-usage-of-read)
  - [Reading Multiple Values](#reading-multiple-values)
  - [Using `read` with Options](#using-read-with-options)
    - [Prompt Option (-p)](#prompt-option--p)
    - [Silent Option (-s)](#silent-option--s)
    - [Character Limit Option (-n)](#character-limit-option--n)
    - [Timeout Option (-t)](#timeout-option--t)
  - [Reading a Line into an Array](#reading-a-line-into-an-array)
  - [Reading from a File](#reading-from-a-file)
  - [Introduction to Functions with `read`](#introduction-to-functions-with-read)
  - [Basic Function with `read`](#basic-function-with-read)
  - [Using `read` with Options in Functions](#using-read-with-options-in-functions)
    - [Example: Function with Prompt and Silent Mode](#example-function-with-prompt-and-silent-mode)
  - [Using `read` for Multiple Inputs in Functions](#using-read-for-multiple-inputs-in-functions)
    - [Example: Function to Collect User Details](#example-function-to-collect-user-details)
  - [Using `read` with Arrays in Functions](#using-read-with-arrays-in-functions)
    - [Example: Reading Multiple Words into an Array](#example-reading-multiple-words-into-an-array)
  - [Practical Example: Function with User Input Validation](#practical-example-function-with-user-input-validation)
    - [Example: Validate Age Input](#example-validate-age-input)
- [Case command](#case-command)
  - [Basic Syntax of `case` Statement](#basic-syntax-of-case-statement)
    - [Example with Explanation](#example-with-explanation)
  - [Use Cases for `case` Statement](#use-cases-for-case-statement)
  - [Advantages of Using `case`](#advantages-of-using-case)
  - [Practical Example: Menu Selection Script](#practical-example-menu-selection-script)
- [Redirects and stdout `>&1` and stderr `>&2`](#redirects-and-stdout-1-and-stderr-2)
  - [Standard Streams](#standard-streams)
  - [Basic Redirection Operators](#basic-redirection-operators)
  - [Redirecting stderr and stdout](#redirecting-stderr-and-stdout)
  - [File Descriptor Manipulation](#file-descriptor-manipulation)
    - [Examples and Explanation](#examples-and-explanation)
  - [Advanced Redirection Techniques](#advanced-redirection-techniques)
  - [Practical Applications](#practical-applications)
- [Logging in a BASH script](#logging-in-a-bash-script)
  - [Appending to a Log File with `>>`](#appending-to-a-log-file-with-)
  - [Practical Example: Logging Script Output](#practical-example-logging-script-output)
  - [**Benefits of Using `>>` for Logging**](#benefits-of-using--for-logging)

## Basic Concepts

### Introduction to BASH Scripting

BASH (Bourne Again SHell) is a command language interpreter for the GNU operating system. It's commonly used for automating tasks in Unix-like systems.

#### Basic Structure of a BASH Script

1. **Shebang (`#!`)**: The first line of a BASH script typically starts with `#!/bin/bash`, which tells the system to use the BASH interpreter.

2. **Comments**: Lines starting with `#` are comments and are ignored by the interpreter.

3. **Commands**: These are the actual shell commands or instructions you want to run.

#### Creating a Simple Script

1. **Open a Text Editor**: Use any text editor like `nano`, `vim`, or `gedit`.

2. **Write a Script**: Let's write a simple script to display "Hello, World!"

    ```bash
    #!/bin/bash
    # This is a simple script
    echo "Hello, World!"
    ```

3. **Save and Exit**: Save the file with a `.sh` extension, for example, `hello_world.sh`.

4. **Make the Script Executable**: Use the `chmod` command to make the script executable.

    ```bash
    chmod +x hello_world.sh
    ```

5. **Run the Script**: You can run the script using `./` followed by the script name.

    ```bash
    ./hello_world.sh
    ```

### Variables and Basic Operators

#### Variables

- **Defining Variables**: No spaces are allowed around the `=` sign.

    ```bash
    #!/bin/bash
    name="Barry"
    echo "Hello, $name!"
    ```

- **Reading User Input**: You can prompt the user for input using `read`.

    ```bash
    #!/bin/bash
    echo "Enter your name:"
    read name
    echo "Hello, $name!"
    ```

#### Basic Operators

- **Arithmetic Operations**: Use `expr` or `$(( ))` for arithmetic.

    ```bash
    #!/bin/bash
    a=5
    b=3
    sum=$((a + b))
    echo "Sum: $sum"
    ```

### Conditional Statements

See section [If-Else Statement Conditionals](#if-else-statement-conditionals) for more details.

#### If-Else Statement

```bash
#!/bin/bash
echo "Enter a number:"
read num

if [ $num -gt 10 ]; then
  echo "Number is greater than 10"
else
  echo "Number is 10 or less"
fi
```

#### Comparison Operator

- `-eq`: equal to
- `-ne`: not equal to
- `-gt`: greater than
- `-lt`: less than
- `-ge`: greater than or equal to
- `-le`: less than or equal to

### Loops

#### For Loop

```bash
#!/bin/bash
for i in 1 2 3 4 5
do
  echo "Number: $i"
done
```

#### While Loop

```bash
#!/bin/bash
count=1
while [ $count -le 5 ]
do
  echo "Count: $count"
  count=$((count + 1))
done
```

### Practical Example: File Management

This a script to back up a directory.

```bash
#!/bin/bash
# Backup script

source_dir="/path/to/source"
backup_dir="/path/to/backup"

if [ -d "$source_dir" ]; then
  echo "Backing up $source_dir to $backup_dir"
  cp -r $source_dir $backup_dir
  echo "Backup complete!"
else
  echo "Source directory does not exist."
fi
```

This script checks if the source directory exists and then copies it to the backup directory.

---

## Functions in a BASH script

Functions in BASH scripting allow you to encapsulate a set of commands into a reusable block of code, making your scripts more modular and manageable.

### Basics of Functions in BASH

#### Defining a Function

The syntax for defining a function in BASH is as follows:

```bash
function_name() {
    # commands
}
```

Or, alternatively:

```bash
function function_name {
    # commands
}
```

#### Calling a Function

To call a function, simply use its name:

```bash
function_name
```

### Example of a Simple Function

Let's create a simple function that prints a greeting.

```bash
#!/bin/bash

greet() {
    echo "Hello, $1!"
}

greet "Barry"
```

In this example, the function `greet` takes one argument (`$1`) and prints a greeting message. When calling the function, we pass "Barry" as the argument.

### Returning Values from Functions

⚠️ **BASH functions don't return values like functions in some other programming languages.** Instead, they use the `return` command to indicate success or failure and return data via output or by setting a global variable.

#### Using `echo` for Output

You can use `echo` to output data from a function:

```bash
#!/bin/bash

add() {
    local sum=$(( $1 + $2 ))
    echo $sum
}

result=$(add 5 3)
echo "Result: $result"
```

In this example, the function `add` takes two arguments, adds them, and outputs the sum. The output is captured using the command substitution `$(...)` and stored in the variable `result`.

#### Using `return` for Status Codes

The `return` command can be used to indicate success (`0`) or failure (non-zero value).

```bash
#!/bin/bash

is_even() {
    if [ $(( $1 % 2 )) -eq 0 ]; then
        return 0
    else
        return 1
    fi
}

is_even 4
if [ $? -eq 0 ]; then
    echo "Number is even."
else
    echo "Number is odd."
fi
```

Here, the function `is_even` checks if a number is even and returns `0` if it is, or `1` if it isn't. The special variable `$?` captures the return status of the last executed command, allowing us to check the function's result.

### Scope of Variables in Functions

Variables declared inside a function are by default global, meaning they can be accessed outside the function. To restrict a variable's scope to the function, use the `local` keyword.

```bash
#!/bin/bash

global_var="I am global"

print_var() {
    local local_var="I am local"
    echo $global_var
    echo $local_var
}

print_var

echo $global_var
echo $local_var  # This will result in an empty line
```

In this example, `local_var` is only accessible within the function `print_var`, while `global_var` is accessible throughout the script.

### Functions with Arguments and Default Values

In BASH, functions can accept arguments, similar to how scripts can accept command-line arguments. Inside the function, these arguments are accessible using special positional parameters like `$1`, `$2`, etc., where `$1` represents the first argument, `$2` the second, and so on.

**Example:**

```bash
#!/bin/bash

greet() {
    local name=$1  # $1 is the first argument passed to the function
    echo "Hello, $name!"
}

greet "Barry"  # Calls the function with "Barry" as the argument
```

In this example:

- The `greet` function takes one argument, which is stored in the variable `name`.
- `local` is used to declare `name` as a local variable, meaning its value is confined to the function's scope.
- The function is then called with the argument "Barry", so `name` becomes "Barry", and the function prints "Hello, Barry!".

#### Default Values for Arguments

Sometimes you want a function to have default behavior even if certain arguments are not provided. In BASH, you can set default values for function arguments using parameter expansion.

**Syntax for Default Values:**

- `${parameter:-default_value}`: If `parameter` is not set or is null, use `default_value`.

**Example with Default Values:**

```bash
#!/bin/bash

greet() {
    local name=${1:-Guest}  # If $1 is empty, default to "Guest"
    echo "Hello, $name!"
}

greet "Barry"  # Calls the function with "Barry" as the argument
greet          # Calls the function without an argument
```

In this example:

- `${1:-Guest}` is used to set the variable `name`. If the first argument `$1` is provided, `name` is set to `$1`. If no argument is provided, `name` defaults to "Guest".
- When `greet "Barry"` is called, `name` is set to "Barry", and the function prints "Hello, Barry!".
- When `greet` is called without an argument, `name` defaults to "Guest", and the function prints "Hello, Guest!".

**Why Use Default Values?**

Using default values is helpful for:

- Providing a fallback when no argument is given.
- Simplifying function calls by not requiring every argument to be specified.
- Enhancing the function's robustness and usability.

#### Full Example of a Function with Arguments and Default values

```bash
#!/bin/bash

greet() {
    local name=${1:-Guest}  # Set name to $1 if provided, otherwise default to "Guest"
    echo "Hello, $name!"
}

greet "Barry"  # Output: Hello, Barry!
greet          # Output: Hello, Guest!
```

**Explanation:**

1. **Function Definition (`greet`)**:
   - `local name=${1:-Guest}`: Declares a local variable `name`. It uses `${1:-Guest}` to set `name` to the first argument (`$1`) if provided, or "Guest" if not.
2. **Function Calls**:
   - `greet "Barry"`: Passes "Barry" as the first argument. `name` becomes "Barry", so the output is "Hello, Barry!".
   - `greet`: No argument is passed, so `name` defaults to "Guest". The output is "Hello, Guest!".

This mechanism allows for flexible and safe handling of function arguments, making your BASH scripts more user-friendly and error-resistant.

### Practical Example: File Operations

This is a function that checks if a file exists and is readable:

```bash
#!/bin/bash

check_file() {
    if [ -r "$1" ]; then
        echo "File '$1' exists and is readable."
    else
        echo "File '$1' either does not exist or is not readable."
    fi
}

check_file "/path/to/file.txt"
```

This script defines a function `check_file` that takes a file path as an argument and checks if the file exists and is readable.

### Practical Example: Processing Output

#### Factorial Calculation and Decision Making

A more practical example is where a function processes some data and the result is used for further action. We'll create a function that calculates the factorial of a number and then use that result to determine if the number is large or small.

```bash
#!/bin/bash

# Function to calculate factorial
calculate_factorial() {
    local number=$1
    local factorial=1
    for (( i=1; i<=number; i++ ))
    do
        factorial=$((factorial * i))
    done
    echo $factorial
}

# Capture the output of the function
number=5
factorial_result=$(calculate_factorial $number)

# Use the captured output to make a decision
echo "The factorial of $number is $factorial_result"

if [ $factorial_result -ge 120 ]; then
    echo "That's a big number!"
else
    echo "That's a manageable number."
fi
```

**In this example:**

- The calculate_factorial function computes the factorial of a given number and echoes the result.
- The script captures the factorial result using `factorial_result=$(calculate_factorial $number)`.
- The captured result is then used to determine if the number is considered "big" or "manageable" based on a threshold (120 in this case).

### Practical Example: Output in Complex Scripts

#### Data Validation and Processing

For more complex scripts, you might have multiple functions and need to pass data between them. Let's look at an example where we have two functions: one for data validation and another for data processing.

```bash
#!/bin/bash

# Function to validate an email address
validate_email() {
    local email=$1
    if [[ $email =~ ^[a-zA-Z0-9._%+-]+@[a-zA-Z0-9.-]+\.[a-zA-Z]{2,4}$ ]]; then
        echo "valid"
    else
        echo "invalid"
    fi
}

# Function to process valid emails
process_email() {
    local email=$1
    # Simulate email processing
    echo "Processing email: $email"
}

# Main script
read -p "Enter your email: " user_email

# Validate the email
validation_result=$(validate_email $user_email)

if [ "$validation_result" == "valid" ]; then
    process_email $user_email
else
    echo "Invalid email address. Please try again."
fi
```

**In this script:**

- The `validate_email` function checks if the provided email address matches a regular expression for a valid email format. It echoes "valid" or "invalid" based on the validation.
- The `process_email` function simulates processing a valid email.
- The main script captures the validation result using `validation_result=$(validate_email $user_email)`.
- Depending on the validation result, the script either processes the email or asks the user to try again.

---

## If-Else Statement Conditionals

In BASH scripting, `if` statements are used to perform conditional checks. There are various operators you can use with `if` statements to compare numbers, strings, and files. Here's a list of common operators and examples of how to use them:

### Comparison Operators for Numbers

- `-eq`: Equal to
- `-ne`: Not equal to
- `-lt`: Less than
- `-le`: Less than or equal to
- `-gt`: Greater than
- `-ge`: Greater than or equal to

**Example:**

```bash
#!/usr/bin/bash

num1=10
num2=20

if [ $num1 -eq $num2 ]; then
    echo "Numbers are equal"
elif [ $num1 -ne $num2 ]; then
    echo "Numbers are not equal"
fi

if [ $num1 -lt $num2 ]; then
    echo "$num1 is less than $num2"
fi
```

### String Comparison Operators

- `=`: Equal to
- `!=`: Not equal to
- `-z`: String is null (zero length)
- `-n`: String is not null (non-zero length)

**Example:**

```bash
#!/usr/bin/bash

str1="hello"
str2="world"

if [ "$str1" = "$str2" ]; then
    echo "Strings are equal"
else
    echo "Strings are not equal"
fi

if [ -z "$str1" ]; then
    echo "String is empty"
else
    echo "String is not empty"
fi
```

### File Test Operators

- `-e`: File exists
- `-f`: File is a regular file (not a directory or device)
- `-d`: File is a directory
- `-r`: File is readable
- `-w`: File is writable
- `-x`: File is executable
- `-s`: File is not empty

**Example:**

```bash
#!/usr/bin/bash

file="myfile.txt"
dir="mydir"

if [ -e "$file" ]; then
    echo "File exists"
fi

if [ -d "$dir" ]; then
    echo "Directory exists"
fi

if [ -r "$file" ]; then
    echo "File is readable"
fi

if [ -s "$file" ]; then
    echo "File is not empty"
fi
```

### Logical Operators

- `&&`: Logical AND
- `||`: Logical OR
- `!`: Logical NOT

**Example:**

```bash
#!/usr/bin/bash

var1=5
var2=10

if [ $var1 -lt $var2 ] && [ $var1 -gt 0 ]; then
    echo "$var1 is less than $var2 and greater than 0"
fi

if [ $var1 -lt 0 ] || [ $var2 -gt 5 ]; then
    echo "Either $var1 is less than 0 or $var2 is greater than 5"
fi

if [ ! -e "nonexistentfile.txt" ]; then
    echo "File does not exist"
fi
```

### Arithmetic Comparison with `(( ... ))`

You can use the `(( ... ))` syntax for arithmetic comparisons, which allows for simpler syntax and supports C-style operators.

**Example:**

```bash
#!/usr/bin/bash

num1=10
num2=20

if (( num1 == num2 )); then
    echo "Numbers are equal"
else
    echo "Numbers are not equal"
fi

if (( num1 < num2 )); then
    echo "$num1 is less than $num2"
fi
```

### String Pattern Matching with `[[ ... ]]`

The `[[ ... ]]` syntax allows for pattern matching with `=~`.

**Example:**

```bash
#!/usr/bin/bash

str="hello123"

if [[ $str =~ ^hello ]]; then
    echo "String starts with 'hello'"
fi

if [[ $str =~ [0-9]+ ]]; then
    echo "String contains numbers"
fi
```

### Combining Conditions

You can combine conditions using logical operators `&&` (AND), `||` (OR), and `!` (NOT).

**Example:**

```bash
#!/usr/bin/bash

num1=10
num2=20
str="example"

if [ $num1 -lt $num2 ] && [ "$str" = "example" ]; then
    echo "Both conditions are true"
fi
```

These operators and constructs are essential for controlling the flow of your script and performing checks based on the script's logic. Understanding and using these operators effectively will help you write more robust and flexible BASH scripts.

---

## Grep Command

`grep`, is a powerful command-line utility used for searching and filtering text. `grep` stands for "Global Regular Expression Print," and it is widely used in Unix/Linux environments for pattern matching and text processing.

### Basic Syntax and Usage

The basic syntax for `grep` is:

```bash
grep [options] pattern [file...]
```

- **`pattern`**: The string or regular expression to search for.
- **`file...`**: One or more files to search in. If no file is specified, `grep` searches the standard input.

### Simple Search

#### Search for a Word

To search for the word "apple" in a file:

```bash
grep "apple" file.txt
```

This command will print all lines containing the word "apple" from `file.txt`.

### Using Regular Expressions

`grep` supports regular expressions, which allow for more complex search patterns.

#### Search for a Pattern

To find lines containing a three-digit number:

```bash
grep "[0-9]\{3\}" file.txt
```

### Case Sensitivity

By default, `grep` is **case-sensitive**. You can make the search **case-insensitive** with the `-i` option.

#### Case-Insensitive Search

```bash
grep -i "apple" file.txt
```

This command will match "apple", "Apple", "APPLE", etc.

### Counting Matches

The `-c` option counts the number of lines that match the pattern.

#### Count Matching Lines

```bash
grep -c "apple" file.txt
```

### Displaying Line Numbers

The `-n` option displays line numbers along with matching lines.

#### Show Line Numbers

```bash
grep -n "apple" file.txt
```

### Inverting Matches

The `-v` option inverts the match, displaying lines that do not contain the pattern.

#### Example 6: Invert Match

```bash
grep -v "apple" file.txt
```

### Matching Whole Words

To match whole words only, use the `-w` option.

#### Match Whole Words

```bash
grep -w "apple" file.txt
```

This will not match "apples" or "pineapple".

### Matching Lines Exactly

To match the entire line, use the `-x` option.

#### Exact Line Match

```bash
grep -x "This is a line." file.txt
```

### Recursive Search

The `-r` (or `-R`) option allows for recursive search through directories.

```bash
grep -r "apple" /path/to/directory
```

### Displaying Only Filenames

The `-l` option displays only the names of files containing the matching lines.

#### Show Filenames Only

```bash
grep -l "apple" file.txt anotherfile.txt
```

### Context Lines

The `-A`, `-B`, and `-C` options display lines of context around the matching lines.

- **`-A n`**: Display `n` lines after the match.
- **`-B n`**: Display `n` lines before the match.
- **`-C n`**: Display `n` lines before and after the match.

```bash
grep -C 2 "apple" file.txt
```

This shows 2 lines of context around each match.

### Extended Regular Expressions

The `-E` option enables extended regular expressions, allowing for more complex patterns.

#### Extended Regex

```bash
grep -E "(apple|orange)" file.txt
```

This matches lines containing either "apple" or "orange".

### Grep with Pipes

`grep` is often used in combination with other commands using pipes.

#### Using Pipes

```bash
cat file.txt | grep "apple"
```

This command pipes the output of `cat` into `grep`.

### Suppressing Errors

The `-s` option suppresses error messages about nonexistent or unreadable files.

#### Suppress Errors

```bash
grep -s "apple" file.txt
```

### Practical Examples

#### Searching Logs for Errors

To find error messages in a log file:

```bash
grep -i "error" /var/log/syslog
```

#### Counting TODO Comments in Code

To count lines containing "TODO" in your code:

```bash
grep -r -c "TODO" /path/to/code
```

`grep` is a versatile tool for text searching and filtering, making it an essential part of any Linux user's toolkit. It supports a wide range of options and patterns, enabling efficient searches in files and directories.

---

### Practical Example: Check for a Regular File

In this example, the -f flag checks if the specified file is a regular file, providing more specific information than -e.

```bash
#!/usr/bin/bash

# Prompt the user for directory and filename
read -p "Enter the directory path: " dir_path
read -p "Enter the filename: " file_name

# Combine the directory and filename into a full path
full_path="$dir_path/$file_name"

# Check if the file exists and is a regular file
if [ -f "$full_path" ]; then
    echo "The file '$file_name' exists and is a regular file in the directory '$dir_path'."
else
    echo "The file '$file_name' does not exist or is not a regular file in the directory '$dir_path'."
fi
```

---

## Awk command

`awk` is a powerful text-processing tool in Unix/Linux that allows you to manipulate and analyze text files. It's particularly useful for working with columns of data.

### Basic Syntax and Usage for `awk`

`awk` operates on a per-line basis, treating each line of input as a record. Fields within these records are separated by delimiters (default is whitespace).

Basic syntax:

```bash
awk 'pattern { action }' input_file
```

- **`pattern`**: (Optional) Specifies the conditions to select lines.
- **`action`**: (Optional) Specifies what to do with selected lines.

If no pattern is specified, `awk` performs the action on all lines.

#### Print Specific Columns

To print the first column of a file:

```bash
awk '{ print $1 }' file.txt
```

- `$1` refers to the first field (column), `$2` to the second, and so on. `$0` refers to the entire line.

#### Print Lines Matching a Pattern

To print lines where the first column is greater than 50:

```bash
awk '$1 > 50' file.txt
```

Print the first 10 lines of a file where $1 is an integer.

```bash
user@host:~/dev/awk_testing$ awk '$1 < 10' tabular_data.txt 
1       Auberon Forri   aforri0@canalblog.com   Male    200.109.190.92
2       Slade   Lemonby slemonby1@arstechnica.com       Male    244.26.222.3
3       Elfrida Gaitskell       egaitskell2@unc.edu     Female  28.131.115.188
4       Sollie  Dooher  sdooher3@infoseek.co.jp Male    115.87.218.188
5       Alida   Poynser apoynser4@intel.com     Female  9.197.195.184
6       Emmy    Wasling ewasling5@istockphoto.com       Genderfluid     192.16.239.254
7       Winonah Jarnell wjarnell6@eepurl.com    Female  99.2.97.172
8       Dav     Kumaar  dkumaar7@altervista.org Male    148.135.79.5
9       Agnella Kasher  akasher8@soundcloud.com Female  41.163.162.105
```

### Field Separator

You can specify a different field separator using the `-F` option.

#### Custom Field Separator

If your data is comma-separated:

```bash
awk -F, '{ print $1 }' file.csv
```

### Built-in Variables

`awk` has several built-in variables that are useful for text processing:

- **`NR`**: Current record number (line number).
- **`NF`**: Number of fields in the current record.

#### Print Line Number and Content

```bash
awk '{ print NR, $0 }' file.txt
```

This example will print each line in the file with a line number before it:

```bash
$ awk '{ print NR, $0 }' tabular_data.txt 
1 id    first_name      last_name       email   gender  ip_address
2 1     Auberon Forri   aforri0@canalblog.com   Male    200.109.190.92
3 2     Slade   Lemonby slemonby1@arstechnica.com       Male    244.26.222.3
4 3     Elfrida Gaitskell       egaitskell2@unc.edu     Female  28.131.115.188
5 4     Sollie  Dooher  sdooher3@infoseek.co.jp Male    115.87.218.188
6 5     Alida   Poynser apoynser4@intel.com     Female  9.197.195.184
7 6     Emmy    Wasling ewasling5@istockphoto.com       Genderfluid     192.16.239.254
8 7     Winonah Jarnell wjarnell6@eepurl.com    Female  99.2.97.172
9 8     Dav     Kumaar  dkumaar7@altervista.org Male    148.135.79.5
10 9    Agnella Kasher  akasher8@soundcloud.com Female  41.163.162.105
```

### Arithmetic Operations

You can perform arithmetic operations within `awk`.

#### Sum a Column

To sum the values in the second column:

```bash
awk '{ sum += $2 } END { print sum }' file.txt
```

- `END` specifies the action to be taken after all lines have been processed.

### Advanced Pattern Matching

You can use regular expressions for pattern matching.

#### Lines Containing a Specific String

To print lines containing the string "error":

```bash
awk '/error/' file.txt
```

#### Start and End Pattern Matching

Print all lines between lines containing "start" and "end":

```bash
awk '/start/,/end/' file.txt
```

### User-defined Functions and External Commands

You can define functions within `awk` or call external commands.

#### External Command

To execute a shell command:

```bash
awk '{ system("date") }' file.txt
```

### Writing to Files

You can redirect output to a file.

#### Redirect Output

To save the first column to a file:

```bash
awk '{ print $1 > "output.txt" }' file.txt
```

### BEGIN and END Blocks

`BEGIN` and `END` blocks execute before and after the main processing loop, respectively.

```bash
awk 'BEGIN { print "Start" } { print $1 } END { print "End" }' file.txt
```

### Regular Expressions in `awk`

Regular expressions are powerful tools for searching and manipulating text based on patterns.

### Basic Regex Syntax in `awk`

In `awk`, regular expressions are enclosed between slashes `/.../`. Here are some basic regex elements:

- `.`: Matches any single character.
- `*`: Matches zero or more occurrences of the preceding character.
- `+`: Matches one or more occurrences of the preceding character.
- `?`: Matches zero or one occurrence of the preceding character.
- `^`: Matches the beginning of a line.
- `$`: Matches the end of a line.
- `[abc]`: Matches any one of the characters inside the brackets.
- `[^abc]`: Matches any character not inside the brackets.
- `(pattern1|pattern2)`: Matches either pattern1 or pattern2.

### Finding Patterns

#### Matching Lines Containing a Specific Word**

To find lines containing the word "error":

```bash
awk '/error/' file.txt
```

#### Matching Lines Starting with a Specific Word

To find lines that start with "Start":

```bash
awk '/^Start/' file.txt
```

#### Matching Lines Ending with a Specific Word**

To find lines ending with "end":

```bash
awk '/end$/' file.txt
```

#### Matching Lines with a Specific Pattern

To find lines containing a three-digit number:

```bash
awk '/[0-9]{3}/' file.txt
```

### Using Regex for Field Matching

You can use regex to match patterns within specific fields.

#### Example 5: Matching a Pattern in a Specific Column

To find lines where the second column contains "error":

```bash
awk '$2 ~ /error/' file.txt
```

- The `~` operator matches the field against the regex.

### Using Regex in BEGIN and END Blocks

Regex can be used in BEGIN and END blocks for initializing or finalizing conditions.

#### Counting Lines Matching a Pattern**

To count the number of lines containing "error":

```bash
awk 'BEGIN { count=0 } /error/ { count++ } END { print count }' file.txt
```

### Inverting Matches 

To select lines that do not match a pattern, use the `!~` operator.

#### Excluding Lines Matching a Pattern

To find lines that do not contain "error":

```bash
awk '!/error/' file.txt

```

Or, for excluding in a specific column:

```bash
awk '$2 !~ /error/' file.txt
```

### Combining Patterns and Actions

You can combine regex with actions for more complex processing.

#### Extracting and Modifying Data

To extract the first and second columns of lines containing "error" and transform them:

```bash
awk '/error/ { print $1, $2 " - ERROR FOUND" }' file.txt
```

#### Substituting Text

To replace "error" with "ERROR" in the entire line:

```bash
awk '{ gsub(/error/, "ERROR"); print }' file.txt
```

- `gsub` is a function that globally substitutes a pattern with a replacement.

### Advanced Regex Features

#### Using Backreferences

To find lines where the same word appears twice consecutively:

```bash
awk '/\b([a-zA-Z]+) \1\b/' file.txt
```

- `\b` denotes word boundaries, and `\1` refers to the first captured group.

### Practical Example: Log File Analysis

Imagine you have a log file and want to extract error messages with timestamps.

```bash
awk '/ERROR/ { print $1, $2, $3, $0 }' logfile.txt
```

- Here, `$1`, `$2`, and `$3` could be the date and time fields, and `$0` prints the entire line.

### Case-Insensitive Matching

To perform case-insensitive matching, use the `IGNORECASE` variable.

```bash
awk 'BEGIN { IGNORECASE=1 } /error/' file.txt
```

### Combining Conditions and Patterns

You can combine conditions and patterns using logical operators like `&&` (AND), `||` (OR).

#### Complex Condition

To find lines where the first column contains "INFO" and the line also contains "success":

```bash
awk '$1 ~ /INFO/ && /success/' file.txt
```

## Parsing output from Commands with `awk`

You can use awk to parse the output from commands like ls and `grep`. This is a common practice in shell scripting to further process and format command output. `awk` is particularly useful for extracting specific fields or performing calculations on data.

### Parsing `ls` Output with `awk`

The `ls` command lists directory contents. You can use `awk` to extract specific details from this output.

#### Extracting Filenames

To list only the filenames:

```bash
ls -l | awk '{ print $9 }'
```

Here, `$9` represents the ninth field, which is typically the filename in the long listing format of `ls` (`ls -l`).

#### Extracting File Sizes

To list filenames along with their sizes:

```bash
ls -l | awk '{ print $5, $9 }'
```

The `$5` is the size of the file, and `$9` is the filename.

#### Total Size of Files

To calculate the total size of all files:

```bash
ls -l | awk '{ total += $5 } END { print total }'
```

This sums up the sizes in the fifth column and prints the total at the end.

### Parsing `grep` Output with `awk`

The grep command searches for patterns in files. You can use awk to further filter or format the output.

#### Extracting Line Numbers

If grep output includes line numbers (with the-n option), you can extract these numbers:

```bash
grep -n "pattern" file.txt | awk -F: '{ print $1 }'
```

* **-F**: sets the field separator to `:` because `grep -n` outputs in the format `filename:line_number:content`.

#### Counting Matching Lines

To count the number of matching lines:

```bash
grep "pattern" file.txt | awk 'END { print NR }'
```

NR is a built-in variable in awk that keeps track of the number of records (lines) processed.

### Combining Commands with Awk

#### Files Larger Than a Certain Size

To list files larger than a certain size (e.g., 1000 bytes):

```bash
ls -l | awk '$5 > 1000 { print $9, $5 }'
```

This filters files based on their size and prints the filename and size.

#### Find and Extract Specific Information

To find lines containing a specific pattern in a file and extract a particular column:

```bash
grep "pattern" file.txt | awk '{ print $3 }'
```

This extracts the third field from lines containing the pattern.

#### Practical Example: Disk Usage Analysis

To list the size and name of the top 5 largest files in the current directory:

```bash
ls -lS | awk 'NR>1 { print $5, $9 }' | head -5
```

- **ls -lS** sorts files by size in descending order.
- **NR>1** skips the first line, which is the total count line in `ls -l` output.
- **head -5** limits the output to the top 5 files.

### Using Variables and Functions with `awk`

You can define variables and functions within awk to process data more efficiently.

#### Using Variables

```bash
ls -l | awk '{ size += $5 } END { print "Total size:", size }'
```

This calculates the total size of all files in a directory.

#### Using Functions

```bash
ls -l | awk 'function human(x) { if (x>=1024) {x=x/1024; return human(x)}; else return x "K"} { print $9, human($5) }'
```

This function converts file sizes to a more readable format.
Using awk in conjunction with other commands like ls and grep allows for powerful and flexible data manipulation directly from the command line. It's particularly useful for extracting specific information, transforming data, or performing calculations.

---

## Sed Command

`sed`, short for "stream editor," is another powerful tool in Unix/Linux for parsing and transforming text. It's particularly useful for substitution, deletion, and insertion of text in a non-interactive manner.

### Basic Syntax and Usage of `sed`

The basic syntax for `sed` is:

```bash
sed 'command' file
```

- **`command`**: Specifies the action `sed` should take on the input.

### Basic Substitution

#### Substituting Text

To replace "foo" with "bar" in a file:

```bash
sed 's/foo/bar/' file.txt
```

- `s`: Stands for "substitute."
- `foo`: The search pattern.
- `bar`: The replacement string.

#### Global Substitution

To replace all occurrences of "foo" with "bar" in each line:

```bash
sed 's/foo/bar/g' file.txt
```

- `g`: Stands for "global," meaning all occurrences in the line.

### Using `-i` with a Backup Suffix and In-place Editing

To make `sed` automatically create a backup file before editing, you can use the `-i` (in-place) option with an optional backup suffix. This suffix is appended to the original filename, creating a backup of the file before any changes are made.

The syntax for using `sed` with a backup suffix is:

```bash
sed -i.bak 's/pattern/replacement/g' file.txt
```

- `-i.bak`: The `-i` option enables in-place editing, and `.bak` is the backup suffix.
- `file.txt.bak`: The original file is backed up with this name.

#### In-place Editing

To modify the original file directly, use the `-i` option:

```bash
sed -i 's/foo/bar/g' file.txt
```

This command replaces "foo" with "bar" in the file `file.txt` and saves the changes.

#### About Automatic Backup

1. **Backup File Location**: The backup file is created in the same directory as the original file. The backup has the same permissions as the original file.

2. **Handling Multiple Files**: When using `sed` on multiple files, each file will have its own backup created if a suffix is provided.

3. **Cross-Platform Considerations**: The `-i` option behaves differently on various Unix-like systems. On some systems, like macOS, you may need to use `-i ''` to indicate no backup suffix, while on others, just `-i` suffices.

#### Example: Backup Before Substitution

To replace the word "old" with "new" in `file.txt` and create a backup with the `.bak` suffix:

```bash
sed -i.bak 's/old/new/g' file.txt
```

- This command creates a backup named `file.txt.bak` before making changes to `file.txt`.

#### Specifying a Custom Backup Suffix

You can specify any string as a backup suffix. It's good practice to use a suffix that clearly indicates the file is a backup.

#### Example: Custom Suffix

```bash
sed -i.backup 's/old/new/g' file.txt
```

- This creates a backup named `file.txt.backup`.

#### No Backup Suffix (Overwrites Original)

If you do not provide a suffix, `sed` will edit the file in place without creating a backup, potentially leading to data loss if something goes wrong. To avoid this, always specify a suffix if you need a backup.

#### Example: No Backup

```bash
sed -i 's/old/new/g' file.txt
```

#### Example: macOS Syntax

```bash
sed -i '' 's/old/new/g' file.txt
```

- On macOS, an empty string `''` is used after `-i` to indicate no backup.

Using the `-i` option with a suffix provides a convenient way to ensure that you have a backup of your original file, preventing accidental data loss. This is particularly useful when running scripts or making bulk edits across multiple files.

### Addressing Lines

You can specify the line numbers or patterns to limit the scope of `sed` commands.

#### Substitution on a Specific Line**

To replace "foo" with "bar" only on the second line:

```bash
sed '2s/foo/bar/' file.txt
```

#### Substitution in a Range of Lines

To replace "foo" with "bar" from line 2 to line 4:

```bash
sed '2,4s/foo/bar/' file.txt
```

#### Substitution Using a Pattern

To replace "foo" with "bar" in lines containing "baz":
```bash
sed '/baz/s/foo/bar/' file.txt
```

### Deleting Lines

#### Delete a Specific Line

To delete the third line:

```bash
sed '3d' file.txt
```

#### Delete Lines Matching a Pattern

To delete lines containing "error":
```bash
sed '/error/d' file.txt
```

### Inserting and Appending Text

#### Insert Text Before a Line

To insert "Hello" before the third line:

```bash
sed '3i\Hello' file.txt
```

- `i\`: Insert before the specified line.

#### Append Text After a Line

To append "World" after the third line:

```bash
sed '3a\World' file.txt
```

- `a\`: Append after the specified line.

### Changing Lines

#### Example 10: Replace a Line

To replace the third line with "New line":

```bash
sed '3c\New line' file.txt
```

- `c\`: Change the specified line.

### Advanced Regular Expressions with `sed`

#### Matching and Substitution with Regex

To replace the first digit in each line with "number":

```bash
sed 's/[0-9]/number/' file.txt
```

#### Grouping and Referencing

To swap two words:

```bash
sed 's/\(word1\) \(word2\)/\2 \1/' file.txt
```

- `\(word1\)`: Captures "word1."
- `\2 \1`: References the captured groups in the replacement.

#### Using Extended Regex

For more complex regex, use the `-E` option (or `-r` in some systems):

```bash
sed -E 's/[0-9]{3}/number/g' file.txt
```

- `-E`: Enables extended regular expressions, which allow for additional features like `+`, `?`, `{}`, etc.

### Multi-line and Contextual Operations

#### Multi-line Matching

`sed` typically operates on a line-by-line basis, but you can use the `N` command to match across multiple lines:

```bash
sed 'N;s/\n/ /' file.txt
```

- `N`: Appends the next line to the pattern space.

#### Contextual Deletion

To delete the line following a line containing "start":

```bash
sed '/start/{N;d}' file.txt
```

### Replacing a Chunk of Lines with Sed

`sed` can replace a chunk of lines in a document. You can define a range of lines to be replaced and use a placeholder or variable-like syntax for the replacement content.

#### Example: Replace Lines from Line 2 to Line 4

To replace lines 2 to 4 with a new block of text:

```bash
sed '2,4c\
This is the new content\
spanning multiple lines' file.txt
```

- `2,4`: Specifies the line range to be replaced.
- `c\`: Stands for "change" and replaces the specified lines with the following content.

### Using a Variable for the Replacement Content

While `sed` itself doesn't directly support variables as you might use in programming languages, you can achieve similar functionality by using shell variables and command substitution. Here's an example:

#### Example: Using a Shell Variable

Suppose you have a shell variable `NEW_CONTENT` containing the new text:

```bash
NEW_CONTENT="This is the new content
spanning multiple lines"
```

You can use this variable with `sed` as follows:

```bash
sed "2,4c\\
$NEW_CONTENT" file.txt
```

- The backslash (`\`) after `c` and before the variable ensures that the entire variable content is treated as a single block.

### Complex Example Multiline Replacement with Dynamic Content

If you want to replace lines dynamically based on some conditions or external data, you can use command substitution or `here documents`.

#### Example: Replacing with Dynamic Content

Suppose you have a file `replacement.txt` with the content you want to insert:

```bash
replacement=$(cat replacement.txt)
sed "2,4c\\
$replacement" file.txt
```

Here, `cat replacement.txt` reads the file content, and the variable `replacement` is used in the `sed` command.

### Handling Special Characters In multiline replacement

If your replacement content contains special characters (like slashes or backslashes), you may need to escape them or use different delimiters. For instance, if the content includes slashes (`/`), you can use a different delimiter for the `sed` substitution, like `|`.

#### Example: Handling Slashes

```bash
sed '2,4c|This is the new content with /slashes/|' file.txt
```

#### Summary of multi-line substitution

- **Line Range (`m,n`)**: Specifies the chunk of lines to operate on.
- **Change Command (`c\`)**: Replaces the specified line range with new content.
- **Shell Variables and Command Substitution**: Allow for dynamic or external data to be used as replacement content.

Using these techniques, you can effectively replace chunks of text in a file with `sed`, utilizing shell variables to inject dynamic content as needed.

### Using Sed Scripts

For complex operations, you can write a `sed` script and save it in a file:

```bash
sed -f script.sed file.txt
```

- The `script.sed` file can contain multiple `sed` commands.

### Practical Example: Extracting IP Addresses

To extract IP addresses from a file:

```bash
sed -nE 's/.*([0-9]{1,3}\.){3}[0-9]{1,3}.*/\0/p' file.txt
```

- `-n`: Suppresses automatic printing of lines.
- `p`: Prints only the matched lines.

`sed` is incredibly versatile for stream editing and batch text processing, making it invaluable for scripting and data manipulation. If there's a specific scenario you're interested in, or if you'd like more detailed examples, just let me know!

---

## Read command

The `read` command in BASH is used to take input from the user. It reads a line from standard input and assigns it to one or more variables. This command is very useful for interactive scripts where user input is required.

### Basic Usage of `read`

The simplest form of `read`:

```bash
#!/bin/bash

echo "Enter your name:"
read name
echo "Hello, $name!"
```

In this example:

- `read name`: The `read` command waits for the user to input a line of text. The input is then stored in the variable `name`.
- `echo "Hello, $name!"`: This line prints the greeting with the user's name.

### Reading Multiple Values

The `read` command can take multiple inputs and store them in separate variables.

```bash
#!/bin/bash

echo "Enter your first and last name:"
read first_name last_name
echo "Hello, $first_name $last_name!"
```

Here, the `read` command splits the input into two variables: `first_name` and `last_name`. If the user enters more words than the number of variables, the extra words are assigned to the last variable.

### Using `read` with Options

The `read` command comes with several options that modify its behavior:

- `-p`: Display a prompt before reading the input.
- `-s`: Silent mode, where the input is not displayed on the screen (useful for passwords).
- `-n`: Read a specific number of characters.
- `-t`: Set a timeout for input.

#### Prompt Option (-p)

```bash
#!/bin/bash

read -p "Enter your age: " age
echo "You are $age years old."
```

Here, `-p` displays the prompt "Enter your age: " before waiting for user input.

#### Silent Option (-s)

```bash
#!/bin/bash

read -sp "Enter your password: " password
echo
echo "Password entered: $password"
```

The `-s` option makes the input invisible on the screen, useful for sensitive data like passwords.

#### Character Limit Option (-n)

```bash
#!/bin/bash

read -n 3 -p "Enter a 3-letter code: " code
echo
echo "You entered: $code"
```

The `-n 3` option limits the input to 3 characters. The script will proceed automatically after the user enters 3 characters.

#### Timeout Option (-t)

```bash
#!/bin/bash

if read -t 5 -p "Enter your name within 5 seconds: " name; then
    echo "Hello, $name!"
else
    echo "You took too long to respond."
fi
```

The `-t 5` option sets a timeout of 5 seconds. If the user doesn't provide input within this time, the `read` command returns a non-zero exit status, and the `else` block is executed.

### Reading a Line into an Array

You can read a line of input into an array using the `-a` option:

```bash
#!/bin/bash

echo "Enter three words:"
read -a words
echo "You entered: ${words[0]}, ${words[1]}, ${words[2]}"
```

Here, the `-a` option reads the input into the `words` array. Each word is stored as an element in the array, which can be accessed using `${words[index]}`.

### Reading from a File

You can also use `read` to read lines from a file:

```bash
#!/bin/bash

while read line; do
    echo "Line: $line"
done < input.txt
```

This script reads each line from the file `input.txt` and prints it. The `while read line` loop iterates over each line of the file.

The `read` command is a versatile tool in BASH scripting, useful for obtaining user input, handling sensitive information, and reading from files. 

Certainly! Using the `read` command within a function can be quite powerful for creating interactive and reusable components in your BASH scripts. Let's go through a lesson on how to use `read` within functions, complete with examples.

### Introduction to Functions with `read`

Functions encapsulate a block of code that can be reused throughout your script. When combined with the `read` command, functions can collect user input, process it, and return results or perform actions based on the input.

### Basic Function with `read`

Let's start with a simple function that prompts the user for their name and prints a greeting.

```bash
#!/bin/bash

# Define the function
get_name_and_greet() {
    echo "Enter your name:"
    read name
    echo "Hello, $name!"
}

# Call the function
get_name_and_greet
```

In this example:

- The function `get_name_and_greet` uses `read` to capture the user's input and stores it in the variable `name`.
- The function then greets the user by name.

### Using `read` with Options in Functions

You can use various options with `read` inside functions, just like in standalone scripts.

#### Example: Function with Prompt and Silent Mode

```bash
#!/bin/bash

# Function to read username and password
get_credentials() {
    read -p "Enter your username: " username
    read -sp "Enter your password: " password
    echo
    echo "Username: $username"
    echo "Password: [hidden]"
}

# Call the function
get_credentials
```

Here:

- `read -p "Enter your username: " username` prompts the user for a username and stores it in `username`.
- `read -sp "Enter your password: " password` prompts for a password in silent mode (input is not shown on screen) and stores it in `password`.

### Using `read` for Multiple Inputs in Functions

Functions can collect multiple inputs from the user.

#### Example: Function to Collect User Details

```bash
#!/bin/bash

# Function to read user details
get_user_details() {
    echo "Enter your first name:"
    read first_name
    echo "Enter your last name:"
    read last_name
    echo "Enter your age:"
    read age
    echo "Name: $first_name $last_name, Age: $age"
}

# Call the function
get_user_details
```

This function collects the first name, last name, and age from the user and then displays the collected information.

### Using `read` with Arrays in Functions

You can use `read` to populate arrays within functions, making it easy to handle multiple values.

#### Example: Reading Multiple Words into an Array

```bash
#!/bin/bash

# Function to read words into an array
get_words() {
    echo "Enter three words:"
    read -a words
    echo "You entered: ${words[@]}"
}

# Call the function
get_words
```

In this function, the `-a` option is used with `read` to read multiple words into the `words` array. The entire array is then printed using `${words[@]}`.

### Practical Example: Function with User Input Validation

You can also include validation logic within functions to ensure the user input meets certain criteria.

#### Example: Validate Age Input

```bash
#!/bin/bash

# Function to read and validate age
get_valid_age() {
    while true; do
        read -p "Enter your age (must be a positive integer): " age
        if [[ "$age" =~ ^[0-9]+$ ]] && [ "$age" -gt 0 ]; then
            echo "Valid age: $age"
            break
        else
            echo "Invalid input. Please enter a positive integer."
        fi
    done
}

# Call the function
get_valid_age
```

In this example:

- The function `get_valid_age` prompts the user for their age.
- It uses a `while true` loop to repeatedly ask for the input until a valid positive integer is provided.
- The regex `^[0-9]+$` ensures that only numeric input is accepted, and the `[ "$age" -gt 0 ]` check ensures that the age is positive.

---

## Case command

The `case` statement in BASH scripting is used to simplify conditional execution based on the value of a variable. It’s similar to the `switch` statement in other programming languages. The `case` statement allows you to match a variable against several patterns, executing corresponding commands for the first matching pattern.

### Basic Syntax of `case` Statement

```bash
case variable in
    pattern1)
        commands1
        ;;
    pattern2)
        commands2
        ;;
    *)
        default_commands
        ;;
esac
```

- **`variable`**: The variable or expression whose value you want to test.
- **`pattern`**: A pattern to match against the value of `variable`. It can be a specific value, a range, or a wildcard pattern.
- **`commands`**: The commands to execute if `variable` matches `pattern`.
- **`;;`**: Terminates the current pattern block.
- **`*`**: The wildcard pattern matches anything and is often used as the default case.

#### Example with Explanation

In this example, the pattern that maps a user's choice to an NFS group ID from a menu (not shown).

```bash
case $choice in
    1) echo 7 ;;
    2) echo 1 ;;
    3) echo 2 ;;
    4) echo 3 ;;
    5) echo 4 ;;
    6) echo 5 ;;
    7) echo 6 ;;
    8) echo 101 ;;
    *) echo "Invalid choice"; exit 1 ;;
esac
```

**Explanation:**

1. **`case $choice in`**:
   - The `case` statement starts by evaluating the value of the variable `choice`.

2. **Matching Patterns**:
   - The script checks each case block to find a match for `$choice`.
   - For example, if `$choice` is `1`, it matches the first case `1)`.

3. **Executing Commands**:
   - When a match is found, the commands associated with that pattern are executed. Here, `echo 7` is executed if `$choice` is `1`.

4. **The `;;` Terminator**:
   - Each case block is terminated by `;;`. This indicates the end of the commands for that particular case.

5. **Wildcard `*` for Default Case**:
   - The `*` pattern is a catch-all for any values not explicitly matched by the previous patterns. If no previous patterns match, the commands following `*` are executed.
   - In this example, `echo "Invalid choice"; exit 1` is executed if `$choice` doesn't match any of the numbers `1` through `8`. The `exit 1` command is used to terminate the script with a non-zero status, indicating an error.

### Use Cases for `case` Statement

- **Menu Selection**: Often used to handle user input in a script that presents a menu of options.
- **File Extension Handling**: Useful for executing different commands based on a file’s extension.
- **Validation**: Can be used to validate input and handle different cases accordingly.

### Advantages of Using `case`

- **Clarity**: Makes the script more readable compared to multiple `if-elif-else` statements.
- **Efficiency**: Suitable for handling multiple conditions that depend on the value of a single variable.
- **Flexibility**: Supports pattern matching, including wildcards and ranges.

### Practical Example: Menu Selection Script

Here’s an example script that uses a `case` statement to handle user menu selection:

```bash
#!/usr/bin/bash

echo "Select an option:"
echo "1) Start service"
echo "2) Stop service"
echo "3) Restart service"
echo "4) Status of service"
read -p "Enter your choice (1-4): " choice

case $choice in
    1)
        echo "Starting service..."
        # Command to start service
        ;;
    2)
        echo "Stopping service..."
        # Command to stop service
        ;;
    3)
        echo "Restarting service..."
        # Command to restart service
        ;;
    4)
        echo "Checking service status..."
        # Command to check service status
        ;;
    *)
        echo "Invalid choice"; exit 1 ;;
esac
```

In this example:

- The script displays a menu and prompts the user for a choice.
- The `case` statement handles the user’s selection and performs the corresponding action.
- If the user enters an invalid option, the default case is executed, displaying an error message and exiting the script.

The `case` statement is a powerful tool in BASH scripting, especially when dealing with multiple conditions. It helps make scripts more organized and easier to read.

## Redirects and stdout `>&1` and stderr `>&2`

In BASH and other Unix-like shells, **redirection** is a way to control where the output of a command goes and where the input of a command comes from. It's commonly used for logging, error handling, and chaining commands together.

### Standard Streams

There are three standard streams in Unix-like systems:

1. **Standard Input (stdin)**: Input to the program, typically from the keyboard. File descriptor number: `0`.
2. **Standard Output (stdout)**: Output from the program, typically to the terminal screen. File descriptor number: `1`.
3. **Standard Error (stderr)**: Error messages, also typically to the terminal screen. File descriptor number: `2`.

### Basic Redirection Operators

- **`>`**: Redirects stdout to a file. If the file exists, it's overwritten.

  ```bash
  ls > output.txt
  ```

  This command redirects the output of `ls` to `output.txt`.

- **`>>`**: Appends stdout to a file. If the file doesn't exist, it's created.

  ```bash
  echo "Hello" >> output.txt
  ```

- **`<`**: Redirects a file to stdin.

  ```bash
  wc -l < output.txt
  ```

  This command counts the lines in `output.txt`.

### Redirecting stderr and stdout

- **`2>`**: Redirects stderr to a file.

  ```bash
  ls nonexistentfile 2> error.txt
  ```

  This command redirects the error message (because `nonexistentfile` does not exist) to `error.txt`.

- **`&>`**: Redirects both stdout and stderr to a file (BASH only).

  ```bash
  ls existingfile nonexistentfile &> all_output.txt
  ```

  This command redirects both the output of the successful `ls` command and the error message to `all_output.txt`.

### File Descriptor Manipulation

- **`>&1` and `>&2`**: These notations are used to redirect one file descriptor to another.

#### Examples and Explanation

- **Redirecting stderr to stdout (`2>&1`)**:

  ```bash
  ls existingfile nonexistentfile > all_output.txt 2>&1
  ```

  In this command:

  - `>` redirects stdout to `all_output.txt`.
  - `2>&1` redirects stderr (file descriptor 2) to wherever stdout (file descriptor 1) is currently going, which is `all_output.txt`.

  This means both the normal output and error messages are written to `all_output.txt`.

- **Separating stdout and stderr**:

  ```bash
  command >stdout.txt 2>stderr.txt
  ```

  Here, stdout is redirected to `stdout.txt` and stderr to `stderr.txt`.

- **Discarding output using `/dev/null`**:

  ```bash
  command > /dev/null 2>&1
  ```

  - `/dev/null` is a special file that discards all data written to it. 
  - This command effectively silences all output and error messages from `command`.

### Advanced Redirection Techniques

- **Redirecting a file descriptor to another before a command runs**:

  ```bash
  exec 3>&1
  exec > output.log
  command
  exec >&3
  exec 3>&-
  ```

  - `exec 3>&1` saves the current stdout to file descriptor 3.
  - `exec > output.log` redirects all stdout to `output.log`.
  - `command` runs with its stdout going to `output.log`.
  - `exec >&3` restores stdout from file descriptor 3.
  - `exec 3>&-` closes file descriptor 3.

- **Using process substitution for redirection**:

  ```bash
  diff <(ls dir1) <(ls dir2)
  ```

  - `<(...)` creates a temporary named pipe and passes it to `diff`. The contents of the directories `dir1` and `dir2` are compared.

### Practical Applications

- **Logging**:
  - Capture the output of a script to a log file while also capturing errors separately.

- **Debugging**:
  - Redirecting stderr to analyze error messages without mixing them with standard output.

- **Performance Monitoring**:
  - Silencing stdout while only logging errors to avoid clutter in log files.

- **Batch Processing**:
  - Using input redirection to automate commands that usually require user input.

Redirection is a powerful feature in BASH scripting that allows you to control the flow of data to and from commands. Understanding and using redirections like `>&1` and `>&2` can significantly improve the efficiency and manageability of your scripts, especially when dealing with logging and error handling. 

## Logging in a BASH script

You use the `>>` redirection operator to append output to a log file (or any other file) in BASH. This operator appends the output to the specified file without overwriting the existing contents. This is particularly useful for logging, where you want to keep a continuous record of output over time.

### Appending to a Log File with `>>`

Here's how you can use `>>` to append output:

1. **Appending stdout to a log file:**

   ```bash
   echo "This is a log message" >> logfile.txt
   ```

   This command appends the string "This is a log message" to `logfile.txt`.

2. **Appending stderr to a log file:**

   ```bash
   command_that_might_fail 2>> error_log.txt
   ```

   This appends any error messages produced by `command_that_might_fail` to `error_log.txt`.

3. **Appending both stdout and stderr to the same log file:**

   ```bash
   command >> log.txt 2>&1
   ```

   - `command >> log.txt` appends stdout to `log.txt`.
   - `2>&1` redirects stderr (file descriptor 2) to the same location as stdout (file descriptor 1), effectively appending both stdout and stderr to `log.txt`.

### Practical Example: Logging Script Output

Imagine you have a script that runs several commands, and you want to log all outputs to a file for later review:

```bash
#!/usr/bin/bash

logfile="script_output.log"

# Append a header with the current date and time
echo "Script run on $(date)" >> "$logfile"

# Run some commands and log their output
echo "Running first command..." >> "$logfile"
first_command >> "$logfile" 2>&1

echo "Running second command..." >> "$logfile"
second_command >> "$logfile" 2>&1

echo "Script completed." >> "$logfile"
```

In this script:

- `$(date)` gets the current date and time, which is appended as a header in the log file.
- `first_command` and `second_command` represent commands whose output (both stdout and stderr) is logged.

### **Benefits of Using `>>` for Logging**

- **Non-Destructive**: `>>` ensures that each new log entry is added to the end of the file without deleting the existing contents.
- **Continuous Logs**: Useful for scripts or processes that run periodically or continuously, where you want to maintain a complete record of all outputs.
- **Separation of Concerns**: You can keep separate logs for stdout and stderr or combine them, depending on your needs.

This technique is fundamental in system administration, scripting, and any scenario where maintaining a history of events or outputs is essential.
