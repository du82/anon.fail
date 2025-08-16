.. include:: ../header.rst
.. include:: ../footer.rst

========================================
Set up a Tor hidden service with Apache2
========================================

:Description: This guide walks through the process of setting up a Tor hidden service (.onion site) using Apache2 on Debian-based systems.
:Reviewed: This document was last reviewed on 8/16/2025.
:Copyright: This document has been placed in the public domain.

.. contents:: Table of Contents
   :depth: 2

Prerequisites
=============

- A **Debian-based** Linux distribution (**NOT Ubuntu**)
- 2GB of memory recommended, 500MB minimum. 1GB disk space recommended.
- Root access

Step 1: Install Required Packages
==================================

Start by acquiring root privileges and installing the necessary packages::

    # Become root
    su

    # Install Tor and Apache2
    sudo apt install tor -y
    sudo apt install apache2 -y
    sudo apt install apt-transport-https -y

Step 2: Add the Tor Project Repository
======================================

Add the official Tor Project repository to ensure you get the latest version::

    # Create a new list file for Tor repositories
    cd /etc/apt/sources.list.d/
    sudo touch tor.list
    sudo nano tor.list

In the editor, paste the following (don't exit yet)::

    deb     [signed-by=/usr/share/keyrings/deb.torproject.org-keyring.gpg] https://deb.torproject.org/torproject.org tor-experimental-<DISTRIBUTION> main
    deb-src [signed-by=/usr/share/keyrings/deb.torproject.org-keyring.gpg] https://deb.torproject.org/torproject.org tor-experimental-<DISTRIBUTION> main

You need to replace ``<DISTRIBUTION>`` with your actual distribution codename::

    # Open a new terminal tab and run:
    lsb_release -c

Replace ``<DISTRIBUTION>`` in tor.list with whatever codename appears (e.g., noble, wilma, bookworm). Save and close the file.

Step 3: Add the Tor GPG Key
============================

Add the Tor Project's GPG key to verify packages::

    sudo bash -c "wget -q0- https://deb.torproject.org/torproject.org/A3C4F0F979CAA22CDBA8F512EE8CBC9E886DDD89.asc | gpg --dearmor | tee /usr/share/keyrings/deb.torproject.org-keyring.gpg >/dev/null"

Step 4: Install and Start Tor
==============================

Update the package list and install Tor with the official keyring::

    sudo apt update
    sudo apt install tor deb.torproject.org-keyring
    sudo systemctl start tor
    sudo systemctl status tor  # Verify Tor is running

Step 5: Configure the Hidden Service
=====================================

Create the directory for your hidden service and configure Tor::

    sudo mkdir /var/lib/tor/hidden_service
    cd /etc/tor
    sudo nano torrc

Add these lines to the torrc file::

    HiddenServiceDir /var/lib/tor/hidden_service
    HiddenServicePort 80 127.0.0.1:8080

**Note:** Be careful with the syntax - ensure there's no colon after "HiddenServiceDir" and "HiddenServicePort"

Step 6: Set Permissions and Restart Tor
========================================

Set the correct ownership and permissions for the hidden service directory::

    sudo chown -R debian-tor:debian-tor /var/lib/tor/hidden_service
    sudo chmod -R 700 /var/lib/tor/hidden_service
    sudo systemctl restart tor

Step 7: Configure Apache for the Hidden Service
================================================

Create a directory for your hidden service content::

    sudo mkdir -p /var/www/hidden_service/
    sudo touch /var/www/hidden_service/index.html

Edit the index.html file with your content::

    sudo nano /var/www/hidden_service/index.html

Retrieve your .onion address::

    sudo cat /var/lib/tor/hidden_service/hostname

Step 8: Configure Apache to Listen on the Right Port
=====================================================

Modify Apache's ports configuration::

    cd /etc/apache2/
    sudo nano ports.conf

Add this line (or modify existing Listen directives)::

    Listen 127.0.0.1:8080

Step 9: Create a Virtual Host for your Hidden Service
======================================================

Create and configure a virtual host file::

    cd /etc/apache2/sites-available/
    sudo touch hidden_service.conf
    sudo nano hidden_service.conf

Add this configuration, replacing "address.onion" with your actual .onion address::

    <VirtualHost 127.0.0.1:8080>
        ServerName address.onion
        DocumentRoot /var/www/hidden_service
    </VirtualHost>

Step 10: Enable the Site and Restart Apache
============================================

Set the proper permissions, enable the site, and restart Apache::

    sudo chown root:root /etc/apache2/sites-available/hidden_service.conf
    sudo chmod 644 /etc/apache2/sites-available/hidden_service.conf
    sudo a2ensite hidden_service.conf
    sudo systemctl reload apache2

Step 11: Verify Your Hidden Service
====================================

Check your .onion address again and test your site::

    sudo cat /var/lib/tor/hidden_service/hostname

To access your hidden service, you'll need the Tor Browser. Enter your .onion address in the Tor Browser to verify it's working.

----------------------------------------------------------------------

Vanity .onion Addresses
=======================

**Note:** You may want to generate the vanity address on a separate more powerful machine and move it over with SSH. Instructions for both methods are included.

Generate a Vanity Address
-------------------------

::

    # mkp224o Setup
    git clone https://github.com/cathugger/mkp224o
    cd mkp224o
    ./autogen.sh
    ./configure
    make

    # Generate a vanity address
    ./mkp244o [character string you want]

.. note::
   It is recommend only running ``./mkp244o`` with 1-6 characters. Expect long wait times. Anything longer than 7 characters may never generate on most hardware available to consumers.

Generated Tor addresses will end up in a file in your documents called ``mkp224o``, and inside you will find ``hostname``, ``hs_ed25519_public_key``, and ``hs_ed25519_secret_key``.

Configure the Vanity Address for your Tor Hidden Service
---------------------------------------------------------

::

    # Move generated address credentials
    mv /mkp224o/vanity-address-folder /var/lib/tor/

    # Remove old credentials
    cd /var/lib/tor/hidden_service/
    rm -rf hostname
    rm -rf hs_ed25519_public_key
    rm -rf hs_ed25519_secret_key

    # Add new credentials
    cd /var/lib/tor/vanity-address-folder
    mv hostname /var/lib/tor/hidden_service
    mv hs_ed25519_public_key /var/lib/tor/hidden_service
    mv hs_ed25519_secret_key /var/lib/tor/hidden_service
    cd ..
    rm -rf /vanity-address-folder

    # Set Permissions
    cd /var/lib/tor/hidden_service/
    sudo chown debian-tor:debian-tor hostname hs_ed25519_public_key hs_ed25519_secret_key
    chmod 600 hs_ed25519_secret_key
    chmod 644 hostname hs_ed25519_public_key

    systemctl restart tor

----------------------------------------------------------------------

Troubleshooting
===============

If you encounter issues:

Add ServerName to Apache config
--------------------------------

::

    sudo nano /etc/apache2/apache2.conf
    # Add: ServerName localhost
    sudo reboot

Reset Everything
----------------

If problems persist, try resetting the services::

    # Reset Tor service
    sudo chown -R debian-tor:debian-tor /var/lib/tor/hidden_service
    sudo pkill tor
    sudo systemctl stop tor
    sudo -u debian-tor tor -f /etc/tor/torrc

    # Check Apache configuration
    apache2 -S

    # If needed, reinstall Apache
    sudo apt-get remove --purge apache2 apache2-data apache2-utils -y
    sudo apt-get install apache2 -y
    # Then repeat the Apache configuration steps

Security Considerations
=======================

- This is a basic setup for educational purposes
- For production environments, implement additional security measures
- Regularly update your system and the Tor service
- Consider hardening your Apache configuration

Additional Resources
====================

- `Tor Project Documentation <https://community.torproject.org/onion-services/>`_
- `Apache HTTP Server Documentation <https://httpd.apache.org/docs/>`_
