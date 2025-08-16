.. include:: ../header.rst

========================================
QEMU/KVM Virtualization Setup Guide
========================================

:Description: This guide walks through the process of setting up QEMU and KVM on Linux.
:Reviewed: This document was last reviewed on 8/16/2025.
:Copyright: This document has been placed in the public domain.

.. contents:: Table of Contents
   :depth: 2

QEMU (short for Quick Emulator) is a free and open source virtualization and emulation software. KVM is a virtualization layer built into Linux, which comes with many benefits like near instant performance and better networking support.

Prerequisites
=============

- A Debian-based Linux distribution
- Root access
- Check your CPU, it **SHOULD** support virtualization technology. To do this, run this command::

    grep -E --color=auto 'vmx|svm' /proc/cpuinfo

  If there is no output to the command, your CPU does **NOT** support it, which means performance will be worse, OR that you forgot to enable it in the BIOS.

- An ISO image for an operating system you wish to virtualize, you can grab this at any time, make sure it's on your main partition.

Step 1: Update and Install Dependencies
=======================================

::

    sudo apt update
    sudo apt install qemu-kvm libvirt-daemon-system libvirt-clients bridge-utils virt-manager

Step 2: Add Your User to the LibVirt Group
===========================================

.. important::
   Make sure to log out and back in after you do this!

::

    sudo usermod -aG libvirt $(whoami)
    sudo usermod -aG kvm $(whoami)

Step 3: Start the Daemon
=========================

::

    sudo systemctl enable --now libvirtd

Step 4: Start the Networking Stack
===================================

::

    sudo virsh net-start default
    sudo virsh net-autostart default

Step 5: Edit the libvirtd.conf File
====================================

::

    sudo nano /etc/libvirt/libvirtd.conf

Then uncomment these lines::

    unix_sock_group = "libvirt"
    unix_sock_rw_perms = "0770"

Step 6: Install dmidecode
=========================

::

    sudo apt install dmidecode

Step 7: Restart
===============

::

    sudo reboot now

Great! Now it should be working.

Now look in the apps list for a generic / dated looking app named "Virtual Machine Manager" and open it.

Creating a Virtual Machine
===========================

Starting the VM Creation Process
---------------------------------

To do this, click the button in the top left that looks like a monitor. You'll see something like this. Click **Forward**.

Selecting Your ISO
-------------------

Now, you will be presented with an option to select a drive, click **Browse** then **Desktop**. Select your ISO, and click **Choose Volume**.

Operating System Configuration
-------------------------------

Now, make sure to uncheck automatic OS detection and select "Generic Linux 2024" which should autofill from the dropdown. Now click **Forward**.

Memory and CPU Configuration
-----------------------------

Give it memory and CPU cores. It'll tell you in small text below each how much is available on your hardware, I recommend no more than 70% of your total system resources.

Storage Configuration
---------------------

Now you might want a storage disk. If you do, select its size, and make sure the checkbox above is checked. Then click **Forward**.

Finalizing VM Setup
--------------------

Now give it a name and hit **Configure before running**.

To start your VM, click the play icon in the top left and then a window should pop up with its display.

Configuring Graphics and Display
---------------------------------

1. Go to **Video Virtio** and check the box for **3D acceleration**.
2. Go to **Display Spice** and set **Listen Type** to **None**, then check the box for **OpenGL**.
3. Now hit **Apply** and then **Begin Installation** in the top left.

The VM should start (if not, hit the play button), and you can enjoy your brand new VM!

Improve Your Experience
=======================

Display Settings
----------------

Once you have your VM running, you should see a top bar with buttons.

1. Hover over **View > Scale Display** and set it to **Always**. This will fix the resolution mismatch.
2. Hover over **View** and uncheck **Toolbar** because it's entirely redundant. All of its settings can be accessed by hovering over **Virtual Machine** and selecting one of the options.

Enjoy!

Finished!
=========

Your QEMU/KVM virtualization environment is now ready for use. You can create additional virtual machines following the same process, and experiment with different operating systems in a safe, isolated environment.
