---
title: "Using `tcpdump` for Ubuntu 20.04 and up"
layout: post
---

## Basic tcp/udp Port Capture on any Interface

- TCP port capture
  - This captures traffic to any interface from **any** source and does not try to resolve the interface name.

   ```bash
   sudo tcpdump -ni any 'tcp port PORT NUMBER'
   ```

- UDP port capture
  - This captures traffic to any interface from **any** source and does not try to resolve the interface name.

   ```bash
   sudo tcpdump -ni any 'udp port PORT NUMBER'
   ```

## `tcpdump` checking for HTTP and HTTPS traffic reaching a server

To see if HTTP or HTTPS traffic is reaching a server using tcpdump, you can filter the traffic for TCP protocol on ports 80 (HTTP) and 443 (HTTPS). Here's the command you can use:

```bash
sudo tcpdump -ni any 'tcp port 80 or tcp port 443'
```

* `-n`: Don't convert addresses (i.e., IP addresses, port numbers) to names.
* `-i any`: Listen on all network interfaces.
* `'tcp port 80 or tcp port 443'`: Filter for the TCP protocol on ports 80 (HTTP) and 443 (HTTPS).

## Explanation

When you run the command, you should see output lines for each HTTP or HTTPS request that reaches the server.

This command captures all traffic on these ports, including both request (incoming) and response (outgoing) packets. If you want to distinguish between incoming and outgoing traffic, you can further refine the filter. But for general monitoring of both HTTP and HTTPS traffic reaching the server, the 
above command should suffice.

You can use the `tcpdump` command-line utility to capture and analyze network packets. To capture HTTP traffic on a specific network (172.20.0.0/24), you can use the following command:

```bash
sudo tcpdump -i [interface] 'tcp port 80 and net 172.20.0.0/24'
```

Here:

- `-i [interface]` specifies the network interface to listen on. Replace `[interface]` with the name of the network interface you want to listen on. For example, `eth0` or `wlan0`.
- `'tcp port 80 and net 172.20.0.0/24'` is a capture filter that tells `tcpdump` to capture only TCP packets on port 80 (which is the standard port for HTTP traffic) and only for the network 172.20.0.0/24.

If you also want to capture HTTPS traffic, which usually operates over TCP port 443, you can modify the command as follows:

```bash
sudo tcpdump -i [interface] 'tcp port (80 or 443) and net 172.20.0.0/24'
```

Remember to replace `[interface]` with the appropriate interface name.

**Note**: Capturing network packets may require administrative permissions, so `sudo` is used. Always ensure you have proper authorization to capture network traffic in any environment.

## Getting a Ping Capture

To see if a `ping` (ICMP echo request) is reaching a server using `tcpdump`, you can filter the traffic for ICMP protocol. Here's the command you can use:

```bash
sudo tcpdump -ni any icmp and icmp[icmptype]=icmp-echo
```

Explanation:

- `-n`: Don't convert addresses (i.e., IP addresses, port numbers) to names.
- `-i any`: Listen on all network interfaces.
- `icmp`: Filter for the ICMP protocol.
- `icmp[icmptype]=icmp-echo`: Filter specifically for ICMP echo requests (which is what a `ping` sends).

When you run the command and send a `ping` to the server, you should see output lines for each `ping` request that reaches the server.

Remember, if the server replies to the ping, you will also see ICMP echo reply packets. If you want to capture those as well, you can modify the filter, or simply use `icmp` by itself to capture all ICMP traffic.

To observe how your Ubuntu server is responding to a `traceroute` from another host, you would want to capture ICMP (Internet Control Message Protocol) packets, which are typically used by the `traceroute` tool.

1. **Basic Capture**:

   ```bash
   sudo tcpdump -i any -n icmp
   ```

   This will capture all ICMP packets on all interfaces. The `-n` option prevents `tcpdump` from performing DNS lookups on the IP addresses.

2. **If the `traceroute` is using UDP** (as is typical for Linux-based `traceroute`):

   ```bash
   sudo tcpdump -i any -n udp and portrange 33434-33534
   ```

   By default, Linux's `traceroute` sends UDP packets starting from port 33434. It increments the port for each subsequent probe. The range 33434-33534 is typical, but it could vary. Adjust as needed based on the behavior of the specific `traceroute` implementation.

3. **To write the output to a file** (for later analysis):

   ```bash
   sudo tcpdump -i any -n -w /path/to/outputfile.pcap icmp
   ```

   This will capture the ICMP packets and write them to `outputfile.pcap`, which you can later analyze with tools like Wireshark.

4. **To limit the capture to a specific source IP** (e.g., the IP of the host from which you're running `traceroute`):

   ```bash
   sudo tcpdump -i any -n src host [source_IP] and icmp
   ```

Replace `[source_IP]` with the IP address of the host running `traceroute`.

Remember, when you run `tcpdump`, it will continue capturing until you stop it. Use `Ctrl+C` to stop the capture once you're done.

Sure, let's adjust this for HTTP (port 80) and HTTPS (port 443) traffic:
