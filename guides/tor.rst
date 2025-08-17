.. include:: ../header.rst
.. include:: ../footer.rst

=================================
 Understanding Tor: An Explainer
=================================

:Description: This guide explains what Tor is, how it works, and why it's important for online privacy and security.
:Reviewed: This document was last reviewed on 8/16/2025.
:Copyright: This document has been placed in the public domain.

.. contents:: Table of Contents
   :depth: 2

What is Tor?
============

Tor (The Onion Router) is a free and open-source software that enables anonymous communication over the internet. Originally developed by the U.S. Navy, Tor creates a network of volunteer-operated servers that helps protect users' privacy and security online.

The name "onion router" comes from the technique of onion routing, where data is encrypted in multiple layers (like an onion) and passed through several relay points before reaching its destination.

How Tor Works
=============

The Three-Hop System
---------------------

Tor uses a system of three relays to route your internet traffic:

1. **Entry Node (Guard Relay)** - The first relay that knows your real IP address but doesn't know your final destination
2. **Middle Relay** - Knows neither your IP address nor your destination, only passes encrypted data
3. **Exit Node** - Knows your destination but not your real IP address

Data Encryption Process
-----------------------

When you send data through Tor:

::

    Your Computer → Entry Node → Middle Relay → Exit Node → Destination

1. **Layer 1**: Your data is encrypted for the exit node
2. **Layer 2**: The result is encrypted for the middle relay
3. **Layer 3**: The result is encrypted for the entry node

Each relay can only decrypt its own layer, revealing only the next hop in the chain.

Circuit Creation
----------------

Before sending any data, Tor creates a **circuit**:

- A path of three relays is chosen randomly
- Encryption keys are negotiated with each relay
- Circuits are rotated every 10 minutes for security
- Different applications may use different circuits simultaneously

Why Use Tor?
============

Privacy Protection
------------------

- **Hide your location** from websites and online services
- **Prevent tracking** by advertisers and data brokers
- **Bypass censorship** in countries with internet restrictions
- **Protect sensitive communications** from surveillance

Anonymity Benefits
------------------

- Your ISP cannot see what websites you visit (only that you're using Tor)
- Websites cannot determine your real location or IP address
- Government surveillance becomes significantly more difficult
- Protection against traffic analysis attacks

Tor Browser vs Tor Network
===========================

Tor Browser
-----------

The **Tor Browser** is a modified version of Firefox that:

- Routes all traffic through the Tor network automatically
- Blocks JavaScript, plugins, and other tracking technologies by default
- Uses HTTPS whenever possible
- Deletes cookies and browsing history when closed

Tor Network
-----------

The **Tor Network** is the underlying infrastructure:

- Consists of over 6,000 volunteer-operated relays worldwide
- Can be used by other applications besides the Tor Browser
- Supports various protocols including HTTP, HTTPS, and IRC
- Enables hidden services (.onion sites)

Hidden Services (.onion Sites)
==============================

What Are Hidden Services?
--------------------------

Hidden services are websites that exist only on the Tor network:

- Use special `.onion` addresses (e.g., `3g2upl4pq...6kufc4m.onion`)
- Both client and server remain anonymous
- Traffic never leaves the Tor network
- Cannot be accessed without Tor

How Hidden Services Work
------------------------

::

    Client → Entry → Middle → Rendezvous Point ← Middle ← Entry ← Server

1. **Service publishes descriptor** to distributed hash table
2. **Client retrieves descriptor** containing connection information
3. **Both parties connect** through randomly chosen rendezvous point
4. **End-to-end encrypted communication** is established

Benefits of Hidden Services
----------------------------

- **Complete anonymity** for both client and server
- **No need for SSL certificates** or domain registration
- **Resistance to censorship** and takedown attempts
- **Protection against traffic analysis**

Limitations and Considerations
==============================

Performance
-----------

- **Slower than direct connections** due to multiple hops
- **Variable speeds** depending on relay quality
- **Higher latency** for real-time applications

Security Considerations
-----------------------

- **Exit node vulnerabilities** - unencrypted traffic can be monitored
- **Browser fingerprinting** if not using Tor Browser properly
- **Malicious relays** operated by adversaries
- **Timing correlation attacks** with sufficient surveillance

Common Misconceptions
=====================

"Tor is Only for Criminals"
----------------------------

**Reality**: Tor has many legitimate uses:

- Journalists protecting sources
- Activists in oppressive regimes
- Business professionals handling sensitive data
- Privacy-conscious individuals
- Researchers studying internet censorship

"Tor Provides Complete Anonymity"
----------------------------------

**Reality**: Tor provides strong privacy protection but:

- Requires proper usage and configuration
- Can be compromised by user behavior
- Is vulnerable to certain advanced attacks
- Works best when combined with other security practices

Getting Started Safely
======================

Basic Security Guidelines
--------------------------

1. **Use Tor Browser instead of configuring other browsers**

  The Tor Browser is specifically designed to work with the Tor network and includes essential privacy protections that are difficult to replicate in other browsers. Standard browsers like Firefox or Chrome leak identifying information through WebRTC, browser fingerprinting, and various tracking mechanisms even when configured to use Tor as a proxy. Download the official Tor Browser from ``torproject.org`` only - never use unofficial versions or browser extensions that claim to provide Tor functionality. The Tor Browser automatically routes all traffic through the Tor network, blocks dangerous plugins, and resets your session when closed.

2. **Keep software updated to latest versions**

  Tor Browser receives frequent security updates that patch vulnerabilities and improve privacy protections. Enable automatic updates in the Tor Browser settings, or manually check for updates by clicking the hamburger menu and selecting "About Tor Browser." Always restart the browser when prompted after updates. Similarly, keep your operating system updated with the latest security patches, as system-level vulnerabilities can compromise your anonymity even when using Tor properly.

3. **Disable JavaScript for maximum security**

  JavaScript can be used to fingerprint your browser, exploit security vulnerabilities, and potentially reveal your real IP address through various attack techniques. In Tor Browser, click the shield icon in the address bar and select "Advanced Security Settings," then choose "Safest" to disable JavaScript entirely. While this breaks some websites' functionality, it provides the strongest protection against browser-based attacks. For essential sites that require JavaScript, consider using a separate browsing session or different security level, understanding that this reduces your anonymity.

4. **Never download files through Tor Browser**

  Downloaded files can contain malware, tracking beacons, or other code that executes outside the Tor Browser's protection. Many file types like PDFs, Word documents, and executables can "phone home" to reveal your real IP address when opened. If you must download files, save them to an isolated system or virtual machine that's disconnected from the internet. Use antivirus scanning and consider the security implications of any file you download through Tor, as it may have been specifically crafted to de-anonymize users.

5. **Don't log into personal accounts while using Tor**

  Logging into accounts tied to your real identity defeats the purpose of using Tor for anonymity. Services like Gmail, Facebook, or banking sites that know your identity can correlate your Tor usage with your real identity, potentially exposing your browsing patterns. If you must access personal accounts, do so through your regular browser on a separate device or in a completely separate browsing session. Create separate, anonymous accounts for any services you need to access through Tor, using different passwords and recovery methods that don't tie back to your real identity.

Advanced Security Practices
----------------------------

- **Use Tails OS** for maximum anonymity
- **Connect through VPN** before using Tor (optional)
- **Use encrypted messaging** for sensitive communications
- **Verify .onion addresses** through multiple sources

Additional Resources
====================

- `Tor Project Official Website <https://www.torproject.org/>`_
- `Tor Browser User Manual <https://tb-manual.torproject.org/>`_
- `Electronic Frontier Foundation Privacy Guide <https://ssd.eff.org/>`_
- `Tails Operating System <https://tails.boum.org/>`_
