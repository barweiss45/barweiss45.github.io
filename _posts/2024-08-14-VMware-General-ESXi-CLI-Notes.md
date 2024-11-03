---
title: "VMWare - General CLI Notes"
layout: "post"
author: "Barry Weiss"
tags:
  - "VMWare"
---

A handy set of VMware ESXi CLI commands to make life easier. These notes cover common tasks like clearing ARP caches, enabling promiscuous mode on vSwitches, managing port groups, and adding vNICs to VMs—all from the command line.

Whether you're fixing network issues or tweaking VM settings, this collection has you covered with practical, easy-to-follow steps.

This version keeps it brief and to the point with a casual tone! How’s that?

## Clear Arp

To clear the ARP cache on a vSwitch in an ESXi host, you can follow these steps:

1. **Access the ESXi Host via SSH**:
   - Use an SSH client to log in to your ESXi host as the root user.

2. **List the ARP Cache**:
   - First, you can list the current ARP cache entries to see what's currently stored. You can use the command:

     ```shell
     esxcli network ip neighbor list
     ```

   - This will display the ARP table for the ESXi host.

3. **Clear the ARP Cache**:

   - Unlike traditional Linux systems where you can clear the ARP cache directly with commands like `ip -s -s neigh flush all`, ESXi does not have a direct command to clear the ARP cache. Instead, you can reset the network interface or reboot the host to clear the ARP cache.

   - **Restarting the Management Network**:
     - You can restart the management network, which should clear the ARP cache:

       ```shell
       /etc/init.d/hostd restart
       /etc/init.d/vpxa restart
       ```

     - Alternatively, you can use:

       ```shell
       esxcli network restart
       ```

4. **Restarting the Entire Host** (Last Resort):
   - If clearing the ARP cache is critical and restarting the management network doesn't work, you may need to reboot the ESXi host.

Remember to perform these actions during a maintenance window or ensure that you have backup connectivity to the ESXi host, as these actions might cause temporary network disruption.

To enable promiscuous mode on a vSwitch in an ESXi host and then verify it via the command line, you can follow these steps:

## Enable Promiscuous Mode on the vSwitch

### Via vSphere Web Client

1. **Login to the vSphere Web Client**.
2. **Navigate to the ESXi Host** where the vSwitch is located.
3. **Go to "Networking"** -> **"Virtual Switches"**.
4. **Select the vSwitch** you want to modify.
5. Click on **"Edit Settings"**.
6. Under **"Security"**, you’ll find the options for **Promiscuous Mode**, **MAC Address Changes**, and **Forged Transmits**.
7. **Set Promiscuous Mode to "Accept"**.
8. Click **"OK"** to apply the changes.

### Via ESXi Command Line

1. **Access the ESXi Host via SSH**:
   - Log in to your ESXi host using an SSH client.

2. **Enable Promiscuous Mode**:
   - Use the following command to enable promiscuous mode on the vSwitch (replace `vSwitchName` with the name of your vSwitch):

     ```shell
     esxcli network vswitch standard policy security set -v vSwitchName --allow-promiscuous=1
     ```

   - If you need to enable it on a specific port group, use:

     ```shell
     esxcli network vswitch standard portgroup policy security set -p PortGroupName --allow-promiscuous=1
     ```

### Verify Promiscuous Mode via Command Line

To verify that promiscuous mode is enabled on the vSwitch, you can use the following commands:

1. **Verify for a vSwitch**:

   ```shell
   esxcli network vswitch standard policy security get -v vSwitchName
   ```

   - Look for the line that says `Allow Promiscuous: true`.

2. **Verify for a Port Group**:

   ```shell
   esxcli network vswitch standard portgroup policy security get -p PortGroupName
   ```

   - Again, check for `Allow Promiscuous: true`. This will confirm whether promiscuous mode is enabled or not.

## Disable Promiscuous Mode on a vSwitch

To disable promiscuous mode on a vSwitch, use the following command:

```shell
esxcli network vswitch standard policy security set -v vSwitchName --allow-promiscuous=0
```

Replace `vSwitchName` with the name of the vSwitch where you want to disable promiscuous mode.

### Disable Promiscuous Mode on a Port Group

To disable promiscuous mode on a specific port group, use the following command:

```shell
esxcli network vswitch standard portgroup policy security set -p PortGroupName --allow-promiscuous=0
```

Replace `PortGroupName` with the name of the port group where you want to disable promiscuous mode.

### Verify Promiscuous Mode Status

To verify that promiscuous mode has been disabled, you can use the following commands:

- For a vSwitch:

  ```shell
  esxcli network vswitch standard policy security get -v vSwitchName
  ```

- For a port group:

  ```shell
  esxcli network vswitch standard portgroup policy security get -p PortGroupName
  ```

Check the output for the line `Allow Promiscuous: false` to confirm that promiscuous mode has been disabled.

To find out which port groups are assigned to which vSwitch in an ESXi host via the command line, you can use the following commands:

### List All vSwitches and Associated Port Groups

To list all vSwitches along with their associated port groups:

```shell
esxcli network vswitch standard list
```

This command will provide detailed information about each vSwitch, including the port groups that are associated with them.

### List Port Groups with Their Corresponding vSwitch

If you want to list the port groups along with the vSwitch they are assigned to:

```shell
esxcli network vswitch standard portgroup list
```

This will output a list showing each port group and the vSwitch it belongs to.

### Example Output

The output might look something like this:

```shell
Name                    Virtual Switch   Active Clients
----------------------- ---------------  --------------
Management Network      vSwitch0         1
VM Network              vSwitch0         0
Production              vSwitch1         3
Backup                  vSwitch2         2
```

### Detailed Information for a Specific vSwitch

To get detailed information about a specific vSwitch, including all associated port groups:

```shell
esxcli network vswitch standard list --vswitch-name=vSwitchName
```

Replace `vSwitchName` with the name of the vSwitch you're interested in.

## Add a vNIC

To add a new virtual network interface card (vNIC) to a guest virtual machine (VM) and assign a port group to it using the command-line interface (CLI) in ESXi, you can follow these steps:

### Via CLI

1. **Access the ESXi Shell or SSH into the ESXi Host:**
   - You need to have SSH access to your ESXi host or be able to use the ESXi Shell directly.

2. **Identify the VM and Port Group:**
   - First, you need to identify the VM and the port group you want to use. You can list the VMs and port groups using the following commands:

     ```bash
     vim-cmd vmsvc/getallvms | grep <VM NAME> | awk '{print $1, $2}'
     esxcli network vswitch standard portgroup list
     ```

3. **Add a New vNIC to the VM:**
   - Use the `vim-cmd` command to add a new network adapter to the VM. Replace `<vmid>` with the VM ID obtained from the previous step and `<portgroup>` with the name of the port group.

     ```sh
     vim-cmd vmsvc/device.createnic <vmid> "vmxnet3" "<portgroup>"
     ```

4. **Verify the Configuration:**
   - After adding the vNIC, you can verify the configuration by checking the VM's network settings.

     ```sh
     vim-cmd vmsvc/device.getdevices <vmid>
     ```

### Example

Assuming you have a VM with ID `1` and you want to add a vNIC to the port group named `VM Network`:

1. **List VMs and Port Groups:**

   ```sh
   vim-cmd vmsvc/getallvms
   esxcli network vswitch standard portgroup list
   ```

2. **Add the vNIC:**

   ```sh
   vim-cmd vmsvc/device.createnic 1 "vmxnet3" "VM Network"
   ```

3. **Verify the Configuration:**

   ```sh
   vim-cmd vmsvc/device.getdevices 1
   ```

This will add a new vNIC of type `vmxnet3` to the VM with ID `1` and assign it to the port group `VM Network`.

### Notes

- Ensure you have the necessary permissions to perform these actions.
- The `vmxnet3` adapter type is used in this example. You can choose other types like `e1000` or `e1000e` based on your requirements.
- Always back up your VM configuration before making changes.

## List all Portgroups

```bash
esxcli network vswitch standard portgroup list
```

## Script

```sh
unset vmid

_vm="5915-Mark-PC"

_vim_output="$(vim-cmd vmsvc/getallvms | grep $_vm | awk '{print $1, $2}')"

echo "$_vim_output"

vmid="$( echo $_vim_output | grep -o '^[0-9]*')"

# vim-cmd vmsvc/devices.createnic "$vmid" "vmxnet3" "Default Network"

vim-cmd vmsvc/devices.createnic "$vmid" "e1000" "Default Network"
vim-cmd vmsvc/device.getdevices "$vmid" | grep -A 26 -E "VirtualE1000|VirtualVmxnet3" | grep -E "label|deviceName|macAddress" | awk '
 BEGIN {
     print "Label", "\t\t\t", "Device Name", "\t", "MAC Address"
     print "------------------------------------------------------------"
 }
 {
     if ($1 == "label") {        label = substr($0, index($0, "=") + 3, length($0) - index($0, "=") - 3)
     }
     else if ($1 == "deviceName") {        deviceName = substr($0, index($0, "=") + 3, length($0) - index($0, "=") - 3)    }
     else if ($1 == "macAddress") {
         macAddress = substr($0, index($0, "=") + 2, length($0) - index($0, "=") - 2)
         print label, "\t", deviceName, "\t", macAddress
     }
 }'


vim-cmd vmsvc/get.config $vmid | grep -A 1 -E "isolation\.tools|answer\.msg|uuid\.action"
vim-cmd vmsvc/get.config $vmid | grep -A 1 -E "isolation\.tools|answer\.msg\.uuid|answer\.msg\.serial|uuid\.action"
vim-cmd vmsvc/power.shutdown $vmid

cd /vmfs/volumes/datastore/$_vm
echo 'answer.msg.serial.file.open = "replace"' >> "$_vm.vmx"

vim-cmd vmsvc/power.on $vmid
```
