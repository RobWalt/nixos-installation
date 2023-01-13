# Install guide (Updated: 2023-01-12)

## 0. Other Docs

I think it's more important to have some general docs to look after instead of
me explaining everything again if there's stuff out there. So before you read
my explanations, please take a look if one of the following sources fits your
taste aswell and just go with it instead. Spread the word!

- [nix.dev tutorial series](nix.dev/tutorials)
- [Noogle](noogle.dev)

## 1. Make bootable stick
This shouldn't be too hard

## 2. Boot into nixos stick image
There are several choices at the start. For high DPI Screens go for the High
DPI option, then choose the 1080p setting and after that select the normal
installation mode (without any extra trailing text)

After that, you will find yourself in nix OS.

First go into sudo mode:
```console
sudo -i
```
There are no passwords set, so it shouldn't prompt you for one.

After that, change the keymap if needed
```console
loadkeys de-latin1
```

## 2.1 Partitioning and encryption

### 2.1.1 Erase old stuff

If you have your hard drive encrypted and you are lazy like I am, just use an
Ubuntu image or something to zap everything (including the encryption) from the
hard drive.

If you know what you're doing, go ahead and do it your way.
### 2.1.2 Creating partitions (encrpyted ones)

My partition layout here is very simplistic. Feel free to deviate here.

We start by recreating the partition table:
```console
parted /dev/sda -- mklabel gpt
```

After that, we add a root partition with enough space before the partition for
a boot partition and after the partition for a swap file
```console
parted /dev/sda -- mkpart primary 512MiB 100%
```

We don't create a swap file since it will be inside of our encrypted partition.

Finally we create the boot partition, which is of type EFI System Partition
(ESP) and turn it on:
```console
parted /dev/sda -- mkpart ESP fat32 1MiB 512MiB
parted /dev/sda -- set 2 esp on
```

We should end up with partitions as follows:

```console
lsblk
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
cryptsetup luksFormat /dev/sda1
```

After that, we can open the encrypted container
```console
cryptsetup open /dev/sda1 cryptlvm
```

Next, we create a physical volume on top of the opened LUKS container and
create a volume group.
```console
pvcreate /dev/mapper/cryptlvm
vgcreate <GROUPNAME> /dev/mapper/cryptlvm
```

Create logical volumens on the volume group and format the filesystems as
always. Here we don't need boot anymore!!! I just create a swap and a root partition.
NixOS recommends using a unique symbolic label to the file system to make
system configuration independent from device changes, so we are going to do that.
```console
lvcreate -L 8G <GROUPNAME> -n swap
lvcreate -l 100%FREE <GROUPNAME> -n root

mkfs.ext4 -L nixos /dev/<GROUPNAME>/root
mkswap -L swap /dev/<GROUPNAME>/swap
```

But we are not done here. Remember that boot partition? We still need to format
it! So let's do that.
```console
   mkfs.fat -F32 -n boot /dev/sda2
```

And finally mount your filesystems
```console
mount /dev/disk/by-label/nixos /mnt
mkdir -p /mnt/boot
mount /dev/disk/by-label/boot /mnt/boot
swapon /dev/disk/by-label/swap
```

Phew... Finally done with that we can proceed to install the actual OS :)

## 3. Installing NixOS

Since NixOS is all about its configuration model, we need to install the first
initial configuration of the system. This can be done by command thankfully:

```console
nixos-generate-config --root /mnt
```

After that, we can configure it to suit our needs. First you should check some
things. (see NixOS installation manual for options not shown here)
```console
vim /mnt/etc/nixos/configuration.nix
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

You can check the UUID of your hard drive with
```console
lsblk -f
```

(You might want to scroll through the rest of the configuration and look
through the comments. You probably should uncomment a few things there to
enable and install stuff. Otherwise your system will be rather empty.)

Finally it is time to run
```console
nixos-install
```

After that, you are asked to set your password and we can reboot into our freshly installed
```console
reboot
```

# Configuration guide

## 0. Cheating

You can use the configuration of this repository at your own risk. It might not
work for your machine and you have to teak a few values. However, you can at
least reuse some parts you like and which work for you

Download the configuration with curl, i.e.
```console
curl https://raw.githubusercontent.com/RobWalt/nixos-installation/main/configuration.nix
```

# 1. Home Manager 

## 1.1. Setting Home Manager Up

Home manager is a convenient way of managing files which would be located in
the home directory on normal systems.

To install home-manager, we first start with a whole new module called
`home.nix` and insert this boilerplate into it:

(don't forget to import it in the `configuration.nix` file)

```nix
# /etc/nixos/home.nix
{ pkgs, ... }:
let 
  home-manager = builtins.fetchTarball "https://github.com/nix-community/home-manager/archive/master.tar.gz";
in
{
  import = [
    (import "${home-manager}/nixos")
  ];

  home-manager.users.YOUR_USERNAME_HERE = {
    programs.home-manager.enable = true;
  };
}
```

If you did everything the right way, this should throw no errors on `nixos-rebuild switch`.

Next, we can add a little example configuration for git.

```nix
# /etc/nixos/home.nix
{ pkgs, ... }:
let 
  home-manager = builtins.fetchTarball "https://github.com/nix-community/home-manager/archive/master.tar.gz";
in
{
  import = [
    (import "${home-manager}/nixos")
  ];

  home-manager.users.YOUR_USERNAME_HERE = {
    programs.home-manager.enable = true;

    programs.git = {
      enable = true;
      userName = "YOUR_GIT_USERNAME_HERE";
      userEmail = "YOUR_GIT_EMAIL_HERE";
    };
  };
}
```

Congrats, this should also work and now your git information will automatically
be filled in on every rebuild of your system.

# 2. Editor (Neovim v0.8.1)

## 2.1 Basic install

Since I want to have a configurated `nvim` when logged in as root, but also
don't want to give away using it from Home-Manager when not logged in as root,
I installed it both ways. It might seem a little weird at first, but the
weirdness is just part of enabling us to reuse the configuration files later
on.

### 2.1.1 Home-Manager

Let's take a look first at how a basic Home-Manager nvim install is done:

```nix 
  programs.neovim = {
    enable = true;

    viAlias = true;
    vimAlias = true;
    vimdiffAlias = true;

    withNodeJs = true;
    withPython3 = true;
    withRuby = false;
  };
```

It's basically just plug an play. Note that I also used the options to have the
JS and Python features in the nvim version that's installed.

### 2.1.2 System install

The system wide install isn't much more difficult either

```nix
  nixpkgs.overlays =
    [
      (self: super: {
        neovim = super.neovim.override {
          # TODO
        };
      })
    ];

  environment.systemPackages = with pkgs;
    [
      neovim
      clang # needed for rust-tools
      gcc # needed for treesitter compilation
      git # needed for treesitter download
      rnix-lsp # nix lsp
      ce.marksman # markdown lsp
      #rust-analyzer
    ];
```

It looks a bit akward to use such a naked overlay, but we will add our
configuration files soon where I put the `TODO` comment for now. Note, that I
also grouped some other system packages beneath the neovim overlay, just to
have an eye on it. Some of these packages are dependencies for plugins and
others are purely used by neovim, so I figured it would make sense to put them
there

## 2.2 Neovim configuration

### 2.2.1 Preparations

First, we need to do some setup. In a separate file, e.g. `vimplugins.nix` add the following:

```nix
{ pkgs, lib, fetchFromGitHub, ... }:
let
  # enables us to use nvim plugins which are not yet available on nixpkgs but on github
  pluginGit = version: ref: repo: pkgs.vimUtils.buildVimPluginFrom2Nix {
    pname = "${lib.strings.sanitizeDerivationName repo}";
    version = version;
    src = builtins.fetchGit {
      url = "https://github.com/${repo}.git";
      ref = ref;
    };
  };
  # easy to use version of the function above
  plugin = pluginGit "HEAD" "HEAD";
in
{
  # TODO
}
```

These are just convenience functions for getting plugins that are not available
through `nixpkgs`. Now, we can add the meat to this file. We split the file
into two major sections:

- Plugin config
- general config

### 2.2.2 Plugin config

A vim plugin in our config has one of the following two formats:

1. Simple Plugin without extra configuration
  - nixpkgs: Use the plugin name, replace "." in "plenary.nvim" with "-" so we
    have "plenary-nvim"
  - github: Use `(plugin "<RepoOwner>/<RepoName>")`
2. Plugin with extra configuration 
  Use 
  ```nix 
{
  plugin = <PluginName as in 1.>;
  config = lib.readFile <PathToConfigOfPlugin>
}
  ```

Here `<PathToConfigOfPlugin>` is just your regular plugin configuration in a
`.lua` file. The only special part about the config is, that it has to start
with `lua << EOF` and end with `EOF` since it will be included in a vim config
file later so that nvim can identify the code is `lua` code.

Then we just define a list of these plugin entries, which is a field in our `vimplugins.nix` file. Here is an example: 

```nix
  myvimplugins = with pkgs.vimPlugins; with lib;
    [
      # LSP
      {
        plugin = nvim-lspconfig;
        config = readFile ./neovim/lsp.lua;
      }

      # dependency of many things
      plenary-nvim

      # non nixpkgs plugin
      {
        plugin = (plugin "m-demare/hlargs.nvim");
        config = readFile ./neovim/hlargs.lua;
      }

      (plugin "sainnhe/everforest")
    ];
```

### 2.2.3 General config

The general config will just be provided as plain text. We can create several files with general purposes. I use the following modularization:

```
  ./neovim/general.lua      # neovim settings
  ./neovim/colorscheme.lua  # colors
  ./neovim/keybindings.lua  # key maps
```

Once we have these files, we just concat them and add a field in our `vimplugins.nix` file as follows:

```nix
  myvimextraconfig =
    let
      listOfContent = map lib.readFile [
        ./neovim/general.lua
        ./neovim/colorscheme.lua
        ./neovim/keybindings.lua
      ];
    in
    lib.concatStringsSep "\n" listOfContent;
```

## 2.3 Using the configs

### 2.3.1 Home-Manager

Adjust the configuration as follows

```nix
  programs.neovim = {

    enable = true;

    viAlias = true;
    vimAlias = true;
    vimdiffAlias = true;

    withNodeJs = true;
    withPython3 = true;
    withRuby = false;

    # NEW!
    plugins = (pkgs.callPackage ../vimplugins.nix {}).myvimplugins;
    # NEW!
    extraConfig = (pkgs.callPackage ../vimplugins.nix {}).myvimextraconfig;
  };
```

### 2.3.1 System packages

Adjust the configuration as follows

```nix 
  nixpkgs.overlays =
    [
      (self: super: {
        neovim = super.neovim.override {
          configure = {
            packages.main = { start = (pkgs.callPackage ../vimplugins.nix { }).myvimplugins; };
            customRC = (pkgs.callPackage ../vimplugins.nix { }).myvimextraconfig;
          };
        };
      })
    ];
```

