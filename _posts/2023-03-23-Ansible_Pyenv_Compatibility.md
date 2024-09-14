---
layout: post
title: Ansible Pyenv Compatibility
author: Barry
---

Ansible 2.10 uses galaxy
`pip install ansible-base`
**(must uninstall core if you need to upgrade to core)**

* need to install pylibssh

  ```bash
  pip install ansible-pylibssh
  ```

* need to use galaxy to add plugins now and must use complete FQDNs
* Must set interpreter in cfg is using pyenv have to use  
  * `--force-dep` on ansible-galaxy cisco.ios install

    ```bash
    ansible-galaxy collection install cisco.ios --force-with-deps
    ```

See [https://github.com/ansible/awx/issues/12578](https://github.com/ansible/awx/issues/12578).
