---
title: "XML - XPATH Common Use Cases and Function Refer"
author: "Barry Weiss"
layout: "post"
tags:
  - "XML"
---

XPath is a powerful tool for navigating and extracting data from XML and HTML documents, often likened to a GPS for document structures. Originally designed for XML, XPath is now widely used in web development, test automation, data processing, and DevOps. It enables developers to precisely target data within complex hierarchical structures using path-like expressions, supporting everything from test frameworks like Selenium to web scraping and configuration management.

XPath’s strength lies in its precision and flexibility, allowing for queries that filter based on content, attributes, and element position. This capability makes it a go-to tool for complex data extraction tasks. However, XPath can be challenging: complex queries may slow performance, and broad search patterns can impact efficiency. Its syntax can also be intimidating for beginners, and variations across browsers may introduce maintenance and debugging issues.

In production, developers should consider document structure stability, performance optimization, and cross-platform compatibility when using XPath. Although alternatives like CSS selectors work well for basic tasks, XPath excels when precise targeting or advanced filtering is essential. Understanding XPath’s capabilities and limitations allows developers to wield it effectively for data-intensive projects.

## 1. Core Value Selection Patterns

### Getting Element Values
```xml
<!-- Sample XML -->
<product>
    <name>iPhone</name>
    <price currency="USD">999.99</price>
    <specs memory="256GB" color="black"/>
</product>
```

```xpath
# Basic text value extraction
//name/text()                    # Gets: "iPhone"
//price/text()                   # Gets: "999.99"

# Getting attribute values
//price/@currency                # Gets: "USD"
//specs/@memory                  # Gets: "256GB"

# Combined value extraction
//product[name='iPhone']/@id     # Get ID of product named iPhone
```

### Important Value Functions

```xpath
# string() - Convert node to string
string(//price)                  # Gets text content
string(//specs/@memory)          # Gets attribute value

# number() - Convert to number
number(//price)                  # Converts to number for calculations

# normalize-space() - Trim whitespace
normalize-space(//description)    # Removes extra spaces
```

## 2. Advanced Value Selection

### Working with Multiple Values
```xml
<order>
    <items>
        <item price="10.99"/>
        <item price="20.99"/>
        <item price="15.99"/>
    </items>
    <total>47.97</total>
</order>
```

```xpath
# Sum of values
sum(//item/@price)               # Adds all prices

# Count of elements
count(//item)                    # Counts number of items

# Average calculation
sum(//item/@price) div count(//item)  # Average price
```

### Conditional Value Selection
```xpath
# Select based on value comparison
//item[@price > 15]                   # Items over $15
//product[number(price) < 100]        # Products under $100

# Select based on text content
//user[contains(name, 'John')]        # Users with 'John' in name
//item[starts-with(code, 'SKU')]      # Items with SKU codes
```

## 3. Real-World Value Extraction Scenarios

### E-commerce Example
```xml
<store>
    <products>
        <product id="123">
            <name>Laptop</name>
            <price currency="USD">1299.99</price>
            <stock status="in_stock">45</stock>
        </product>
    </products>
</store>
```

```xpath
# Find products low on stock
//product[number(stock) < 10]/name/text()

# Get prices of all in-stock items
//product[stock/@status='in_stock']/price/text()

# Find highest priced item
//product[not(//product/price > price)]/name/text()
```

### Log Analysis Example
```xml
<logs>
    <entry timestamp="2024-01-01 10:00:00">
        <level>ERROR</level>
        <message>Database connection failed</message>
        <code>DB_001</code>
    </entry>
</logs>
```

```xpath
# Extract error messages with timestamps
//entry[level='ERROR']/concat(
    @timestamp,
    ': ',
    message/text()
)

# Count errors by code
count(//entry[code='DB_001'])
```

## 4. Text Manipulation Functions

### String Operations
```xpath
# substring()
substring(//date, 1, 4)          # Get year from date

# concat()
concat(//firstname, ' ', //lastname)  # Full name

# translate()
translate(//status, 'abc', 'ABC')    # Convert to uppercase
```

### Numeric Operations
```xpath
# round()
round(//price)                   # Round to nearest integer

# floor() and ceiling()
floor(//rating)                  # Round down
ceiling(//rating)                # Round up
```

## 5. Value Testing & Validation

### Empty/Null Checks
```xpath
# Check for empty or null values
//element[string-length(normalize-space()) > 0]  # Non-empty elements
//product[string-length(@code) = 8]              # Valid product codes
```

### Value Format Validation
```xpath
# Pattern matching with contains() and starts-with()
//email[contains(., '@')]                        # Basic email check
//phone[starts-with(., '+1')]                    # US phone numbers

# Multiple conditions
//product[
    number(price) > 0 and
    string-length(code) = 10
]                                               # Valid products
```

## 6. Best Practices for Value Handling

1. **Always Use Type Conversion**
```xpath
# Good
number(//price) > 100
# Bad
//price > 100                    # Might fail with currency symbols
```

2. **Handle Missing Values**
```xpath
# Check before using
//product[price][number(price) > 100]  # Only products with price
```

3. **Text Normalization**
```xpath
# Clean text before comparison
normalize-space(translate(//status, 'ACTIVE', 'active'))
```

4. **Performance Tips**
```xpath
# Use specific paths when possible
/store/products/product/price    # Better
//price                         # Slower

# Combine conditions
//product[@status='active' and number(price) < 100]  # Better
//product[@status='active'][number(price) < 100]     # Slower
```

Remember:
- `text()` gets just the text content
- `string()` gets all text including descendants
- `normalize-space()` removes extra whitespace
- Always convert to appropriate type (`number()` for calculations)
- Use `concat()` for combining values
- Check for existence before accessing values

---

## XPath Functions Reference Guide

### String Functions

| Function | Syntax | Description | Example | Result |
|----------|--------|-------------|---------|---------|
| `concat()` | `concat(string1, string2, ...)` | Joins strings together | `concat(//first, ' ', //last)` | "John Smith" |
| `contains()` | `contains(string, substring)` | Checks if string contains substring | `//title[contains(., 'Guide')]` | true/false |
| `normalize-space()` | `normalize-space(string)` | Removes leading/trailing spaces and normalizes internal spaces | `normalize-space('  Hello   World  ')` | "Hello World" |
| `starts-with()` | `starts-with(string, prefix)` | Checks if string starts with prefix | `//code[starts-with(., 'SKU-')]` | true/false |
| `substring()` | `substring(string, start, length?)` | Extracts part of string | `substring('12345', 2, 3)` | "234" |
| `substring-before()` | `substring-before(string, delimiter)` | Gets text before delimiter | `substring-before('name@domain', '@')` | "name" |
| `substring-after()` | `substring-after(string, delimiter)` | Gets text after delimiter | `substring-after('name@domain', '@')` | "domain" |
| `translate()` | `translate(string, from, to)` | Replaces characters | `translate('Hello', 'el', 'ip')` | "Hippo" |
| `string-length()` | `string-length(string)` | Returns string length | `string-length('Hello')` | 5 |
| `lower-case()` | `lower-case(string)` | Converts to lowercase | `lower-case('Hello')` | "hello" |
| `upper-case()` | `upper-case(string)` | Converts to uppercase | `upper-case('Hello')` | "HELLO" |

### Numeric Functions

| Function | Syntax | Description | Example | Result |
|----------|--------|-------------|---------|---------|
| `number()` | `number(value)` | Converts to number | `number('123')` | 123 |
| `sum()` | `sum(nodeset)` | Adds numeric values | `sum(//price)` | 324.50 |
| `round()` | `round(number)` | Rounds to nearest integer | `round(3.7)` | 4 |
| `floor()` | `floor(number)` | Rounds down | `floor(3.7)` | 3 |
| `ceiling()` | `ceiling(number)` | Rounds up | `ceiling(3.2)` | 4 |
| `count()` | `count(nodeset)` | Counts nodes | `count(//item)` | 5 |
| `avg()` | `avg(nodeset)` | Calculates average | `avg(//score)` | 85.6 |

### Boolean Functions

| Function | Syntax | Description | Example | Result |
|----------|--------|-------------|---------|---------|
| `not()` | `not(expression)` | Negates boolean | `not(//user/@active)` | true/false |
| `true()` | `true()` | Returns true | `@enabled=true()` | true |
| `false()` | `false()` | Returns false | `@disabled=false()` | false |
| `boolean()` | `boolean(expression)` | Converts to boolean | `boolean(//stock)` | true/false |

### Node Functions

| Function | Syntax | Description | Example | Result |
|----------|--------|-------------|---------|---------|
| `last()` | `last()` | Index of last node | `//item[last()]` | Last item |
| `position()` | `position()` | Current position | `//item[position()=2]` | Second item |
| `name()` | `name(node)` | Node name | `name(//*)` | Element name |
| `local-name()` | `local-name(node)` | Local part of node name | `local-name(//*[1])` | Name without namespace |

### Real-World Examples

#### String Function Examples
```xml
<!-- Sample XML -->
<user>
    <name>   John   Smith   </name>
    <email>john.smith@example.com</email>
    <code>SKU-12345-ABC</code>
</user>
```

```xpath
# Clean up name
normalize-space(//name)                          # "John Smith"

# Extract username from email
substring-before(//email, '@')                   # "john.smith"

# Extract domain from email
substring-after(//email, '@')                    # "example.com"

# Get product code without SKU prefix
substring-after(//code, 'SKU-')                  # "12345-ABC"

# Case-insensitive search
translate(//name, 'ABCDEFGHIJKLMNOPQRSTUVWXYZ',
                 'abcdefghijklmnopqrstuvwxyz')   # "john smith"
```

#### Numeric Function Examples
```xml
<!-- Sample XML -->
<order>
    <item price="10.99"/>
    <item price="24.50"/>
    <item price="15.75"/>
    <tax rate="0.08"/>
</order>
```

```xpath
# Calculate total (sum of prices)
sum(//item/@price)                              # 51.24

# Round total to nearest dollar
round(sum(//item/@price))                       # 51

# Calculate tax amount
round(sum(//item/@price) * number(//tax/@rate) * 100) div 100  # 4.10

# Average price
round(sum(//item/@price) div count(//item) * 100) div 100      # 17.08
```

#### Combined Function Examples
```xml
<!-- Sample XML -->
<products>
    <product id="1">
        <name>Widget A-123</name>
        <price currency="USD">599.99</price>
        <stock>5</stock>
    </product>
</products>
```

```xpath
# Find products low on stock with price over 500
//product[
    number(stock) < 10 and
    number(translate(price, '$,', '')) > 500
]/name

# Create formatted price display
concat(
    '$ ',
    format-number(number(//price), '#,##0.00')
)                                               # "$ 599.99"

# Extract product code from name
substring-after(
    normalize-space(//name),
    ' '
)                                               # "A-123"
```

#### Boolean Function Examples
```xml
<!-- Sample XML -->
<items>
    <item status="active" stock="0"/>
    <item status="inactive" stock="10"/>
</items>
```

```xpath
# Find out-of-stock active items
//item[@status='active' and not(number(@stock) > 0)]

# Check if any items are in stock
boolean(//item[number(@stock) > 0])

# Find inactive items with stock
//item[@status='inactive' and boolean(@stock)]
```

Remember:
- Functions can be nested for complex operations
- Type conversion is important for accurate calculations
- String functions are case-sensitive unless modified
- Numeric functions require proper number conversion
- Boolean functions are useful for complex conditions
