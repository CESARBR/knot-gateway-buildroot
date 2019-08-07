KNoT Network of Things - Gateway
================================

This is the gateway software module for the KNoT platform.
It is based on Buildroot 2018.08 version for RaspberryPi hardware.

Buildroot is a simple, efficient and easy-to-use tool to generate embedded
Linux systems through cross-compilation.

Buildroot online documentation can be found
at `<http://buildroot.org/docs.html>`_

-------------------------------------------------------------------------------

System requirements
-------------------

Buildroot is designed to run on Linux systems. If you are using a Mac, there
is an experimental Vagrant box configured to build the KNoT Gateway, see
HACKING.rst file on directory.

While Buildroot itself will build most host packages it needs for the
compilation, certain standard Linux utilities are expected to be already
installed on the host system. Below you will find an overview of the mandatory
and optional packages.

#. Install the required packages:

   - The following command is for Debian based Linux distro, such as Ubuntu.
     Note that package manager and package names may vary between distributions

   .. code-block:: bash

      sudo apt-get install build-essential automake \
               libtool pkg-config g++ flex gawk bc bzr cvs git \
               mercurial subversion cpio locales libssl-dev \
               libncurses5-dev libssl-dev libncurses5-dev zlib1g \
               libncurses5 wget unzip autoconf-archive libdbus-1-dev

Use a Vagrant box (experimental)
--------------------------------

This repository provides a Vagrant box running Ubuntu with all the packages
needed to build the KNoT Gateway.

Before running it, install `Vagrant <https://www.vagrantup.com>`_ and
`VirtualBox <https://www.virtualbox.org>`_.

Then, install a Vagrant plugin to resize disks in VirtualBox:

.. code-block:: bash

   $ vagrant plugin install vagrant-disksize

To create the box, run:

.. code-block:: bash

   $ vagrant up

It will ask for administrator credentials, needed to setup a NFS map between
the source folder in the host and the guest.

To enter the VM, run:

.. code-block:: bash

   $ vagrant ssh

There are two folders in the home folder:

You'll find the ~/buildroot folder, which maps to the repository root in
the host.

-------------------------------------------------------------------------------

How to Build it
---------------

The knot_<board>_defconfig configuration is a minimal configuration with all
that is required to bring the KNoT platform on RaspberryPi.

**Warning**: You will need to have access to the network, since Buildroot will
download the packages' sources. For an offline build see HACKING.rst file.

You should base your work on this defconfig:

#. Run KNoT defconfig

   .. code-block:: bash

      make knot_<board>_defconfig

   **Note**: Currently supported KNoT defconfigs:

   - ``knot_raspberrypi3_defconfig``
   - ``knot_raspberrypi0w_defconfig``

#. Menu Configuration

   You can access and select extra packages you wish to compile with KNoT Linux
   OS on Buildroot menuconfig. This is an optional step.

   .. code-block:: bash

      make menuconfig

#. Build

   .. code-block:: bash

      make

   **Tip**: This may take a while. Consider getting yourself a coffee ;-)

Offline Build
-------------

In order to do an offline-build (not connected to the net), fetch all
selected source by issuing a before you disconnect.

.. code-block:: bash

   $ make source

If your build-host is never connected, then you have to copy buildroot
and your toplevel `.config` to a machine that has an internet-connection
and issue `make source` there, then copy the content of your dl/ dir to
the build-host.

Building out-of-tree (required for Vagrant)
-------------------------------------------

By default, Buildroot will put the build results in the output folder.
If you want to put the results in a different folder, e.g. when running
builds for multiple targets, you can pass the O option to make specifying
the desired output folder. Mind that this has to be passed every time you
execute make.

The complete build process would be:

1. Run KNoT defconfig

   .. code-block:: bash

      make O=/path/to/my/output/folder knot_<board>_defconfig

   **Note**: Currently supported KNoT defconfigs:

   - ``knot_raspberrypi3_defconfig``
   - ``knot_raspberrypi0w_defconfig``

2. Menu Configuration

   You can access and select extra packages you wish to compile with KNoT Linux
   OS on Buildroot menuconfig. This is an optional step.

   .. code-block:: bash

      make O=/path/to/my/output/folder menuconfig

3. Build

   .. code-block:: bash

      make O=/path/to/my/output/folder

   **Tip**: This may take a while. Consider getting yourself a coffee ;-)


If you are running on Vagrant on Windows or Mac, this is a required
configuration option, but it is suggested even if you are running Vagrant
on Linux. The Mac and Windows file systems are case insensitive and due to
it the build will fail if made in the ~/buildroot folder.
Pass a folder inside the VM, e.g.:

1. Run KNoT defconfig

   .. code-block:: bash

      make O=../output knot_<board>_defconfig

2. Menu Configuration

   .. code-block:: bash

      make O=../output menuconfig

3. Build

   .. code-block:: bash

      make O=../output

-------------------------------------------------------------------------------

Result of the build
-------------------

After building, you should obtain this tree:

.. code-block:: text

   output/images/
   ├── bcm2708-rpi-b.dtb           [1]
   ├── bcm2708-rpi-b-plus.dtb      [1]
   ├── bcm2708-rpi-0-w             [1]
   ├── bcm2709-rpi-2-b.dtb         [1]
   ├── bcm2710-rpi-3-b.dtb         [1]
   ├── bcm2710-rpi-3-b-plus.dtb    [1]
   ├── boot.vfat
   ├── rootfs.ext4
   ├── rpi-firmware/
   |   ├── bootcode.bin
   |   ├── cmdline.txt
   |   ├── config.txt
   |   ├── fixup.dat
   |   ├── start.elf
   |   └── overlays/               [2]
   ├── sdcard.img
   └── zImage

[1] Not all of them will be present, depending on the RaspberryPi model
you are using.

[2] Only for the Raspberry Pi 3 Model (overlay pi3-miniuart-bt is needed
to enable the RPi3 serial console otherwise occupied by the bluetooth
chip). Alternative would be to disable the serial console in cmdline.txt
and /etc/inittab.

-------------------------------------------------------------------------------

How to write the SD card
------------------------

Once the build process is finished you will have an image called ``sdcard.img``
in the output/images/ directory.

It is possible to erase and write the SD Card using native OS application to
manage and configure disk drives. Similarly to **Disks** on Ubuntu.

- If you are using a Linux based distribution you can use ``dd`` command.

   Copy the bootable ``sdcard.img`` onto an SD card with ``dd``:

      .. code-block:: bash

         sudo dd if=output/images/sdcard.img of=/dev/sdX status=progress

      **Note**: status=progress is an optional argument to show the progress of
      the command execution. See ``dd`` manual for more options.

- A user friendly way to flash the image is using balenaEtcher. You can use
  any OS to flash using balenaEtcher.

   #. Download and install `balenaEtcher <https://www.balena.io/etcher/>`_.

   #. Connect an SD card to your computer.

   #. Open balenaEtcher and select ``sdcard.img`` file.

   #. Select the target SD card.

   #. Flash it.

After a successful flash, insert the SD Card into your Raspberry Pi, and power
it up.

-------------------------------------------------------------------------------

Managing the RabbitMQ Server
----------------------------

If you need to debug the RabbitMQ message broker or just collect data about
many aspects of the system, you can use the management plugin.

In order to enable it, access the gateway terminal and run this
command (logged in as ``rabbitmq`` user):

.. code-block:: bash

   $ rabbitmq-plugins enable rabbitmq_management

Now, create a new user and set its permissions to allow remote connections:

.. code-block:: bash

   $ rabbitmqctl add_user <username> <password>
   $ rabbitmqctl set_user_tags <username> administrator
   $ rabbitmqctl set_permissions -p / <username> ".*" ".*" ".*"


The management UI can be accessed at `http://knot.local:15672/`, just use
the created user and enjoy it.

-------------------------------------------------------------------------------

Monitoring the KNoT Gateway image
---------------------------------

You can access you gateway using ``ssh`` command.

In a linux machine on same local network and execute the followed command
on terminal:

.. code-block:: bash

   arp-scan -l | grep b8:27:eb

**Note**: It is necessary to have arp-scan package installed. If you're
running a Ubuntu/Debian based distro, run sudo apt-get install arp-scan
on terminal.

Another way is connecting a screen and a keyboard on Raspberry Pi, login as
user `root` and password `root`, and type the command below on terminal:

.. code-block:: bash

   ip a

This commands will return the IP address the router have assigned to the
KNot gateway.

To access the gateway using ``ssh``, run the followed command in a linux
machine on same local network:

.. code-block:: bash

   ssh root@<raspberry-IP>

The password is ``root``

-------------------------------------------------------------------------------

Contact
-------

Get the contact information on the Contact section of
`KNoT documentation <http:://knot-devel.cesar.org.br>`_.
