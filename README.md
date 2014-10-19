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
### dwm ###
Dwm is a dynamic (tiling and floating) window manager for X. This package uses my version from my [dwm](https://github.com/fkmclane/dwm) repository. This overlay also includes a package for my dwmstatus also located in the repository.

### Armagetron Advanced ###
[Armagetron Advanced](http://armagetronad.org) is a fast-paced 3D implementation of lightcycles from the movie Tron. It features both single-player and multiplayer modes with online servers that have extensive configurability. This package includes the current stable release, 0.2.8, and the current bzr snapshot, 0.4.

### Pipelight ###
[Pipelight](https://launchpad.net/pipelight) is a browser plugin that allows running Windows browser plugins in Wine in native browsers. It includes support for Silverlight, Adobe Flash, Adobe Shockwave, and Unity Webplayer. It requires Wine with the Compholio patches to run Silverlight or any DRM content.

### Primus ###
Primus is a LibGL bridge for people with two GPUs, one that outputs to the screen, and one that performs the heavy lifting. Primus is designed to be used in conjunction with Bumblebee, available in the official repository. Note: This package was taken, largely unmodified, from the [Bumblebee Overlay](https://github.com/Bumblebee-Project/bumblebee-gentoo).

### libopenshot ###
The OpenShot Library is a high quality video editing library that will power OpenShot 2.0. This repository includes both the libopenshot package and the libopenshot-audio package and a supporting package, unittest++. Note: To build libopenshot, qt5 is necessary and can (currently) be found in the qt overlay, `# layman -a qt`.

### Plex Media Server/Plex Home Theater ###
[Plex](http://plex.tv) is a service that allows convenient access to central media over a variety of devices. Plex Home Theater is an XBMC based client for Plex that includes a nice ten-foot interface and is designed for connecting to the television.

### Chrome Remote Desktop ###
[Chrome Remote Desktop](http://chrome.google.com/remotedesktop) is an application that integrates with Chrome or Chromium and allows one to remotely access their computer or receive assistance securely.

### awf ###
[A Widget Factory](https://github.com/valr/awf) is a theme preview application that shows most GTK+ widgets for both versions 2 and 3.

### Clearlooks-Phenix ###
[Clearlooks-Phenix](https://github.com/jpfleury/Clearlooks-Phenix) is a GTK+ 3 port of Clearlooks, the default theme for GNOME 2.

### finit ###
[finit](https://github.com/troglobit/finit) is **f**ast **init** system supporting plugins and a configuration file.

### Mumble/Murmur ###
[Mumble](http://mumble.info/) is an open source, low-latency, high quality voice chat software designed with gamers in mind.

### Deluge ###
[Deluge](http://deluge-torrent.org/) is a lightweight client-server model BitTorrent client that includes GTK+, CLI, and web interfaces.

### Namecoin ###
[Namecoin](http://namecoin.info) is a decentralized open source information registration and transfer system based on the Bitcoin cryptocurrency.

### Nyancat ###
[Nyancat](https://github.com/klange/nyancat) is a CLI implementation of the famous poptart cat that supports many types of terminal.
