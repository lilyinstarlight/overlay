Overlay
=======

This is my Portage overlay where I dump all of the packages I create or modify. If anything is out of date or doesn't build on your system, create a [new issue](https://github.com/fkmclane/overlay/issues/new) and attach a copy of the build log from a [pastebin](http://pastebin.com/).


Installation
------------

The easiest way to add this overlay to your Portage tree is through layman.

```
# layman -a fkmclane
```


Packages
--------

### Multimedia

#### Plex (media-tv/plex-media-server, media-tv/plex-home-theater)
[Plex](http://plex.tv/) is a service that allows convenient access to central media over a variety of devices. Plex Home Theater is an XBMC based client for Plex that includes a nice ten-foot interface and is designed for connecting to the television. Note: Plex Pass users can add the "~amd64 or ~x86" keywords to the packages to get the latest Plex Pass versions.

#### WebcamStudio (media-video/webcamstudio, media-video/webcamstudio-module)
[WebcamStudio](https://code.google.com/p/webcamstudio/) is a live video mixer often used in conjunction with a virtual webcam driver to create professional looking broadcasts.

#### v4l2loopback (media-video/v4l2loopback)
[v4l2loopback](https://github.com/umlaeute/v4l2loopback) is a kernel module to create V4L2 loopback devices. These can be used in conjunction with WebcamStudio or other software (e.g. ffmpeg or gstreamer) to create a virtual webcam device.

### Games

#### Armagetron Advanced (games-action/armagetronad, games-action/armagetronad-dedicated)
[Armagetron Advanced](http://armagetronad.org/) is a fast-paced 3D implementation of lightcycles from the movie Tron. It features both single-player and multiplayer modes with online servers that have extensive configurability. This package includes the current stable release, 0.2.8, and the current bzr snapshot, 0.4.

#### Nyancat (games-misc/nyancat)
[Nyancat](https://github.com/klange/nyancat) is a CLI implementation of the famous poptart cat.

#### nSnake (games-arcade/nsnake)
[nSnake](https://github.com/alexdantas/nSnake) is a clone of the classic snake game on the terminal.

#### Cockatrice (games-board/cockatrice)
[Cockatrice](http://www.reddit.com/r/Cockatrice) is a cross-platform virtual tabletop for multiplayer card games, such as Magic: The Gathering, over a network.

### Messaging

#### Profanity (net-im/profanity)
[Profanity](http://www.profanity.im/) is a console based XMPP client inspired by Irssi.

### Utilities

#### maim (media-gfx/maim)
[maim](https://github.com/naelstrof/maim) (make image) is a utility that takes screenshots of your desktop and is designed to be an improved scrot. It optionally uses [slop](https://github.com/naelstrof/slop) for screen selections.

#### Sync Mail Dir (net-mail/syncmaildir)
[Sync Mail Dir](http://syncmaildir.sourceforge.net/) (smd) is a set of tools to synchronize a pair of mailboxes in Maildir format. It is useful for IMAP-less client-server mail synchronization and for Maildir transistion.

#### Pipelight (www-plugins/pipelight)
[Pipelight](http://pipelight.net/) is a browser plugin that allows running Windows browser plugins in Wine in native browsers. It includes support for Silverlight, Adobe Flash, Adobe Shockwave, and Unity Webplayer. It requires Wine with the Compholio patches to run Silverlight or any DRM content.

#### cronic (app-misc/cronic)
[cronic](http://habilis.net/cronic/) is a cure for cron's chronic email problem. It is a small shell script that helps to control cron's email output by wrapping commands and only showing program output on failure.

#### tty-clock (app-misc/tty-clock)
[tty-clock](https://github.com/xorg62/tty-clock) is a versatile clock in the terminal using ncurses.

#### create\_ap (app-misc/create\_ap)
[create\_ap](https://github.com/oblique/create_ap) is a script that creates a NATed or bridged WiFi access point given an Ethernet connection.

#### lemonbar (x11-misc/lemonbar)
[lemonbar](https://github.com/LemonBoy/bar) is a featherweight, lemon-scented, bar based on xcb.

#### zget (net-p2p/zget)
[zget](https://github.com/nils-werner/zget) is a zeroconf based peer to peer file transfer utility. It uses filenames to locate and transfer files instead of hostnames or IP addresses.

#### Viewnior (media-gfx/viewnior)
[Viewnior](https://github.com/xsisqox/Viewnior) is a fast and elegant image viewer. It is desktop environment agnostic and supports a basic set of image viewing and manipulation features.


### Office

#### HomeBank (app-office/homebank)
[HomeBank](http://homebank.free.fr/) is a personal finance program with a relatively good feature set and intuitive interface.

### Administration

#### Linode CLI (app-admin/linode-cli)
Linode CLI is a command-line interface to the [Linode](http://linode.com/) platform.

### Libraries

#### OpenShot (media-libs/libopenshot, media-libs/libopenshot-audio)
[OpenShot Library](https://launchpad.net/libopenshot) is a high quality video editing library that powers OpenShot 2.0.

#### Pymunk (dev-python/pymunk)
[Pymunk](http://pymunk.org/) is a pythonic 2D physics library based on [Chipmunk2D](http://chipmunk-physics.net/).

#### libstrophe (dev-libs/libstrophe)
[libstrophe](http://strophe.im/libstrophe/) is a minimal XMPP library written in C.

#### Chipmunk2D (sci-physics/chipmunk)
[Chipmunk2D](http://chipmunk-physics.net/) is a simple, lightweight, fast and portable 2D rigid body physics library.

### GTK+

#### Clearlooks-Phénix (x11-themes/clearlooks-phenix)
[Clearlooks-Phénix](https://github.com/jpfleury/Clearlooks-Phenix) is a GTK+ 3 port of Clearlooks, the default theme for GNOME 2.

#### A Widget Factory (x11-misc/awf)
[A Widget Factory](https://github.com/valr/awf) is a theme preview application that shows most GTK+ widgets for both versions 2 and 3.

### Unstable

#### Prosody (net-im/prosody)
[Prosody](https://prosody.im/) is a modern XMPP communication server aimed at being efficient and easy to configure. This overlay includes a live ebuild for the 0.10 branch of the project.
