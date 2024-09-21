---
title: "VXLAN with BGP EVPN"
layout: post
---

**EVPN (Ethernet VPN)** with **VXLAN (Virtual Extensible LAN)** is a network virtualization technology that allows you to extend Layer 2 networks across Layer 3 boundaries. This is particularly useful in data center environments for creating scalable and flexible network architectures. 

### Key Components

1. **VNI (VXLAN Network Identifier)**:
   - A 24-bit identifier used to identify a specific VXLAN segment.
   - Similar to a VLAN ID, but it allows for up to 16 million unique segments, compared to 4096 VLANs.

2. **VN-Segment**:
   - A term sometimes used interchangeably with VNI, referring to a specific VXLAN segment.

3. **NVE (Network Virtualization Edge)**:
   - The interface on a network device (like a Nexus switch) that handles VXLAN encapsulation and decapsulation.
   - Typically implemented as a logical interface on the switch.

4. **VTEP (VXLAN Tunnel Endpoint)**:
   - The device (or interface) that encapsulates and decapsulates VXLAN traffic.
   - Each VTEP has an IP address used for routing VXLAN traffic over the IP network.

### Supporting Components

1. **MP-BGP (Multiprotocol BGP)**:
   - Used for distributing EVPN routes. MP-BGP allows for the exchange of EVPN information between VTEPs.
   - Ensures that MAC addresses and IP addresses are distributed efficiently across the network.

2. **Control Plane**:
   - EVPN provides a control plane for VXLAN. Instead of relying on flood-and-learn mechanisms, EVPN uses MP-BGP to exchange MAC and IP information.

3. **Data Plane**:
   - VXLAN is the data plane encapsulation mechanism that carries Ethernet frames in IP packets.

### Configuration Steps

#### Leaf Switch

1. **Enable Features**:

   ```bash
   feature bgp
   feature nv overlay
   feature vn-segment-vlan-based
   ```

2. **Create a VXLAN VLAN**:

   ```bash
   vlan 10
     vn-segment 5000
   ```

3. **Advertise VNI with BGP**:

   ```bash
   evpn
     vni 5000 l2
     rd auto
     route-target both auto
   ```

3. **Configure the NVE Interface**:
   **NOTE** For VXLAN EVPN ingress replication, the VXLAN VTEP uses a list of IP addresses of other VTEPs in the network to send BUM (broadcast, unknown unicast and multicast) traffic. These IP addresses are exchanged between VTEPs through the BGP EVPN control plane.

   The following are required before configuring VXLAN EVPN ingress replication on the NVE interface:
   - Enable VXLAN.
   - Configure VLAN and VXLAN VNI.
   - Configure BGP on the VTEP.
   - Configure RD and Route Targets for VXLAN Bridging.

   ```bash
   interface nve1
     no shutdown
     source-interface loopback1
     member vni 5000
       ingress-replication protocol bgp
   ```

### Spine

To build the VXLAN tunnels VXLAN is not configured on the spine, but the underlay network must be set up with MP-BGP to exchange VXLAN routes in the l2vpn evpn address family.

### Key Points

- **NVE Interface**: This is where VXLAN encapsulation and decapsulation happen.
- **VNI**: Identifies the VXLAN segment, allowing isolation of traffic similar to VLANs but with a much larger scale.
- **MP-BGP**: Used for the EVPN control plane, distributing MAC and IP information.
- **VLAN to VNI Mapping**: Ties traditional VLANs to VXLAN VNIs, allowing seamless integration with existing Layer 2 domains.

## Comparing VXLAN EVPN to L3VPN MPLS and VPLS

VPN-VXLAN shares many concepts with VPLS (Virtual Private LAN Service) and L3VPN (Layer 3 VPN) MPLS. Here is a comparison to highlight the similarities and differences:

### Similarities

1. **Network Segmentation**:
   - Both EVPN-VXLAN and VPLS/L3VPN MPLS provide mechanisms to create isolated, virtualized network segments for different customers or services.
   - VRFs are used in both to maintain separate routing tables and ensure traffic isolation.

2. **Route Distinguishers (RDs) and Route Targets (RTs)**:
   - RDs and RTs are used in both EVPN and MPLS VPNs to distinguish and control the distribution of routes.
   - RDs make routes unique within the provider's network, while RTs control which routes are imported and exported between VRFs.

3. **Use of BGP**:
   - MP-BGP (Multiprotocol BGP) is used in both technologies for distributing routing information.
   - In EVPN-VXLAN, MP-BGP distributes MAC and IP addresses, while in L3VPN MPLS, it distributes IP prefixes.

4. **Overlay Networks**:
   - Both technologies use overlay networks to provide Layer 2 or Layer 3 services over a Layer 3 underlay.
   - VXLAN encapsulates Layer 2 frames in IP packets, while MPLS encapsulates Layer 2 or Layer 3 packets with MPLS labels.

### Differences

1. **Encapsulation Method**:
   - **VXLAN**: Uses UDP for encapsulating Layer 2 Ethernet frames over an IP network.
   - **MPLS**: Uses labels for encapsulating packets, which can be either Layer 2 (VPLS) or Layer 3 (L3VPN).

2. **Transport Network**:
   - **VXLAN**: Typically runs over an IP-based underlay network, such as an IP or Ethernet fabric.
   - **MPLS**: Runs over an MPLS-enabled transport network, which can be more complex to deploy and manage.

3. **Control Plane Protocol**:
   - **EVPN**: Uses EVPN as the control plane for VXLAN, which leverages BGP for distributing MAC and IP information.
   - **MPLS**: Uses LDP (Label Distribution Protocol) or RSVP-TE (Resource Reservation Protocol-Traffic Engineering) along with BGP for label distribution and traffic engineering.

4. **Deployment Use Cases**:
   - **VXLAN-EVPN**: Commonly used in data center environments for network virtualization and cloud infrastructure.
   - **VPLS/L3VPN MPLS**: Often used by service providers for delivering VPN services across wide area networks (WANs).

### Example Comparison

Here's a brief example to illustrate the similarities and differences:

#### EVPN-VXLAN Configuration

1. **VRF and EVPN Configuration**:

   ```bash
   vrf context CustomerA
     rd 1:100
     route-target import 1:100
     route-target export 1:100

   evpn
     vni 5000 l2
       rd 1:100
       route-target import 1:100
       route-target export 1:100
   ```

2. **BGP Configuration**:

   ```bash
   router bgp 65000
     bgp router-id 10.0.0.1
     address-family l2vpn evpn
       neighbor 192.168.1.1 remote-as 65000
       neighbor 192.168.1.1 activate
   ```

#### L3VPN MPLS Configuration

1. **VRF Configuration**:

   ```bash
   vrf definition CustomerA
     rd 1:100
     route-target import 1:100
     route-target export 1:100
     address-family ipv4
   ```

2. **BGP Configuration**:

   ```bash
   router bgp 65000
     bgp router-id 10.0.0.1
     address-family vpnv4
       neighbor 192.168.1.1 remote-as 65000
       neighbor 192.168.1.1 activate
   ```

### Key Points

- **EVPN-VXLAN**: Provides Layer 2 extension and Layer 3 routing over an IP network using VXLAN encapsulation and EVPN as the control plane.
- **VPLS/L3VPN MPLS**: Provides Layer 2 or Layer 3 VPN services over an MPLS network using label switching.

## Verifying commands for VXLAN

### show bgp vrf all l2vpn evpn vni-id [vxlan-id]

show bgp l2vpn evpn -> Check MP-BGP EVPN table (this will show all l2 int BGP RIB not routing table)
show bgp l2vpn evpn summary -> Check if l2vpn evpn vxlan routes are populate as well as l2vpn evpn peers

### show l2route evpn mac all

Used for Layer 2 routing.

#### Example

All will show every layer 2 route for all evpn segments. Use `evi [vlan-id]` instead of `all` to view a specific evpn.

```bash
rcd09-c1-sw-evpn-infra-leaf-01# show l2route evpn mac all

Flags -(Rmac):Router MAC (Stt):Static (L):Local (R):Remote 
(Dup):Duplicate (Spl):Split (Rcv):Recv (AD):Auto-Delete (D):Del Pending
(S):Stale (C):Clear, (Ps):Peer Sync (O):Re-Originated (Nho):NH-Override
(Asy):Asymmetric (Gw):Gateway
(Pf):Permanently-Frozen, (Orp): Orphan

(PipOrp): Directly connected Orphan to PIP based vPC BGW 
(PipPeerOrp): Orphan connected to peer of PIP based vPC BGW 
Topology    Mac Address    Prod   Flags         Seq No     Next-Hops                              
----------- -------------- ------ ------------- ---------- ---------------------------------------------------------
3701        000c.292e.7a00 Local  L,            0          Po509                                                    
3701        0050.56b7.fb0a BGP    Rcv           0          10.100.201.101 (Label: 103701)                           
3701        4cec.0fe5.1aeb VXLAN  Stt,Nho,      0          10.100.201.11                                            
3702        000c.292e.7a00 Local  L,            0          Po509                                                    
3702        0050.56b7.fb0a BGP    Rcv           0          10.100.201.101 (Label: 103702)                           
3702        4cec.0fe5.1aeb VXLAN  Stt,Nho,      0          10.100.201.11                                            
3703        000c.292e.7a00 Local  L,            0          Po509                                                    
3703        0050.56b7.fb0a BGP    Rcv           0          10.100.201.101 (Label: 103703)                           
3703        4cec.0fe5.1aeb VXLAN  Stt,Nho,      0          10.100.201.11                                            
3703        5254.0015.4fe6 Local  L,            0          Po509                                                    
3704        000c.292e.7a00 Local  L,            0          Po509                                                    
3704        0050.56b7.fb0a BGP    Rcv           0          10.100.201.101 (Label: 103704)                           
3704        4cec.0fe5.1aeb VXLAN  Stt,Nho,      0          10.100.201.11                                            
3705        000c.292e.7a00 Local  L,            0          Po509                                                    
3705        0050.56b7.fb0a BGP    Rcv           0          10.100.201.101 (Label: 103705)                           
3705        4cec.0fe5.1aeb VXLAN  Stt,Nho,      0          10.100.201.11                                            
3706        4cec.0fe5.1aeb VXLAN  Stt,Nho,      0          10.100.201.11                                            
3707        4cec.0fe5.1aeb VXLAN  Stt,Nho,      0          10.100.201.11                                            
3708        4cec.0fe5.1aeb VXLAN  Stt,Nho,      0          10.100.201.11                                            
3709        4cec.0fe5.1aeb VXLAN  Stt,Nho,      0          10.100.201.11                                            
3710        4cec.0fe5.1aeb VXLAN  Stt,Nho,      0          10.100.201.11                                            
3711        4cec.0fe5.1aeb VXLAN  Stt,Nho,      0          10.100.201.11
<-- Output Omitted -->
```

Specific vlan.

```bash
leaf-1# show l2route evpn mac evi 10

Flags -(Rmac):Router MAC (Stt):Static (L):Local (R):Remote (V):vPC link
(Dup):Duplicate (Spl):Split (Rcv):Recv (AD):Auto-Delete (D):Del Pending
(S):Stale (C):Clear, (Ps):Peer Sync (O):Re-Originated (Nho):NH-Override
(Pf):Permanently-Frozen, (Orp): Orphan

Topology    Mac Address    Prod   Flags         Seq No     Next-Hops
----------- -------------- ------ ------------- ---------- ---------------------------------------
10          5254.0009.800a BGP    Rcv           0          10.100.0.2 (Label: 10010)
10          5254.000a.800a Local  L,            0          Eth1/3
```

### show l2route topology

#### Example

```
leaf-1# show l2route topology
Topology ID   Topology Name   Attributes
-----------   -------------   ----------
10            Vxlan-10010     VNI
4294967291    BARRIER         N/A
4294967294    GLOBAL          N/A
4294967295    ALL             N/A
```
### show nve peers control-plane-vni peer-ip [ip-address]

Displays the egress VNI or downstream VNI for each NVE adjacency.

#### Example
```
leaf-1# show nve peers con
control-plane       control-plane-vni
leaf-1# show nve peers control-plane-vni peer-ip 10.100.0.2
Peer                 VNI     Learn-Source Learn-Source-Mask Gateway-MAC        Peer-type  Egress-VNI SW-BD      State
-------------------- ------- -------------- ----------------- ------------------ ---------- ---------- ---------- -------------------------
10.100.0.2           10010   BGP        BGP_RNH,BGP_IMET 0000.0000.0000     FAB        10010      10         peer-vni-add-complete
```

### show vxlan interface

May only be available on older models

#### Example

```
leaf-1# show vxlan interface
connect localhost:56000 failed: Connection refused > Not sure what this is!!
Interface	Vlan	VPL Ifindex	LTL		HW VP
=========	====	===========	===		=====
Eth1/3          10	0x5300a7fe	0x1801		2050
```