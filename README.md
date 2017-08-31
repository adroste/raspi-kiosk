# raspi-kiosk

## prep

1. flash headless image to sd card
2. copy files to `/home/pi`
3. insert sd card into pi, connect kb, display, lan
4. boot up & login
5. take ownership of copied files
6. `sudo apt-get update` & `sudo apt-get upgrade`

## midori

further info: https://maker-tutorials.com/autostart-midori-browser-vollbild-kiosk-mode-via-konsole-ohne-desktop/

#### install

1. `sudo apt-get install midori matchbox x11-xserver-utils xinit`
2. prepare `/home/pi/startkiosk.sh` (dont forget chmod +x)

#### usage

* start: `sudo xinit /home/pi/startkiosk.sh`
* stop: `CTRL + ALT + F1` (via console: `CTRL + c`)

## internet via usb-modem

#### install

1. `sudo apt-get install usb-modeswitch ppp wvdial`
2. reboot
3. setup `/etc/wvdial.conf`
4. unplug other networks

#### usage

* start: `sudo wvdial congstar &`
* stop: `ps auxwww| egrep wvdial` -> `sudo kill <pid>`


## autostart everything

1. setup `/etc/rc.local`
2. setup `/etc/crontab`

## reduce sd-card io

further info: https://www.datenreise.de/raspberry-pi-stabiler-24-7-dauerbetrieb/

* move `/var/log` & `/tmp` to ram by adding following to `/etc/fstab`:

  * ```bash
    none        /var/log        tmpfs   size=5M,noatime         00
    none        /tmp        tmpfs   defaults,noatime         00
    ```

* deactivate swapping:

  * ```bash
    sudo dphys-swapfile swapoff
    sudo systemctl disable dphys-swapfile
    sudo apt-get purge dphys-swapfile
    ```

## watchdog

```bash
sudo apt-get install watchdog
sudo modprobe bcm2835_wdt
echo "bcm2835_wdt" | sudo tee -a /etc/modules
```

1. `sudo vim /etc/watchdog.conf`

2. uncomment: `watchdog-device = /dev/watchdog` & `max-load-1 = 24`

3. `sudo vim /lib/systemd/system/watchdog.service`

4. change to: `[Install]WantedBy=multi-user.target`

5. ```bash
   sudo systemctl enable watchdog.service
   sudo systemctl start watchdog.service
   ```

