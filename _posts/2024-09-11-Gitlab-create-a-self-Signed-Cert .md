---
title: "GitLab: Create a self-signed Certificate for a self-contained lab"
layout: "post"
tags:
  - "Git"
---

> These Notes are based on a lab that I had to build. These instructions may or may not work for you depending on your situation.

Newer versions of Docker (>=20) will require the self-signed certificate to have a SAN (Subject Alternative Name). The SAN should be the URL name you are trying to access. If your registry is not the same URL as the GitLab Docker Repo Registry, ensure the SAN matches the URL.

If the GitLab Container Registry uses a different URL from your main GitLab instance, you must create a separate certificate for the registry and update the `gitlab.rb` file accordingly.

You must create certificates with a SAN, update the `gitlab.rb` file on the GitLab server to point to the correct files, and configure Docker to accept connections to insecure (self-signed) repositories.

## Creating the Certificate with a SAN

### Purpose of the `.cnf` File

The OpenSSL `.cnf` file is a configuration file that defines the parameters for certificate creation. It specifies details like the **Common Name (CN)**, **Subject Alternative Names (SAN)**, and whether the certificate can act as a **Certification Authority (CA)**. By using this configuration file, you ensure that the certificate generated has the correct attributes, such as SANs for multiple domain names or IP addresses, and whether the certificate is allowed to sign other certificates (if it's a CA).

#### Explanation of Each Section in the `.cnf`:

- **[req]:** This section defines the main configuration options for the certificate request (CSR). It refers to other sections for the distinguished name, subject alternative names, and X509 extensions.
- **[req_distinguished_name]:** This section defines the distinguished name, including the Common Name (CN), which is the main domain name (e.g., git.lab).
- **[v3_ca]:** This section defines the key usage and basic constraints. It's marking the certificate as a Certification Authority (CA) by setting CA:true. It also defines keyCertSign and cRLSign, which are key usages required for CA certificates. The subjectAltName directive lists the alternative domain names and IP addresses the certificate will cover.
- **[req_ext]:** This section is used when creating a Certificate Signing Request (CSR). Since you're generating a self-signed certificate, this is still relevant to ensure the SAN is included.
- **[alt_names]:** This section lists the Subject Alternative Names (SAN) for the certificate. It specifies the additional DNS names and IP addresses that the certificate should cover.

#### How the `.cnf` file works

When you use this configuration with OpenSSL, the subjectAltName will be properly set to include git.lab and the specified IP addresses (e.g., 127.0.0.1, 192.168.10.20).

The certificate will also be marked as a CA if you're generating a self-signed certificate with this config, meaning it can be used as a trusted certificate authority (which browsers expect when importing a self-signed certificate).

### Instructions to Create the self-signed certificate

1. **First, go to the `/etc/gitlab/ssl/` directory.** It will be best to run the rest of the commands in this directory.
   > ℹ️  I would recommend removing unnecessary certs, cnf, and key files that are not used. I would recommend appending them with the name `.old` and place in a sub-directory named archive.

   ```bash
   cd /etc/gitlab/ssl/
   ```

2. **Create an `openssl.cnf` file** on the GitLab server:

    Use your desired editor (Vim, Nano, etc.)

    ```bash
    $ vi git.lab.openssl.cnf
    ```

    Add the following:

    ```bash
    [req]
    distinguished_name = req_distinguished_name
    req_extensions = req_ext
    x509_extensions = v3_req
    prompt = no

    [req_distinguished_name]
    CN = git.lab

    [v3_ca]
    keyUsage = critical, keyCertSign, cRLSign
    basicConstraints = critical, CA:true
    subjectAltName = @alt_names

    [req_ext]
    subjectAltName = @alt_names

    [alt_names]
    DNS.1 = git.lab
    IP.1    = 127.0.0.1
    IP.2    = 192.168.10.20
    ```

3. **Generate the private key and signed certificate**:

    ```bash
    openssl req -x509 -nodes -days 1000 -newkey rsa:2048 \
    -keyout /etc/gitlab/ssl/git.lab.key \
    -out /etc/gitlab/ssl/git.lab.crt \
    -config git.lab.openssl.cnf
    ```

    This will generate:
    - git.lab.key: The private key.
    - git.lab.crt: The self-signed certificate.

4. **Verify the SAN field**:

    ```bash
    openssl x509 -text -noout -in git.lab.crt
    ```

    Sample Output:

    ```text
    Certificate:
        Data:
            Version: 3 (0x2)
            Serial Number:
                7e:42:54:4b:86:59:04:28:fc:af:2a:05:db:07:4e:41:7a:8c:3d:c1
            Signature Algorithm: sha256WithRSAEncryption
            Issuer: CN = git.lab
            Validity
                Not Before: Sep 12 19:49:44 2024 GMT
                Not After : Jun  9 19:49:44 2027 GMT
            Subject: CN = git.lab
            Subject Public Key Info:
                Public Key Algorithm: rsaEncryption
                    RSA Public-Key: (2048 bit)
            <--- Output Omitted -->>
    ```

5. **Set the Correct Permissions:**
   Set the appropriate permissions on your key and certificate files:

    ```bash
    sudo chmod 600 /etc/gitlab/ssl/git.lab.key
    sudo chmod 644 /etc/gitlab/ssl/git.lab.crt
    sudo chown root:root /etc/gitlab/ssl/git.lab.*
    ```

5. **Update the `gitlab.rb` file** to use the new SSL certificate:

    Edit `/etc/gitlab/gitlab.rb` to point to the new certificates:

    ```bash
    external_url "https://git.lab"
    nginx['ssl_certificate'] = "/etc/gitlab/ssl/git.lab.crt"
    nginx['ssl_certificate_key'] = "/etc/gitlab/ssl/git.lab.key"
    ```

6. If the **GitLab Container Registry** has a different URL (e.g., `registry.gitlab.local`), create a separate certificate following steps 1–4, and add the following to `gitlab.rb`:

    ```bash
    registry_external_url "https://registry.gitlab.local"
    registry_nginx['ssl_certificate'] = "/etc/gitlab/ssl/registry.crt"
    registry_nginx['ssl_certificate_key'] = "/etc/gitlab/ssl/registry.key"
    ```

6. **Reconfigure GitLab**:

    After making changes to `gitlab.rb`, reconfigure GitLab with:

    ```bash
    sudo gitlab-ctl reconfigure
    ```

7. **Check GitLab Configuration**:

    To check for any configuration issues after reconfiguring, run:

    ```bash
    sudo gitlab-ctl check-config
    ```

    This command verifies that the GitLab configuration is correct and ensures no major errors are present.

8. **Restart GitLab Services**:

    If you make any additional changes to the certificates or configuration files, restart GitLab services to apply the changes:

    ```bash
    sudo gitlab-ctl restart
    ```

    This will restart all GitLab services, including NGINX and the GitLab Runner.

9. **Verify status and Monitor Logs**:

    Verify GitLab services by running `gitlab-ctl status`:

   ```bash
   sudo gitlab-ctl status
   ```

   If there is an issue with NGINX finding your certificates, the service will show down. Ensure that `gitlab.rb` is correct. If issues persist, check the `nginx.conf` files for GitLab. Sometimes `gitlab-ctl reconfigure` doesn't update the `nginx.conf` file, so you may need to refer to GitLab's documentation.

   **Optional**: To monitor GitLab logs in real-time during or after reconfiguration, use the `tail` command to watch for any errors:

    ```bash
    sudo gitlab-ctl tail
    ```

    This will display live logs from GitLab services and help identify potential issues with NGINX or SSL.

10. **Transfer the certificate** to the student workstation (Jump Host):

    ```bash
    scp ./gitlab.crt student@192.168.0.10:~/gitlab.crt
    ```

11. **Install the certificate** on the student's workstation:

    ```bash
    sudo cp ~/gitlab.crt /usr/local/share/ca-certificates/git.lab.crt
    sudo chmod 644 /usr/local/share/ca-certificates/git.lab.crt
    sudo update-ca-certificates --fresh
    ```

12. **Verify the certificate installation**:

    ```bash
    ll /etc/ssl/certs/git.lab.pem
    ```

## Configure Gitlab-Runner

**NOTE**: If the `.crt` file uses the same name as the URL then the gitlab-runner application will use this cert found in the `/etc/gitlab-runner/certs/` directory. Otherwise, you will need to update the `config.toml` in the `gitlab-runner` directory with the following:

  ```toml
  [[runners]]
     tls-ca-file = "/etc/gitlab-runner/certs/git.lab.crt"
  ```

1. Copy the `git.lab.crt` to `/etc/gitlab-runner/certs/` directory.

   ```bash
   sudo cp /etc/gitlab/ssl/git.lab.crt /etc/gitlab-runner/certs/
   ```

2. Update the System CA Store by adding the new git.lab.crt to the system CA store:

   ```bash
   sudo cp /etc/gitlab/ssl/git.lab.crt /usr/local/share/ca-certificates/
   sudo update-ca-certificates
   ```

3. Restart GitLab Runner:

   ```bash
   sudo gitlab-runner restart
   ```

4. Verify that the runner works with the new certificate:

   ```bash
   gitlab-runner verify
   ```

## Configure Docker to Trust the Self-Signed Certificate

On the student workstation, Docker must be configured to trust the GitLab registry using the self-signed certificate.

1. **Create a directory for Docker to store the certificate**:

    ```bash
    sudo mkdir -p /etc/docker/certs.d/git.lab:443
    ```

    If the **GitLab Container Registry** uses a separate URL, repeat this process for the registry:

    ```bash
    sudo mkdir -p /etc/docker/certs.d/registry.git.lab:443
    ```

2. **Copy the certificate** to this directory:

    ```bash
    sudo cp /usr/local/share/ca-certificates/registry.git.lab.crt /etc/docker/certs.d/git.lab:443/ca.crt
    ```

3. **Update Docker's `daemon.json` file** to include the GitLab registry as an insecure registry:

    Edit the file `/etc/docker/daemon.json` (or create it if it doesn’t exist):

    ```bash
    sudo nano /etc/docker/daemon.json
    ```

    Add the following configuration (if the file already contains other configurations, add this inside the existing JSON structure):

    ```json
    {
      "insecure-registries": ["registry.git.lab:443"]
    }
    ```

    If you have a separate URL for the GitLab Container Registry, add it as well:

    ```json
    {
      "insecure-registries": ["dev.gitlab.local:443", "registry.git.lab:443"]
    }
    ```

4. **Restart Docker** to apply the changes:

    ```bash
    sudo service docker restart
    ```

## Configure GitLab Runner to Use the Self-Signed Certificate

1. **Copy the certificate** to the GitLab Runner's trusted certificate directory:

    ```bash
    sudo cp /etc/gitlab/ssl/gitlab.crt /etc/gitlab-runner/certs/gitlab.crt
    ```

2. **Restart the GitLab Runner service**:

    ```bash
    sudo gitlab-runner restart
    ```

## Troubleshooting

### Common Issues and Fixes

- **Certificate Not Trusted**:
  If you encounter certificate issues on the student workstation, ensure the `gitlab.crt` is located in `/usr/local/share/ca-certificates/` and rerun:

  ```bash
  sudo update-ca-certificates --fresh
  ```

  Then, verify that the symlink in `/etc/ssl/certs` exists.

- **Docker Certificate Error**:
  Ensure Docker is configured correctly for the insecure registry by checking if the certificate is present in `/etc/docker/certs.d/<gitlab-url>:443/ca.crt`. If the registry uses a different URL, confirm that the correct URL is used for the certificate. Also, ensure that the registry is listed in `daemon.json` as an insecure registry.

- **GitLab Runner Error**:
  If the GitLab Runner has issues with the certificate, ensure the certificate is copied into `/etc/gitlab-runner/certs/`. Restart the GitLab Runner and verify its connection to the GitLab server.

    ```bash
    sudo gitlab-runner verify
    ```

- **Port or URL Mismatch**:
  Ensure that the URL and ports in your GitLab setup match the SAN in the certificate and that Docker or the GitLab Runner are attempting to connect to the correct address.

- **Checking Logs**:
  Use `gitlab-ctl tail` to monitor the logs and look for errors if any issues arise after configuration or restarts.

    ```bash
    sudo gitlab-ctl tail
    ```
