# Install guide

## 1. Make bootable stick
This shouldn't be too hard

## 2. Boot into nixos stick image
There are several choices at the start. For high DPI Screens go for the High
DPI option, then choose the 1080p setting and after that select the normal
installation mode (without any extra trailing text)

After that, you will find yourself in nix OS.

First go into sudo mode:
```console
   $ sudo -i
```
There are no passwords set, so it shouldn't prompt you for one.

After that, change the keymap if needed
```console
   $ loadkeys de-latin1
```

## 2.-1 Wifi Setup - Setup
On my machine, my wlan is blocked by `rfkill` by default. To unblock I need to run
```console
   $ rfkill unblock all
```
My wireless interface is also down by default. I need to bring it up with 
```console
   $ ip link set <INTERFACE-NAME> up
```

## 2.1 Wifi Setup

We're going to use an oldschool way of connecting to the internet for the
installation. We are going to connect with wpa_supplicant directly in the
command line.
```console
   $ wpa_supplicant -B -i <INTERFACE-NAME> -c <(wpa_passphrase <SSID> <PASSPHRASE>)
```

Congratulations, you have established a internet connection now!

## 2.2 Partitioning and encryption

### 2.2.1 Erase old stuff

I'm going to install my system on a single block device and I'm going to use
`sda` for this guide. Apply changes to all of the commands below as needed.

First of all, check the current status of the block device. Mine looks like
this:
```console
   $ lsblk
   Name MAJ:MIN RM SIZE RO TYPE MOUNTPOINTS
   ...
   sda  ...
   |--sda1 ...
   |--sda2 ...
   ...
```
Next we need to wipe the current partitioning scheme, if one exists, and create
a new GPT partition table:
```console
   $ parted /dev/sda -- mklabel gpt
```
This is effectively just a deletion step. We need to create the partition table again later

After that, the `lsblk` output should look like this:
```console
   $ lsblk
   Name MAJ:MIN RM SIZE RO TYPE MOUNTPOINTS
   ...
   sda  ...
   ...
```

Next we need to securely erase everything on the block-device we
want to use for our new encrpyted setup. For this, we are going to create a
temporary encrypted container on the device which is going to be encrypted:
```console
   $ cryptsetup open --type plain -d /dev/urandom /dev/sda to_be_wiped
```
This is going to help us overwrite that entrie block device with random data to
prevent cryptographic attacks. After that we can check again, that the new
temporary container exists:
```console
   $ lsblk
   Name MAJ:MIN RM SIZE RO TYPE MOUNTPOINTS
   ...
   sda  …..
   |--to_be_wiped
```

Now its time to wipe the container with zeros:
```console
   $ dd if=/dev/zero of=/dev/mapper/to_be_wiped status=progress
```
This overrides everything on that device starting from our temporary container,
which is everything since nothing comes before the container. This might take a
while. No seriously. Go for a walk or something.

When everything is done, we can close the temporary container and start
partitioning the block device:
```console
   $ cryptsetup close to_be_wiped
```

### 2.2.2 Actually creating partitions (encrpyted ones)

My partition layout here is very simplistic. Feel free to deviate here.

We start by recreating the partition table:
```console
   $ parted /dev/sda -- mklabel gpt
```

After that, we add a root partition with enough space before the partition for
a boot partition and after the partition for a swap file
```console
   $ parted /dev/sda -- mkpart primary 512MiB 100%
```

We don't create a swap file since it will be inside of our encrypted partition.

Finally we create the boot partition, which is of type EFI System Partition
(ESP) and turn it on:
```console
   $ parted /dev/sda -- mkpart ESP fat32 1MiB 512MiB
   $ parted /dev/sda -- set 2 esp on
```

We should end up with partitions as follows:

```console
   $ lsblk
   ...
   sda
   |--sda1 XG
   |--sda2 511M
   ...
```

Next, we are going to create a LUKS encrypted container at the "system"
partition and enter the password for the partition which should be encrypted
twice.
```console
   $ cryptsetup luksFormat /dev/sda1
```

After that, we can open the encrypted container
```console
   $ cryptsetup open /dev/sda1 cryptlvm
```

Next, we create a physical volume on top of the opened LUKS container and
create a volume group.
```console
   $ pvcreate /dev/mapper/cryptlvm
   $ vgcreate <GROUPNAME> /dev/mapper/cryptlvm
```

Create logical volumens on the volume group and format the filesystems as
always. Here we don't need boot anymore!!! I just create a swap and a root partition.
NixOS recommends using a unique symbolic label to the file system to make
system configuration independent from device changes, so we are going to do that.
```console
   $ lvcreate -L 8G <GROUPNAME> -n swap
   $ lvcreate -l 100%FREE <GROUPNAME> -n root

   $ mkfs.ext4 -L nixos /dev/<GROUPNAME>/root
   $ mkswap -L swap /dev/<GROUPNAME>/swap
```

But we are not done here. Remember that boot partition? We still need to format
it! So let's do that.
```console
   mkfs.fat -F32 -n boot /dev/sda2
```

And finally mount your filesystems
```console
   $ mount /dev/disk/by-label/nixos /mnt
   $ mkdir -p /mnt/boot
   $ mount /dev/disk/by-label/boot /mnt/boot
   $ swapon /dev/disk/by-label/swap
```

Phew... Finally done with that we can proceed to install the actual OS :)

## 3. Installing NixOS

Since NixOS is all about its configuration model, we need to install the first
initial configuration of the system. This can be done by command thankfully:

```console
   $ nixos-generate-config --root /mnt
```

After that, we can configure it to suit our needs. First you should check some
things. (see NixOS installation manual for options not shown here)
```console
   $ vim /mnt/etc/nixos/configuration.nix
```

I'm in UEFI mode, so I need to check
```nix
   # /mnt/etc/nixos/configuration.nix
   boot.loader.systemd-boot.enable = true;
   boot.loader.efi.canTouchEfiVariables = true;
```

Since we installed NixOS with an encrypted device, we need to adjust the config
a little more. By default, NixOS would try to find the volume on our encrypted
device on boot. It, however, is not visible since the device is still encrypted
on boot. That's why we need to point NixOS to the unencrypted device containing
the encrypted container.
```nix
   # /mnt/etc/nixos/configuration.nix
   boot.initrd.enable = true;
   boot.initrd.luks.devices = {
     luksroot = {
       device = "/dev/disk/by-uuid/<UUID of /dev/sda1>";
       preLVM = true;
     };
   };
```

(You might want to scroll through the rest of the configuration and look
through the comments. You probably should uncomment a few things there to
enable and install stuff. Otherwise your system will be rather empty.)

Finally it is time to run
```console
   $ nixos-install
```

After that, you are asked to set your password and we can reboot into our freshly installed
```console
   $ reboot
```

# Configuration guide

You can use the configuration of this repository at your own risk. It might not
work for your machine. However, you can at least reuse some parts you like and
which work for you

Download the configuration with curl, i.e.
```console
   $ curl https://raw.githubusercontent.com/RobWalt/nixos-installation/main/configuration.nix
```
