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

1. **Use Tor Browser** instead of configuring other browsers
2. **Keep software updated** to latest versions
3. **Disable JavaScript** for maximum security
4. **Never download files** through Tor Browser
5. **Don't log into personal accounts** while using Tor

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
