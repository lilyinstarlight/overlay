Overlay
=======

This is my Portage overlay where I dump all of the packages I create or modify. If anything is out of date or doesn't build on your system, create a [new issue](https://github.com/fkmclane/overlay/issues/new) and attach a copy of the build log from a [pastebin](https://paste.fooster.io/).


Installation
------------

The easiest way to add this overlay to your Portage tree is through layman.

```
# layman -a fkmclane
```


Packages
--------


### Multimedia

#### Plex [media-tv/plex-media-server, media-tv/plex-home-theater, media-tv/plex-media-player, media-tv/plexpy, media-video/plex-ffmpeg, media-plugins/plex-for-kodi, media-plugins/plex-kodi-connect]
[Plex](http://plex.tv/) is a service that allows convenient access to central media over a variety of devices. Plex Media Player is a new desktop client for Plex that includes a nice ten-foot interface and is designed for connecting to the television. Note: Plex Pass users can add the "~amd64" or "~x86" keywords to the packages to get the latest Plex Pass versions.

#### v4l2loopback [media-video/v4l2loopback]
[v4l2loopback](https://github.com/umlaeute/v4l2loopback) is a kernel module to create V4L2 loopback devices. These can be used in conjunction with software (e.g. ffmpeg or gstreamer) to create a virtual webcam device.

#### Calf Studio Gear [media-plugins/calf]
[Calf Studio Gear](http://calf-studio-gear.org/) is a set of free and open source professional audio plug-ins. This package has an "experimental" use flag which enables experimental plugins.

#### GxPlugins [media-plugins/gxplugins-lv2]
[GxPlugins](https://github.com/brummer10/GxPlugins.lv2) are LV2 plugins for electric guitars from the Guitarix project.

#### midifilter.lv2 [media-plugins/midifilter-lv2]
[midifilter.lv2](https://github.com/x42/midifilter.lv2/) is an LV2 plugin to filter MIDI events.

#### ympd [media-sound/ympd]
[ympd](https://www.ympd.org/) is a standalone MPD web GUI written in C, utilizing websockets and Bootstrap/JS.

#### OpenVR [media-libs/openvr]
[OpenVR](https://github.com/ValveSoftware/openvr) is an API and runtime for abstracting various VR hardware.

#### Discord [net-im/discord]
[Discord](https://discordapp.com/) is an all-in-one voice and text chat for gamers.


### Security Tools

#### Metasploit [net-analyzer/metasploit]
[Metasploit](https://www.metasploit.org/) is a framework for developing, testing, and using vulnerability exploits.

#### Bettercap [net-analyzer/bettercap]
[Bettercap](https://bettercap.org/) is a modular MITM framework.

#### WPScan [net-analyzer/wpscan]
[WPScan](https://wpscan.org/) is a WordPress vulnerability scanner.

#### mitmproxy [net-analyzer/mitmproxy]
[mitmproxy](http://mitmproxy.org/) is an interactive, SSL-capable, man-in-the-middle HTTP proxy.

#### BeEF [www-apps/beef]
[BeEF](https://beefproject.com/) is a browser exploitation framework.

#### JohnTheRipper [app-crypt/johntheripper]
[JohnTheRipper](http://www.openwall.comm/john/) is a fast password cracker.


### Games

#### Armagetron Advanced [games-action/armagetronad, games-action/armagetronad-dedicated]
[Armagetron Advanced](http://armagetronad.org/) is a fast-paced 3D implementation of lightcycles from the movie Tron. It features both single-player and multiplayer modes with online servers that have extensive configurability. This package includes the current stable release, 0.2.8, and the current bzr snapshot, 0.4.

#### Nyancat [games-misc/nyancat]
[Nyancat](https://github.com/klange/nyancat) is a CLI implementation of the famous poptart cat.

#### pipes.sh [games-misc/pipes]
[pipes.sh](https://github.com/pipeseroni/pipes.sh) is an animated pipes terminal screensaver. This package installs it with the command 'pipes'.

#### nSnake [games-arcade/nsnake]
[nSnake](https://github.com/alexdantas/nSnake) is a clone of the classic snake game on the terminal.

#### Cockatrice [games-board/cockatrice]
[Cockatrice](http://www.reddit.com/r/Cockatrice) is a cross-platform virtual tabletop for multiplayer card games, such as Magic: The Gathering, over a network.

#### MCEdit 2.0 [dev-games/mcedit]
[MCEdit](http://www.mcedit.net/) is a world/save game editor for Minecraft.


### Utilities

#### Sync Mail Dir [net-mail/syncmaildir]
[Sync Mail Dir](http://syncmaildir.sourceforge.net/) (smd) is a set of tools to synchronize a pair of mailboxes in Maildir format. It is useful for IMAP-less client-server mail synchronization and for Maildir transistion.

#### cronic [app-misc/cronic]
[cronic](http://habilis.net/cronic/) is a cure for cron's chronic email problem. It is a small shell script that helps to control cron's email output by wrapping commands and only showing program output on failure.

#### tty-clock [app-misc/tty-clock]
[tty-clock](https://github.com/xorg62/tty-clock) is a versatile clock in the terminal using ncurses.

#### create\_ap [app-misc/create\_ap]
[create\_ap](https://github.com/oblique/create_ap) is a script that creates a NATed or bridged WiFi access point given an Ethernet connection.

#### lemonbar [x11-misc/lemonbar]
[lemonbar](https://github.com/LemonBoy/bar) is a featherweight, lemon-scented, bar based on xcb.

#### zget [net-p2p/zget]
[zget](https://github.com/nils-werner/zget) is a zeroconf based peer to peer file transfer utility. It uses filenames to locate and transfer files instead of hostnames or IP addresses.

#### BlinkStick [app-misc/blinkstick]
[BlinkStick](https://www.blinkstick.com/) is a class of smart USB LED controllers. This package contains the command line client and Python module.

#### udiskie [sys-fs/udiskie]
[udiskie](https://github.com/coldfix/udiskie) is a udisks front-end for removable media such as CDs or flash drives.

#### petty [sys-apps/petty]
[petty](https://github.com/fkmclane/petty), short for practically enhanced tty, is a tty session starter.

#### barline [x11-misc/barline]
[barline](https://github.com/fkmclane/barline) is a data collector and bar generator for lemonbar.

#### GoTTY [app-misc/gotty-bin]
[GoTTY](https://github.com/yudai/gotty) is tools to run command line programs as web applications.

#### Wemux [app-misc/wemux]
[Wemux](https://github.com/zolrath/wemux) is multi-user tmux made easy.

### Administration

#### Linode CLI [app-admin/linode-cli]
[Linode CLI](https://github.com/linode/cli) is a command-line interface to the [Linode](http://linode.com/) platform.

#### UniFi Controller [net-wireless/unifi]
[UniFi Controller](http://wiki.ubnt.com/UniFi_FAQ) is a management controller and inferface for the Ubiquiti Networks UniFi access points.


### Operating System

#### exfat-nofuse [sys-fs/exfat-nofuse]
[exfat-nofuse](https://github.com/dorimanx/exfat-nofuse) is a non-FUSE kernel driver for exFat and VFat file systems.

#### EDK2 OVMF [sys-firmware/edk2-ovmf]
[EDK2 OVMF](http://www.tianocore.org/) is a firmware image for the EDK II UEFI firmware.

### Development

#### Unity Editor [dev-util/unity-editor]
[Unity Editor](http://unity3d.com/) is the editor for making games with the Unity game engine.

#### Arduino [dev-embedded/arduino-bin]
[Arduino](https://www.arduino.cc/) is an electronics prototyping platform designed from easy-to-use hardware and software.

#### Teensyduino [dev-embedded/teensyduino-bin]
[Teensyduino](https://www.pjrc.com/teensy/teensyduino.html) is a modified Arduino environment that supports the Teensy line on boards.

#### Energia [dev-embedded/energia-bin]
[Energia](http://energia.nu/) is an electronics prototyping platform for Texas Instruments MSP430 LaunchPad based on [Wiring](http://www.wiring.org.co/) and [Arduino](https://www.arduino.cc/).

#### Komodo-Edit [app-editors/komodo-edit-bin]
[Komodo-Edit-bin](http://www.activestate.com/komodo-edit) Freeware advanced editor for dynamic and Web languages

Upstream Bug Tracker: https://github.com/Komodo/KomodoEdit

### Libraries

#### Chipmunk2D [sci-physics/chipmunk]
[Chipmunk2D](http://chipmunk-physics.net/) is a simple, lightweight, fast and portable 2D rigid body physics library.

#### Boto [dev-python/boto]
[Boto](https://github.com/boto/boto/) is a Python interface to Amazon Web Services.

#### Slixmpp [dev-python/slixmpp]
[Slixmpp](https://dev.louiz.org/projects/slixmpp) is a Python library for XMPP. It is the asyncio fork of SleekXMPP

### GTK+

#### A Widget Factory [x11-misc/awf]
[A Widget Factory](https://github.com/valr/awf) is a theme preview application that shows most GTK+ widgets for both versions 2 and 3.

#### Arc Theme [x11-themes/arc-openbox-theme]
[Arc Theme](https://github.com/horst3180/arc-theme) is a flat GTK+ theme with transparent elements.

### CAD

#### Freeroute [sci-electronics/freeroute]
[Freeroute](http://freerouting.net/) is a popular automatic PCB routing tool.
