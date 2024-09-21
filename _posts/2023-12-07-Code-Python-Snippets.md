---
title: "Python Code Snippets from Previous Projects"
layout: post
---

A collection of useful code snippets and notes that I've found handy throughout various projects. Whether you're dealing with API limits or parsing YAML files, these examples should make your life a bit easier!

## Limiting API Calls by Time and Amount

When working with APIs, especially those with rate limits, it's essential to avoid overwhelming the server with too many requests. Here's a Python function to limit API calls within a set time frame.

```python
import time

api_call_timestamps = []

def limit_api_calls():
    current_time = time.time()
    # Remove timestamps older than 5 minutes
    api_call_timestamps[:] = [timestamp for timestamp in api_call_timestamps if timestamp > current_time - 300]

    if len(api_call_timestamps) >= 10:
        time.sleep(300)  # Wait for 5 minutes

    api_call_timestamps.append(current_time)
    # Add your API call logic here
```

This function tracks API call timestamps and ensures that no more than 10 calls are made within a 5-minute window. If the limit is reached, it waits 5 minutes before proceeding.

## Calculating Article Reading Time from XML

Estimate how long it will take to read an article based on its word count using the `lxml` library to parse XML.

```python
import math
from lxml import etree

def reading_time():
    with open("article.xml", "r") as f:
        xml = f.read()
        root = etree.fromstring(xml)
        text = root.xpath("//article[@id='article']")[0].text
        wpm = 225  # Words per minute
        words = len(text.strip().split())
        time = math.ceil(words / wpm)
        print(time)

reading_time()
```

In this example, the function reads an XML file, extracts the text from an article with the `id="article"`, and calculates the estimated reading time based on a reading speed of 225 words per minute. Using `math.ceil()` ensures the time is rounded up to the nearest minute.

## Convert YAML to Python to JSON

Here's a utility script that converts a YAML file into both Python data structures and JSON format.

```python
#!/usr/bin/env python

import sys
import os
import yaml
import json

def convert(filename):
    with open(filename) as temp:
        return yaml.safe_load(temp)

with open(sys.argv[1]) as temp:
    Input = temp.read()

Output = yaml.safe_load(Input)

os.system('clear')

print("**********YAML************")
print(Input)

print("\n**********PYTHON************")
print(Output)

print("\n**********JSON*************")
print(json.dumps(Output, sort_keys=True, indent=2, separators=(', ', ': ')))
```

This script takes a YAML file as input, converts it to Python, and then outputs the result as formatted JSON. It’s a handy tool for working with configuration files.

## Parsing Jinja2 Templates with YAML Variables

Here’s how to take a simple Jinja2 template and populate it with variables from a YAML file.

```python
#!/usr/bin/env python

from jinja2 import Environment, FileSystemLoader
import yaml
import sys
import re
import os
from bracket_expansion import *

os.system('clear')

ENV = Environment(loader=FileSystemLoader('.'), trim_blocks=True, lstrip_blocks=True)
ENV.filters['bracket_expansion'] = bracket_expansion

filename_j2 = sys.argv[1]
filename = re.sub("\.j2", "", sys.argv[1])
filename_yml = '../vars/' + filename + '.yml'

with open(filename_yml) as temp:
    Input = temp.read()

print(f"*****Reading YAML file '{filename_yml}'****")
print(Input)

def convert(filename):
    with open(filename) as temp:
        return yaml.safe_load(temp)

Output_Dict = convert(filename_yml)

print(f"\n****Rendering Jinja2 template '{filename_j2}' ****")
template = ENV.get_template(filename_j2)
print(template.render(**Output_Dict))
```

This script reads variables from a YAML file and uses them to render a Jinja2 template, making it ideal for templating configurations or dynamic content generation.

## Making Files Accessible from Any Location

When running scripts that depend on files (like a SQLite database), relative paths can often cause issues. Here's a strategy using absolute paths to ensure your file is accessible regardless of where the script is executed from:

```python
import os

# Get the current file’s directory
current_dir = os.path.dirname(os.path.abspath(__file__))

# Construct the path to your database
db_path = os.path.join(current_dir, 'relative/path/to/your/database.db')
```

Using `os.path.abspath(__file__)`, this code creates an absolute path to ensure that the database file is always located correctly, no matter where your script is run from.

---

## Handling Paths in Different Environments

For flexibility across different environments (development, testing, production), consider using environment variables or configuration files to store file paths:

```python
import os

# Get the database path from an environment variable
db_path = os.getenv('MYAPP_DATABASE_PATH', 'default/path/to/database.db')
```

This method allows you to adjust the database path without changing your code, making it easier to maintain across environments.
