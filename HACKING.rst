KNoT Network of Things - Gateway - HACKING
==========================================

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
