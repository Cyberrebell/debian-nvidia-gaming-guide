# Debian Gaming Guide using Nvidia GPU

## Why should I use Linux for gaming?
* All big game-engines are supporting OpenGL
* with SteamOS Valve will force publishers to port there games
* playing windows games pre-DX10 is possible with WINE
* use the GPU manufacturers linux drivers for full use of your high-end hardware

## Why should I use Debian rather then Ubuntu or other distros?
* Calling Debian better than other distros would be wrong.
* Debian is one of the oldest distro and offers a lot of useful packages.
* It is well known that all updates are kept back for a while for security and stability reasons.
* Debian is the root of some other linux distros like Ubuntu and SteamOS.

## Installing some basicly required packages
* ToDo

## Installing the Nvidia manufacturer driver
* download your matching version from nvidia.de
* start debian in command-line mode (select the bootmenu option)
* login as root and navigate to the download directory
* chmod +x the downloaded file and execute it

## Fix the tearing problem
* modify /etc/X11/xorg.conf
* search the Screen-Section
* add the two Option-Lines from the following sample
```
Section "Screen"
    Identifier     "Screen0"
    Device         "Device0"
    Monitor        "Monitor0"
    DefaultDepth    24
    Option         "metamodes" "nvidia-auto-select +0+0 { ForceFullCompositionPipeline = On }"
    Option         "TripleBuffer" "on"
    SubSection     "Display"
        Depth       24
    EndSubSection
EndSection
```
* reboot

## Improve GPU-Fan control
* If games are crashing or start lagging after a long time maybe your system is getting very hot and you never heared your GPU-Fan doing any work.
* By default the GPU-Fan control may vary between 20% and 30% of the maximum fan speed which is not enough for high-end games.
* It is possible to use a script that will adjust the fan speed to reach the target temperature automaticly.
* To allow scripts to change the GPU-Fan speed add the following line to your /etc/X11/xorg.conf into the Device-Section
```
Option "Coolbits" "4"
```
* I created "gpu_fan_target.sh" to do this. You can download it from this repository and add it to your autostart scripts.
* You can edit the "target_temperature" in the script if you like

## Common Problems

### Debian ist starting in Command Line mode. There is no GUI anymore.
Solution: Reinstall the graphic driver. It must be rebuilt after x11 updates.

### There is an error on installing the graphic driver related to linux-headers
Solution: You have to add the latest linux-headers to build the graphic driver successful
```
apt-get install linux-headers-$(uname -r)
```
