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
work for your machine. However, you can at least reuse some parts you like and
which work for you

Download the configuration with curl, i.e.
```console
curl https://raw.githubusercontent.com/RobWalt/nixos-installation/main/configuration.nix
```

# 2. Editor (Neovim)

## 2.1 Use of Unstable for neovim 0.6.1.

(Note that this step may not be required in the future, but it is always good
to have a more recent version of neovim as long as nothing is broken)

To get access to all of the neovim functionality I want to have, we actually
need to use unstable NixOS. This is the case since stable NixOS only gives us
neovim 0.5.1 at max, when I want neovim 0.6.1.

To change to unstable NixOS, first we need to add the unstable channel in the
command line as follows:
```console
nix-channel --add https://nixos.org/channels/nixos-unstable nixos-unstable
nix-channel --update
```

After that we can actually use it and use a little nix-magic in the
`configuration.nix` file as follows:
```nix
# /etc/nixos/configuration.nix
...
environment.systemPackages = with pkgs;
let 
  unstable = import <nixos-unstable> {  };
in
  [
    unstable.neovim
    ...
  ];
...
```

Then check, if the right version of `nvim` is installed:
```console
nvim --version

>NVIM v0.6.1
```

If this works, then we are set for the next step. You can delete the lines
added to your `configuration.nix` file, since we are going to create an extra
module just for neovim and include it in the `configuration.nix` to prevent
cluttering it.

## 2.2 Add neovim module

We firs start by creating the file `/etc/nixos/nvim.nix`.
```
touch /etc/nixos/nvim.nix
```

(Note: The most recent version of this configuration file is included in this repository)

Now we need to include this file in out `configuration.nix` config.

```nix
# /etc/nixos/configuration.nix
...
imports = 
[
  ./hardware-configuration.nix
  ./nvim.nix # NEW!
]
...
```

In `nvim.nix`, we write the basic nix configuration skeleton, including the definition
of unstable we already made above.

```
# /etc/nixos/nvim.nix
{ pkgs, ... }:
let 
  unstable = import <nixos-unstable> {  };
in 
{
  # content 
  # empty
}
```

First of all, we are just going to include the `neovim` package, its
dependencies and other definitions. Notice that neovim isn't configured in any
way after this step

```nix
# /etc/nixos/nvim.nix
...
environment.variables.EDITOR = "nvim";
environment.systemPackages = with pkgs;
[
  neovim             # neovim 
  clang              # needed for rust-analyzer
  gcc                # needed for tree sitter plugin (doesn't work with clang) 
  git                # needed for tree sitter to download parsers
  rust-analyzer      # rust-analyzer, rust lsp
  rnix-lsp           # nix lsp
];
...
```

Next we can start configuring this instance of `neovim` by using `overlay` and
`override` in a defintion. Overlays have the benefit of changing the definition
of the `neovim` package everywhere in our system. Without that, `neovim` would
be the default version anywhere else in our configs. We do so in the following
way

```nix
# /etc/nixos/nvim.nix
...
environment.variables.EDITOR = "nvim";

nixpkgs.overlays = [
  (self: super: {
    neovim = unstable.neovim.override {
      viAlias = true;
      vimAlias = true;
    };
  })
];

environment.systemPackages = with pkgs;
[
  neovim             # neovim 
  clang              # needed for rust-analyzer
  gcc                # needed for tree sitter plugin (doesn't work with clang) 
  git                # needed for tree sitter to download parsers
  rust-analyzer      # rust-analyzer, rust lsp
  rnix-lsp           # nix lsp
];
...
```

To check, if everything is working, you can `nixos-rebuild` here and try to
enter `vi` or `vim` in the command line. If everything works fine, these
commands should open an instance of `nvim` now.

We can start with the real configuration from here on. First of all, we are going to add the plugins. Just before actually adding the plugins, let me tell you a little lesson I learn here. Some plugin names and with a file suffix, e.g. `treesitter.nvim`. Nix can't parse the dots `.` in these names. It took me a while to figure out that we need to replace the dots with dashes `-` to make it work. This was just a side node, if you plan to add your own favourite plugin with a file suffix ;)

Anyways, here is the next version of `nvim.nix` with plugins added to neovim. Oh by the way, there are several ways to do this, you can choose form different plugin managers. I use vimplug here since I used it outside of NixOS aswell.

```nix
# /etc/nixos/nvim.nix
...
environment.variables.EDITOR = "nvim";

nixpkgs.overlays = [
  (self: super: {
    neovim = unstable.neovim.override {
      viAlias = true;
      vimAlias = true;
      configure = {
        plug.plugins = with pkgs.vimPlugins;
        [
          vim-nix
          gruvbox
          rust-tools-nvim
          nvim-lspconfig
          cmp-nvim-lsp
          cmp-buffer
          nvim-cmp
          cmp-vsnip
          plenary-nvim
          nvim-dap
          popup-nvim
          telescope-nvim
          nvim-treesitter
          nerdtree
          auto-pairs
          ctrlp-vim
        ];
      };
    };
  })
];

environment.systemPackages = with pkgs;
[
  neovim             # neovim 
  clang              # needed for rust-analyzer
  gcc                # needed for tree sitter plugin (doesn't work with clang) 
  git                # needed for tree sitter to download parsers
  rust-analyzer      # rust-analyzer, rust lsp
  rnix-lsp           # nix lsp
];
...
```

After that all plugins should be installed. Some of them might not be enabled
yet so we need to add other configurations normally made in `init.nvim`. We can
do so by extending our configuration. I will only show you how to add one part.
You can add several parts in the same manner. For my whole configuration look
for the `nvim.nix` file in this repository.

Notice that this next example shows how to add normal vimscript-style
configurations aswell as lua configurations. One additional warning: In the
case of adding lua parts to the script, in case of errors, check for trailing
whitespace in the start and end part of the lua part in the configuration, i.e.
whitespace after `lua << EOF` and after `EOF`. This caused some errors for me.

The final version of `nvim.nix`. 

```nix
# /etc/nixos/nvim.nix
...
environment.variables.EDITOR = "nvim";

nixpkgs.overlays = 
let 
  general_settings = ''...'' ;
  ...
  lsp_settings = ''
    autocmd BufWritePre *.nix lua vim.lsp.buf.formatting_sync(nil, 100)
    autocmd BufWritePre *.rs lua vim.lsp.buf.formatting_sync(nil, 100)

    lua << EOF
      require('lspconfig').rnix.setup();
      require('lspconfig').rust_analyzer.setup{
        capabilities = require('cmp_nvim_lsp').update_capabilities(vim.lsp.protocol.make_client_capabilities()),
        settings = {
          ["rust-analyzer"] = {
            assist = {
              importGranularity = "module",
              importPrefix = "by_self",
            },
            cargo = {
              loadOutDirsFromCheck = true,
            },
            procMacro = {
              enable = true,
            },
          },
        },
      };
    EOF
  '';
  ...
in
[
  (self: super: {
    neovim = unstable.neovim.override {
      viAlias = true;
      vimAlias = true;
      configure = {
        plug.plugins = with pkgs.vimPlugins;
        [
          vim-nix
          gruvbox
          rust-tools-nvim
          nvim-lspconfig
          cmp-nvim-lsp
          cmp-buffer
          nvim-cmp
          cmp-vsnip
          plenary-nvim
          nvim-dap
          popup-nvim
          telescope-nvim
          nvim-treesitter
          nerdtree
          auto-pairs
          ctrlp-vim
        ];
        customRC = general_settings 
          + ...
          + lsp_settings
          + ...;
        };
    };
  })
];

environment.systemPackages = with pkgs;
[
  neovim             # neovim 
  clang              # needed for rust-analyzer
  gcc                # needed for tree sitter plugin (doesn't work with clang) 
  git                # needed for tree sitter to download parsers
  rust-analyzer      # rust-analyzer, rust lsp
  rnix-lsp           # nix lsp
];
...
```

And that's it. Neovim should work fine now :)

We can increase readability even more, by modularizing the configuration a bit
more. The settings could be their own modules for instance. I crafted the
following solution to reduce the individual file line counts:

```nix
# /etc/nixos/nvim.nix
...
environment.variables.EDITOR = "nvim";
environment.systemPackages = with pkgs;
let 

...
general_settings = pkgs.callPackage ./general.nix {};
...

myneovim = (unstable.neovim.override {
    viAlias = true;
    vimAlias = true;
    configure = {
      plug.plugins = with pkgs.vimPlugins;
      [
        vim-nix
        gruvbox
        rust-tools-nvim
        nvim-lspconfig
        cmp-nvim-lsp
        cmp-buffer
        nvim-cmp
        cmp-vsnip
        plenary-nvim
        nvim-dap
        popup-nvim
        telescope-nvim
        nvim-treesitter
        nerdtree
        auto-pairs
        ctrlp-vim
      ];
    };

    customRC = general_settings 
      + ...;
  });
in
[
  myneovim           # neovim 
  clang              # needed for rust-analyzer
  gcc                # needed for tree sitter plugin (doesn't work with clang) 
  git                # needed for tree sitter to download parsers
  rust-analyzer      # rust-analyzer, rust lsp
  rnix-lsp           # nix lsp
];
...
```

And then create `lsp_settings.nix` as follows:
```nix
{}:
''
  autocmd BufWritePre *.nix lua vim.lsp.buf.formatting_sync(nil, 100)
  autocmd BufWritePre *.rs lua vim.lsp.buf.formatting_sync(nil, 100)

  lua << EOF
    require('lspconfig').rnix.setup();
    require('lspconfig').rust_analyzer.setup{
      capabilities = require('cmp_nvim_lsp').update_capabilities(vim.lsp.protocol.make_client_capabilities()),
      settings = {
        ["rust-analyzer"] = {
          assist = {
            importGranularity = "module",
            importPrefix = "by_self",
          },
          cargo = {
            loadOutDirsFromCheck = true,
          },
          procMacro = {
            enable = true,
          },
        },
      },
    };
  EOF
''
```

While this approach may seem to be a bit more complex in comparison to
installing neovim just with Home-Manager, we retain more control and the setup
is done system wide, so this configuration is also used by the root user

# 3. Home Manager 

## 3.1. Setting Home Manager Up

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
