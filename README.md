Overlay
=======
This is my Portage overlay where I dump all of the packages I create or modify.

Installation
------------
The easiest way to add this overlay to your Portage tree is through layman.

```
# layman -a fkmclane
```

Packages
--------
#### dwm (x11-wm/dwm, x11-misc/dwmstatus) ####
[dwm](http://dwm.suckless.org/) is a simplistic, dynamic (tiling and floating) window manager for X. This package uses my version from my [dwm](https://github.com/fkmclane/dwm) repository. This overlay also includes a package for my dwmstatus also located in my repository.

#### Armagetron Advanced (games-action/armagetronad, games-action/armagetronad-dedicated) ####
[Armagetron Advanced](http://armagetronad.org/) is a fast-paced 3D implementation of lightcycles from the movie Tron. It features both single-player and multiplayer modes with online servers that have extensive configurability. This package includes the current stable release, 0.2.8, and the current bzr snapshot, 0.4.

#### Pipelight (www-plugins/pipelight) ####
[Pipelight](http://pipelight.net/) is a browser plugin that allows running Windows browser plugins in Wine in native browsers. It includes support for Silverlight, Adobe Flash, Adobe Shockwave, and Unity Webplayer. It requires Wine with the Compholio patches to run Silverlight or any DRM content.

#### OpenShot (media-libs/libopenshot, media-libs/libopenshot-audio) ####
[OpenShot Library](https://launchpad.net/libopenshot) is a high quality video editing library that powers OpenShot 2.0.

#### Plex (media-tv/plex-media-server, media-tv/plex-home-theater) ####
[Plex](http://plex.tv/) is a service that allows convenient access to central media over a variety of devices. Plex Home Theater is an XBMC based client for Plex that includes a nice ten-foot interface and is designed for connecting to the television. Note: Plex Pass users can unmask the packages to get the latest Plex Pass versions.

#### Chrome Remote Desktop (net-misc/chrome-remote-desktop) ####
[Chrome Remote Desktop](http://chrome.google.com/remotedesktop) is an application that integrates with Chrome or Chromium and allows one to remotely access their computer or receive assistance securely.

#### A Widget Factory (x11-misc/awf) ####
[A Widget Factory](https://github.com/valr/awf) is a theme preview application that shows most GTK+ widgets for both versions 2 and 3.

#### Clearlooks-Phénix (x11-themes/clearlooks-phenix) ####
[Clearlooks-Phénix](https://github.com/jpfleury/Clearlooks-Phenix) is a GTK+ 3 port of Clearlooks, the default theme for GNOME 2.

#### finit (sys-apps/finit) ####
[finit](https://github.com/troglobit/finit) is a **f**ast **init** system supporting plugins and a configuration file.

#### Nyancat (games-misc/nyancat) ####
[Nyancat](https://github.com/klange/nyancat) is a CLI implementation of the famous poptart cat.

#### nSnake (games-arcade/nsnake) ####
[nSnake](https://github.com/alexdantas/nSnake) is a clone of the classic snake game on the terminal.

#### maim (media-gfx/maim) ####
[maim](https://github.com/naelstrof/maim) (make image) is a utility that takes screenshots of your desktop and is designed to be an improved scrot. It optionally uses [slop](https://github.com/naelstrof/slop) for screen selections.

#### m64py (games-emulation/m64py) ####
[m64py](http://m64py.sourceforge.net/) is a PyQt4 front-end to the [mupen64plus](https://code.google.com/p/mupen64plus/) N64 emulator.

#### GoAccess (net-analyzer/goaccess) ####
[GoAccess](http://goaccess.io/) is an open source real-time web log analyzer and interactive viewer that runs in a terminal.

#### Prosody (net-im/prosody) ####
[Prosody](https://prosody.im/) is a modern XMPP communication server aimed at being efficient and easy to configure. This overlay includes a live ebuild for the 0.10 branch of the project.

#### Sync Mail Dir (net-mail/syncmaildir) ####
[Sync Mail Dir](http://syncmaildir.sourceforge.net/) (smd) is a set of tools to synchronize a pair of mailboxes in Maildir format. It is useful for IMAP-less client-server mail synchronization and for Maildir transistion.

#### VMPK (media-sound/vmpk) ####
[VMPK](http://vmpk.sourceforge.net/) is a virtual midi keyboard that uses [drumstick](http://drumstick.sourceforge.net/) for its backend. This overlay will temporarily host the Qt 5 version, 0.6.0.

#### WebcamStudio (media-video/webcamstudio, media-video/webcamstudio-module) ####
[WebcamStudio](https://code.google.com/p/webcamstudio/) is a live video mixer often used in conjunction with a virtual webcam driver to create professional looking broadcasts.
