Overlay
=======
This is my portage overlay where I put my modified Gentoo packages or my own packages.  Currently this repository contains the following packages:

IcedTea
-------
This version of icedtea has been patched for non-reparenting wm's.  The patch applied is taken straight from [the Debian bug report that proposed a fix](http://bugs.debian.org/cgi-bin/bugreport.cgi?bug=508650).

dwm
---
This package is based on the official Gentoo package, but it downloads the latest git snapshot from my [dwm](https://github.com/fkmclane/dwm) repository.

Armagetron Advanced
-------------------
This repository also contains an ebuild that downloads the latest version of Armagetron Advanced 0.4 and builds it.  It also has a USE flag to build a dedicated server rather than a client.
