---
title: "Python - Understanding and Managing Cyclomatic Complexity in Python with flake8"
author: "Barry Weiss"
layout: "post"
tags:
  - "Python"
  - "Software Development"
---

Cyclomatic complexity is a crucial metric for understanding the maintainability of your code. In this guide, we’ll explore cyclomatic complexity, how flake8 can help identify complex functions and practical tips for keeping your code clean and maintainable.

## What is Cyclomatic Complexity?
Cyclomatic complexity measures the number of independent paths through a function or method. Every conditional statement (like `if`, `for`, `while`, or `try`) increases the number of potential execution paths, making the function harder to understand, test, and maintain.

### How is it Calculated?
Here’s a simple formula for cyclomatic complexity:

```
Cyclomatic Complexity = E - N + 2
```
- **E**: The number of edges in the control flow graph (representing paths).
- **N**: The number of nodes (representing statements or blocks of code).
- The result gives the number of decision points in the code.

## Using flake8 to Check Cyclomatic Complexity
flake8, a popular Python linting tool, includes a plugin called `flake8-complexity` that evaluates the cyclomatic complexity of your functions. You can configure it to enforce a maximum allowable complexity.

### Installation
If flake8 is not already installed:
```bash
pip install flake8
```

### Configuration
To set the maximum complexity in flake8, add the following line to your `setup.cfg`, `tox.ini`, or `.flake8` file:
```ini
[flake8]
max-complexity = <value>
```

Replace `<value>` with the maximum complexity level you’d like to enforce. When you run `flake8`, it analyzes your code and raises warnings for any function exceeding the specified complexity.

## Why Manage Cyclomatic Complexity?
High cyclomatic complexity can lead to:
- **Reduced readability:** Complex functions are harder to understand.
- **Difficult testing:** More paths require more test cases.
- **Fragile code:** Complex functions are harder to debug and maintain.

## How to Reduce Cyclomatic Complexity
Here are some practical ways to simplify your code:

1. **Split Large Functions**
   Break large functions into smaller, single-purpose functions.
   ```python
   # BEFORE
   def process_data(data):
       if data:
           for item in data:
               if item.valid():
                   process(item)
       else:
           log_error("No data")
   ```

   ```python
   # AFTER
   def process_data(data):
       if not data:
           log_error("No data")
           return
       for item in data:
           process_item_if_valid(item)

   def process_item_if_valid(item):
       if item.valid():
           process(item)
   ```

2. **Use Polymorphism or Strategy Pattern**
   Replace large `if`/`elif`/`else` chains with polymorphism or a strategy pattern.

3. **Leverage Early Returns**
   Reduce nesting by returning early from a function when a condition is met.
   ```python
   # BEFORE
   def process_input(data):
       if data:
           if data.is_valid():
               process(data)
   ```

   ```python
   # AFTER
   def process_input(data):
       if not data or not data.is_valid():
           return
       process(data)
   ```

4. **Refactor with Helper Functions**
   Extract reusable logic into helper functions.

5. **Avoid Deep Nesting**
   Refactor deeply nested loops or conditionals to improve readability.

Here’s how we can use **polymorphism** to decrease cyclomatic complexity and make the explanation part of your guide more practical and focused:

## Polymorphism to Decrease Complexity
Polymorphism allows you to reduce cyclomatic complexity by replacing large `if`/`elif`/`else` chains or repetitive logic with a cleaner, extensible design. Polymorphism delegates behavior to individual classes instead of manually checking types and applying specific behavior.

### Example Without Polymorphism
Suppose you have a function to calculate the area of different shapes, and you’re using `if` statements to determine the shape type:

```python
def calculate_area(shape):
    if shape["type"] == "circle":
        return 3.14 * shape["radius"] ** 2
    elif shape["type"] == "rectangle":
        return shape["width"] * shape["height"]
    elif shape["type"] == "triangle":
        return 0.5 * shape["base"] * shape["height"]
    else:
        raise ValueError("Unknown shape type")
```

### Problems
- The function grows as more shapes are added.
- Testing all branches becomes harder.
- It violates the **Open/Closed Principle**: you must modify the function when introducing a new shape.

### Refactored Code Using Polymorphism
Here’s how polymorphism can simplify this:

```python
class Shape:
    def area(self):
        raise NotImplementedError("Subclasses must implement the `area` method.")

class Circle(Shape):
    def __init__(self, radius):
        self.radius = radius

    def area(self):
        return 3.14 * self.radius ** 2

class Rectangle(Shape):
    def __init__(self, width, height):
        self.width = width
        self.height = height

    def area(self):
        return self.width * self.height

class Triangle(Shape):
    def __init__(self, base, height):
        self.base = base
        self.height = height

    def area(self):
        return 0.5 * self.base * self.height

# Using Polymorphism
shapes = [
    Circle(radius=5),
    Rectangle(width=4, height=6),
    Triangle(base=3, height=7),
]

for shape in shapes:
    print(f"The area of the {shape.__class__.__name__} is {shape.area():.2f}")
```

### Advantages of Polymorphism
1. **Reduced Complexity:** Each shape class encapsulates its own behavior, eliminating the need for complex conditionals.
2. **Extensibility:** Adding new shapes (e.g., `Square`) doesn’t require modifying existing code—just add a new class.
3. **Readability:** The loop is straightforward, and each class has a single responsibility.

### Result
Polymorphism simplifies your code, making it easier to read, test, and extend. By breaking down logic into smaller, self-contained pieces, you keep cyclomatic complexity in check while maintaining flexibility.

## Conclusion
Cyclomatic complexity is a powerful metric that helps balance functionality and maintainability in your code. By keeping complexity in check, you can write cleaner, easier-to-understand code that is simpler to test and maintain. Tools like flake8 make monitoring and managing cyclomatic complexity easy, enabling you to focus on writing elegant and efficient solutions.
