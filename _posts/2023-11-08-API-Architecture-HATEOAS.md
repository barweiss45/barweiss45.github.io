---
title: "HATEOAS - Hypermedia as the Engine of Application State"
author: "Barry Weiss"
layout: "post"
tags:
  - "REST API"
  - "Software Development"
---
**HATEOAS** stands for Hypermedia as the Engine of Application State. It's a constraint of the REST application architecture that keeps the RESTful style architecture unique from most other network application architectures.

To understand HATEOAS, you need to be familiar with the basic concept of REST (Representational State Transfer). REST is an architectural style for designing networked applications. It relies on a stateless, client-server, cacheable communications protocol -- and in virtually all cases, the HTTP protocol is used.

### The Concept of HATEOAS:

HATEOAS is a principle that empowers a RESTful API to control the navigation between resources by including hypermedia links with the responses. When a client interacts with such an API, it gets not only the requested data but also the controls (in the form of hyperlinks) to navigate to related resources.

### Relationship to REST APIs:

In a RESTful system, the server provides information dynamically through hypermedia, so the client does not need to hard-code the information about the structure and dynamics of the application. It's like browsing the web: you start at a URL, and you navigate through the application by clicking on links, which provide the next set of actions you can take.

### Practical Examples:

Let's say you have a REST API for a library system. Here's how HATEOAS might be implemented in a simple interaction:

1. **Getting a List of Books:**

   - Client sends a GET request to `http://api.library.com/books`.
   - Server responds with a list of books. Each book entity contains a URL to get more details about the book.

   ```json
   [
     {
       "name": "The Great Gatsby",
       "author": "F. Scott Fitzgerald",
       "uri": "/books/1"
     },
     {
       "name": "1984",
       "author": "George Orwell",
       "uri": "/books/2"
     }
   ]
   ```

2. **Getting Details of a Specific Book:**

   - Client chooses "The Great Gatsby" and sends a GET request to `http://api.library.com/books/1`.
   - Server responds with the details of "The Great Gatsby", including links to borrow the book or get recommendations for similar books.

   ```json
   {
     "name": "The Great Gatsby",
     "author": "F. Scott Fitzgerald",
     "published": "1925",
     "links": {
       "borrow": "/books/1/borrow",
       "recommendations": "/books/1/recommendations"
     }
   }
   ```

3. **Borrowing a Book:**

   - Client sends a POST request to `http://api.library.com/books/1/borrow` to borrow "The Great Gatsby".
   - Server responds with the status of the operation and includes links to return the book or extend the borrowing period.

   ```json
   {
     "status": "borrowed",
     "dueDate": "2023-12-01",
     "links": {
       "extendBorrowing": "/books/1/extend",
       "return": "/books/1/return"
     }
   }
   ```

In each of these steps, the client is guided by the links provided in the server's response. The client does not need to know the URI structure in advance; it dynamically discovers it through interactions. This decouples the client from the server, allowing the server to change its URI structure without breaking the clients, as long as it correctly informs the clients about the new URIs through hypermedia links.

HATEOAS makes the API self-descriptive and discoverable, and it is one of the key constraints that make an API truly RESTful. However, it's important to note that while HATEOAS is a principle of REST, not all APIs that claim to be RESTful implement HATEOAS. It's often considered an advanced REST feature and can be more complex to implement and consume compared to more straightforward REST APIs that do not use hypermedia controls.

Certainly! Below is a simple example of how you could implement a HATEOAS REST API using Python and Flask. This example will demonstrate a simple book service where you can get a list of books and individual book details with HATEOAS links.

First, you need to have Flask installed. If you haven't installed Flask yet, you can do so using pip:

```bash
pip install flask
```

Now, let's create a basic Flask application:

```python
from flask import Flask, jsonify, url_for

app = Flask(__name__)

# Mock data for our book catalog
books = [
    {'id': 1, 'title': 'The Great Gatsby', 'author': 'F. Scott Fitzgerald'},
    {'id': 2, 'title': '1984', 'author': 'George Orwell'},
    # Add more books as needed
]

def make_public_book(book):
    """
    Create a new book dictionary with added HATEOAS links.
    """
    new_book = {}
    for field in book:
        if field == 'id':
            new_book['uri'] = url_for('get_book', book_id=book['id'], _external=True)
        else:
            new_book[field] = book[field]
    new_book['links'] = [
        {'rel': 'self', 'href': new_book['uri']},
        {'rel': 'borrow', 'href': url_for('borrow_book', book_id=book['id'], _external=True)},
        # Add more links as needed
    ]
    return new_book

@app.route('/api/books', methods=['GET'])
def get_books():
    """
    Get a list of all books with HATEOAS links.
    """
    return jsonify([make_public_book(book) for book in books])

@app.route('/api/books/<int:book_id>', methods=['GET'])
def get_book(book_id):
    """
    Get a specific book with HATEOAS links.
    """
    book = next(filter(lambda b: b['id'] == book_id, books), None)
    if book:
        return jsonify(make_public_book(book))
    else:
        return jsonify({'error': 'Book not found'}), 404

@app.route('/api/books/<int:book_id>/borrow', methods=['POST'])
def borrow_book(book_id):
    """
    Dummy endpoint to demonstrate HATEOAS when borrowing a book.
    """
    # Here you would implement the logic to borrow a book.
    # For demonstration purposes, we'll just return a message.
    return jsonify({'message': f'Book {book_id} borrowed successfully!'})

if __name__ == '__main__':
    app.run(debug=True)
```

In this example:

- We have a list of books, each represented by a dictionary.
- The `make_public_book` function takes a book and generates a new dictionary for it, adding HATEOAS links using Flask's `url_for` function, which generates URLs for specific functions.
- The `get_books` endpoint returns a list of all books, each with its own HATEOAS links.
- The `get_book` endpoint returns details of a specific book, including HATEOAS links.
- The `borrow_book` endpoint is a placeholder for the action of borrowing a book. It's a `POST` endpoint, which would contain the logic to update the book's status to borrowed.

When you run this Flask application and make a GET request to `/api/books`, you'll receive a JSON response with a list of books, each with its own links to self and borrow actions. Similarly, a GET request to `/api/books/1` will give you the details of the book with ID 1, along with relevant HATEOAS links.

This is a basic example and doesn't include all RESTful practices (like proper status codes, authentication, etc.), but it should give you a good starting point for understanding how HATEOAS can be implemented in a Flask application.
