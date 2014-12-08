Overlay
=======
This is my Portage overlay where I dump all of the packages I create or modify.

Installation
------------
The easiest way to add this overlay to your Portage tree is through layman.

```
# layman -o https://raw.githubusercontent.com/fkmclane/overlay/master/repositories.xml -a fkmclane
```

Packages
--------
#### dwm (x11-wm/dwm, x11-misc/dwmstatus) ####
[dwm](http://dwm.suckless.org/) is a simplistic, dynamic (tiling and floating) window manager for X. This package uses my version from my [dwm](https://github.com/fkmclane/dwm) repository. This overlay also includes a package for my dwmstatus also located in my repository.

#### Armagetron Advanced (games-action/armagetronad, games-action/armagetronad-dedicated) ####
[Armagetron Advanced](http://armagetronad.org/) is a fast-paced 3D implementation of lightcycles from the movie Tron. It features both single-player and multiplayer modes with online servers that have extensive configurability. This package includes the current stable release, 0.2.8, and the current bzr snapshot, 0.4.

#### Pipelight (www-plugins/pipelight) ####
[Pipelight](http://pipelight.net/) is a browser plugin that allows running Windows browser plugins in Wine in native browsers. It includes support for Silverlight, Adobe Flash, Adobe Shockwave, and Unity Webplayer. It requires Wine with the Compholio patches to run Silverlight or any DRM content.

#### Primus (x11-misc/primus) ####
[Primus](https://github.com/amonakov/primus) is a LibGL bridge for people with two GPUs, one that outputs to the screen and one that performs the heavy lifting of rendering. Primus is designed to be used in conjunction with Bumblebee, available in the official repository. Note: This package was taken, largely unmodified, from the [Bumblebee Overlay](https://github.com/Bumblebee-Project/bumblebee-gentoo).

#### OpenShot (media-libs/libopenshot, media-libs/libopenshot-audio) ####
[OpenShot Library](https://launchpad.net/libopenshot) is a high quality video editing library that powers OpenShot 2.0.

#### Plex (media-tv/plex-media-server, media-tv/plex-home-theater) ####
[Plex](http://plex.tv/) is a service that allows convenient access to central media over a variety of devices. Plex Home Theater is an XBMC based client for Plex that includes a nice ten-foot interface and is designed for connecting to the television. Note: Plex Pass users can unmask the packages to get the latest Plex Pass versions.

#### Chrome Remote Desktop (net-misc/chrome-remote-desktop) ####
[Chrome Remote Desktop](http://chrome.google.com/remotedesktop) is an application that integrates with Chrome or Chromium and allows one to remotely access their computer or receive assistance securely.

#### A Widget Factory (x11-misc/awf) ####
[A Widget Factory](https://github.com/valr/awf) is a theme preview application that shows most GTK+ widgets for both versions 2 and 3.

#### Clearlooks-Phenix (x11-themes/clearlooks-phenix) ####
[Clearlooks-Phenix](https://github.com/jpfleury/Clearlooks-Phenix) is a GTK+ 3 port of Clearlooks, the default theme for GNOME 2.

#### finit (sys-apps/finit) ####
[finit](https://github.com/troglobit/finit) is a **f**ast **init** system supporting plugins and a configuration file.

#### Mumble/Murmur (media-sound/mumble, media-sound/murmur) ####
[Mumble](http://mumble.info/) is an open source, low-latency, high quality voice chat software designed with gamers in mind.

#### Deluge (net-p2p/deluge) ####
[Deluge](http://deluge-torrent.org/) is a lightweight client-server model BitTorrent client that includes GTK+, CLI, and web interfaces.

#### Namecoin (net-dns/namecoind, net-dns/namecoin-qt) ####
[Namecoin](http://namecoin.info/) is a decentralized open source information registration and transfer system based on the Bitcoin cryptocurrency. This repository includes packages for both the headless daemon and the Qt client.

#### Nyancat (games-misc/nyancat) ####
[Nyancat](https://github.com/klange/nyancat) is a CLI implementation of the famous poptart cat.

#### nSnake (games-arcade/nsnake) ####
[nSnake](https://github.com/alexdantas/nSnake) is a clone of the classic snake game on the terminal.
