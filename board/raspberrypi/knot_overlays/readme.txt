KNoT Device Tree Overlay
------------------------

This document describes the usage of at86rf233 overlays adapted from
original file at86rf233-overlay.dts residing in linux-version/arch/arm/boot/dts/overlays.
Those modifications were necessary in order to allow AT86RF233 transceiver
to connect to different Chip Selectors(CS) in spi0 and spi1.

Using KNoT Overlays
===================

The KNoT overlay are loaded by using "dtoverlay" directive in /boot/config.txt
file. It's important to notice that the respectively spi overlay should
be loaded before at86rf233 module in order to proper work of the device.
As an example, the at86rf233 can be loaded connected to spi1 by writing
in config.txt file:

	dtoverlay=spi1-2cs
	dtoverlay=at86rf233-spi1

As mentioned before, the default Chip Selector(CS) can be modified using
modules' parameters. For example, if it is more desirable to use
chip selector 1 instead of default chip 0, it can be done passing parameter
ce=1 in dtoverlay directive:

        dtoverlay=at86rf233-spi1,ce=1

Note that spi0 has 2 chip select in as default it uses GPIO pin 8 for CS0
and GPIO pin 7 for CS1. Note also that raspberry firmware provides overlays:
spi1-1cs spi1-2cs and spi1-3cs for spi1. They are used to enable one, two
or three chip selectors, respectively. The spi1 use as default: GPIO pin 18
for CS0, GPIO pin 17 for CS1 and GPIO pin 16 for CS2.

The Overlay and Parameter Reference
===================================

Name:   at86rf233-spi0
Info:   Configures the Atmel AT86RF233 802.15.4 low-power WPAN transceiver,
        connected to spi0
Load:   dtoverlay=at86rf233,<param>=<val>
Params: ce                      GPIO used for Reg (default 0)
        interrupt               GPIO used for INT (default 23)
        reset                   GPIO used for Reset (default 24)
        sleep                   GPIO used for Sleep (default 25)
        speed                   SPI bus speed in Hz (default 3000000)
        trim                    Fine tuning of the internal capacitance
                                arrays (0=+0pF, 15=+4.5pF, default 15)
Name:   at86rf233-spi1
Info:   Configures the Atmel AT86RF233 802.15.4 low-power WPAN transceiver,
        connected to spi1
Load:   dtoverlay=at86rf233,<param>=<val>
Params: ce                      GPIO used for Reg (default 0)
        interrupt               GPIO used for INT (default 13)
        reset                   GPIO used for Reset (default 12)
        sleep                   GPIO used for Sleep (default 26)
        speed                   SPI bus speed in Hz (default 3000000)
        trim                    Fine tuning of the internal capacitance
                                arrays (0=+0pF, 15=+4.5pF, default 15)
