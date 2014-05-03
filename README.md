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

### Wine (Compholio Patches) ###
The Wine package in this overlay can optionally include the [Compholio](http://www.compholio.com/wine-compholio/) patches. These patches mostly add support for Silverlight.

### Pipelight ###
[Pipelight](https://launchpad.net/pipelight) is a browser plugin that allows running Windows browser plugins in Wine in native browsers. It includes support for Silverlight, Adobe Flash, Adobe Shockwave, and Unity Webplayer. It requires Wine with the Compholio patches to run Silverlight or any DRM content.
