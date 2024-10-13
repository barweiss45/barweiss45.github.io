---
title: "Linux - Using the `dig` (Domain Information Groper) Command"
layout: "post"
author: "Barry Weiss"
tags:
  - "Linux"
---

The `dig` (Domain Information Groper) command is a network administration command-line tool for querying Domain Name System (DNS) servers. It is commonly used to troubleshoot DNS problems and to perform DNS lookups.

Here's a cheat sheet for the `dig` command along with some common usages and example outputs:

## Basic Syntax

```bash
dig [@server] [name] [type] [options]
```

- `@server`: The DNS server to query (optional).
- `name`: The domain name to query.
- `type`: The type of DNS record to query (e.g., A, MX, NS, etc.).
- `options`: Additional options to modify the command's behavior.

## Common Usages

1. **Basic A Record Lookup**

   ```bash
   dig example.com
   ```

   **Example Output:**

   ```bash
   ; <<>> DiG 9.11.3-1ubuntu1.13-Ubuntu <<>> example.com
   ;; global options: +cmd
   ;; Got answer:
   ;; ->>HEADER<<- opcode: QUERY, status: NOERROR, id: 12345
   ;; flags: qr rd ra; QUERY: 1, ANSWER: 1, AUTHORITY: 0, ADDITIONAL: 1

   ;; QUESTION SECTION:
   ;example.com.                   IN      A

   ;; ANSWER SECTION:
   example.com.            3600    IN      A       93.184.216.34

   ;; Query time: 20 msec
   ;; SERVER: 8.8.8.8#53(8.8.8.8)
   ;; WHEN: Mon Oct 11 12:34:56 UTC 2021
   ;; MSG SIZE  rcvd: 56
   ```

2. **Query a Specific DNS Server**

   ```bash
   dig @8.8.8.8 example.com
   ```

   **Example Output:**

   ```bash
   ; <<>> DiG 9.11.3-1ubuntu1.13-Ubuntu <<>> @8.8.8.8 example.com
   ; (1 server found)
   ;; global options: +cmd
   ;; Got answer:
   ;; ->>HEADER<<- opcode: QUERY, status: NOERROR, id: 54321
   ;; flags: qr rd ra; QUERY: 1, ANSWER: 1, AUTHORITY: 0, ADDITIONAL: 1

   ;; QUESTION SECTION:
   ;example.com.                   IN      A

   ;; ANSWER SECTION:
   example.com.            3600    IN      A       93.184.216.34

   ;; Query time: 30 msec
   ;; SERVER: 8.8.8.8#53(8.8.8.8)
   ;; WHEN: Mon Oct 11 12:35:56 UTC 2021
   ;; MSG SIZE  rcvd: 56
   ```

3. **Query for MX Records**

   ```bash
   dig example.com MX
   ```

   **Example Output:**

   ```bash
    ; <<>> DiG 9.11.3-1ubuntu1.13-Ubuntu <<>> example.com MX
    ;; global options: +cmd
    ;; Got answer:
    ;; ->>HEADER<<- opcode: QUERY, status: NOERROR, id: 67890
    ;; flags: qr rd ra; QUERY: 1, ANSWER: 2, AUTHORITY: 0, ADDITIONAL: 3

    ;; QUESTION SECTION:
    ;example.com.                   IN      MX

    ;; ANSWER SECTION:
    example.com.            3600    IN      MX      10 mail.example.com.
    example.com.            3600    IN      MX      20 mail2.example.com.

    ;; Query time: 40 msec
    ;; SERVER: 8.8.8.8#53(8.8.8.8)
    ;; WHEN: Mon Oct 11 12:36:56 UTC 2021
    ;; MSG SIZE  rcvd: 100
   ```

4. **Query for NS Records**

   ```bash
   dig example.com NS
   ```

   **Example Output:**

   ```bash
   ; <<>> DiG 9.11.3-1ubuntu1.13-Ubuntu <<>> example.com NS
   ;; global options: +cmd
   ;; Got answer:
   ;; ->>HEADER<<- opcode: QUERY, status: NOERROR, id: 13579
   ;; flags: qr rd ra; QUERY: 1, ANSWER: 2, AUTHORITY: 0, ADDITIONAL: 1

   ;; QUESTION SECTION:
   ;example.com.                   IN      NS

   ;; ANSWER SECTION:
   example.com.            3600    IN      NS      ns1.example.com.
   example.com.            3600    IN      NS      ns2.example.com.

   ;; Query time: 50 msec
   ;; SERVER: 8.8.8.8#53(8.8.8.8)
   ;; WHEN: Mon Oct 11 12:37:56 UTC 2021
   ;; MSG SIZE  rcvd: 80
   ```

5. **Query for TXT Records**

   ```bash
   dig example.com TXT
   ```

   **Example Output:**

   ```bash
   ; <<>> DiG 9.11.3-1ubuntu1.13-Ubuntu <<>> example.com TXT
   ;; global options: +cmd
   ;; Got answer:
   ;; ->>HEADER<<- opcode: QUERY, status: NOERROR, id: 24680
   ;; flags: qr rd ra; QUERY: 1, ANSWER: 1, AUTHORITY: 0, ADDITIONAL: 1

   ;; QUESTION SECTION:
   ;example.com.                   IN      TXT

   ;; ANSWER SECTION:
   example.com.            3600    IN      TXT     "v=spf1 include:_spf.example.com ~all"

   ;; Query time: 60 msec
   ;; SERVER: 8.8.8.8#53(8.8.8.8)
   ;; WHEN: Mon Oct 11 12:38:56 UTC 2021
   ;; MSG SIZE  rcvd: 80
   ```

6. **Query for CNAME Records**

   ```bash
   dig www.example.com CNAME
   ```

   **Example Output:**

   ```bash
   ; <<>> DiG 9.11.3-1ubuntu1.13-Ubuntu <<>> www.example.com CNAME
   ;; global options: +cmd
   ;; Got answer:
   ;; ->>HEADER<<- opcode: QUERY, status: NOERROR, id: 11223
   ;; flags: qr rd ra; QUERY: 1, ANSWER: 1, AUTHORITY: 0, ADDITIONAL: 1

   ;; QUESTION SECTION:
   ;www.example.com.               IN      CNAME

   ;; ANSWER SECTION:
   www.example.com.        3600    IN      CNAME   example.com.

   ;; Query time: 70 msec
   ;; SERVER: 8.8.8.8#53(8.8.8.8)
   ;; WHEN: Mon Oct 11 12:39:56 UTC 2021
   ;; MSG SIZE  rcvd: 80
   ```

### Additional Options

- **+short**: Provides a concise output.

  ```bash
  dig example.com +short
  ```

  **Example Output:**

  ```bash
  93.184.216.34
  ```

- **+trace**: Traces the path to the authoritative DNS server.

  ```bash
  dig example.com +trace
  ```

  **Example Output:**

  ```bash
  ; <<>> DiG 9.11.3-1ubuntu1.13-Ubuntu <<>> example.com +trace
  ;; global options: +cmd
  .                       518400  IN      NS      a.root-servers.net.
  .                       518400  IN      NS      b.root-servers.net.
  ...
  example.com.            172800  IN      NS      ns1.example.com.
  example.com.            172800  IN      NS      ns2.example.com.
  ns1.example.com.        172800  IN      A       192.0.2.1
  example.com.            3600    IN      A       93.184.216.34
  ```

- **+noall +answer**: Shows only the answer section.

  ```bash
  dig example.com +noall +answer
   ```

  **Example Output:**

  ```bash
  example.com.            3600    IN      A       93.184.216.34
  ```

## Validating and Tracing an A record

Using the `dig` command to validate an A record and trace it out:

### Validating an A Record

To validate an A record, you can use the `dig` command to query the DNS server for the A record of a specific domain.

#### Basic A Record Lookup

```bash
dig example.com A
```

**Example Output:**

```bash
; <<>> DiG 9.11.3-1ubuntu1.13-Ubuntu <<>> example.com A
;; global options: +cmd
;; Got answer:
;; ->>HEADER<<- opcode: QUERY, status: NOERROR, id: 12345
;; flags: qr rd ra; QUERY: 1, ANSWER: 1, AUTHORITY: 0, ADDITIONAL: 1

;; QUESTION SECTION:
;example.com.                   IN      A

;; ANSWER SECTION:
example.com.            3600    IN      A       93.184.216.34

;; Query time: 20 msec
;; SERVER: 8.8.8.8#53(8.8.8.8)
;; WHEN: Mon Oct 11 12:34:56 UTC 2021
;; MSG SIZE  rcvd: 56
```

#### Concise Output

To get a concise output showing only the IP address:

```bash
dig example.com A +short
```

**Example Output:**

```bash
93.184.216.34
```

### Tracing the A Record

To trace the path to the authoritative DNS server for an A record, you can use the `+trace` option.

#### Trace the DNS Path

```bash
dig example.com +trace
```

**Example Output:**

```bash
; <<>> DiG 9.11.3-1ubuntu1.13-Ubuntu <<>> example.com +trace
;; global options: +cmd
.                       518400  IN      NS      a.root-servers.net.
.                       518400  IN      NS      b.root-servers.net.
...
example.com.            172800  IN      NS      ns1.example.com.
example.com.            172800  IN      NS      ns2.example.com.
ns1.example.com.        172800  IN      A       192.0.2.1
example.com.            3600    IN      A       93.184.216.34
```

### Additional Useful Options

- **+noall +answer**: Shows only the answer section.

  ```bash
  dig example.com A +noall +answer
  ```

  **Example Output:**

  ```bash
  example.com.            3600    IN      A       93.184.216.34
  ```

- **@server**: Query a specific DNS server.

  ```bash
  dig @8.8.8.8 example.com A
  ```

  **Example Output:**

  ```bash
  ; <<>> DiG 9.11.3-1ubuntu1.13-Ubuntu <<>> @8.8.8.8 example.com A
  ; (1 server found)
  ;; global options: +cmd
  ;; Got answer:
  ;; ->>HEADER<<- opcode: QUERY, status: NOERROR, id: 54321
  ;; flags: qr rd ra; QUERY: 1, ANSWER: 1, AUTHORITY: 0, ADDITIONAL: 1

  ;; QUESTION SECTION:
  ;example.com.                   IN      A

  ;; ANSWER SECTION:
  example.com.            3600    IN      A       93.184.216.34

  ;; Query time: 30 msec
  ;; SERVER: 8.8.8.8#53(8.8.8.8)
  ;; WHEN: Mon Oct 11 12:35:56 UTC 2021
  ;; MSG SIZE  rcvd: 56
  ```

### Summary

- **Validate A Record:**

  ```bash
  dig example.com A
  dig example.com A +short
  ```

- **Trace A Record:**

  ```bash
  dig example.com +trace
  ```

- **Additional Options:**

  ```bash
  dig example.com A +noall +answer
  dig @8.8.8.8 example.com A
  ```
