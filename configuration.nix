# Edit this configuration file to define what should be installed on
# your system.  Help is available in the configuration.nix(5) man page
# and in the NixOS manual (accessible by running ‘nixos-help’).

{ config, pkgs, ... }:

{
  imports =
    [ # Include the results of the hardware scan.
      ./hardware-configuration.nix
    ];

  # Use the GRUB 2 boot loader.
  boot.loader.grub.enable = true;
  boot.loader.grub.version = 2;
  # Define on which hard drive you want to install Grub.
  boot.loader.grub.device = "/dev/sda";

   networking.hostName = "Alchemist"; # Define your hostname.
  # networking.wireless.enable = true;  # Enables wireless support via wpa_supplicant.
  networking.networkmanager.enable = true;
  # Select internationalisation properties.
  # i18n = {
  #   consoleFont = "Lat2-Terminus16";
  #   consoleKeyMap = "us";
  #   defaultLocale = "en_US.UTF-8";
  # };

  # Set your time zone.
   time.timeZone = "Asia/Kolkata";

  # List packages installed in system profile. To search by name, run:
  # $ nix-env -qaP | grep wget
   environment.systemPackages = with pkgs; [
     wget
     dbus
     i3status
     dmenu
     firefox
     vim
     emacs
     networkmanagerapplet
     chromium
     python
     zsh
     gparted
     git
     tor
     smplayer
     mplayer
     mpv
     rxvt_unicode-with-plugins
   ];

  # List services that you want to enable:

  # Enable the OpenSSH daemon.
   services.openssh.enable = true;

  # Enable CUPS to print documents.
   services.printing.enable = true;

  # Enable Audio
   hardware.pulseaudio.enable = true;

   services.tor.enable = true;

   programs.ssh.startAgent = true;
   programs.ssh.forwardX11 = true;
  # Enable the X11 windowing system.
   services.xserver = {
    enable = true;
    layout = "us";
    xkbOptions = "ctrl:swapcaps";
    synaptics = {
      enable = true;
      twoFingerScroll = true;
      buttonsMap = [ 1 3 2 ];
      accelFactor = "0.0055";
      minSpeed = "0.95";
      maxSpeed = "1.55";
      palmDetect = true;
    };
    deviceSection = ''
        Option      "AccelMethod"  "sna"
        Option      "TearFree"  "true"
    '';
    windowManager = {
      i3.enable = true;
#      default = "i3-gaps";
      };
    desktopManager.xterm.enable = false;
    displayManager.sessionCommands = ''
      ${pkgs.xorg.xset}/bin/xset r rate 200 50
      ${pkgs.networkmanagerapplet}/bin/nm-applet &
    '';
   };

  fileSystems."/home/nis/IPT" =
  { device = "/dev/sdb4";
    fsType = "ext4";
  };

  # Enable Optimus(hopefully)
  hardware.bumblebee.enable = true;

  users.extraUsers.nis =
  { isNormalUser = true;
    home = "/home/nis";
    description = "Nishant Gupta";
    extraGroups = [ "wheel" "networkmanager" ];
  };
  users.defaultUserShell = "/run/current-system/sw/bin/zsh";

  # The NixOS release to be compatible with for stateful data such as databases.
  system.stateVersion = "16.03";


  nixpkgs.config = {

    allowUnfree = true;

    firefox = {
     enableGoogleTalkPlugin = true;
     enableAdobeFlash = true;
    };

    chromium = {
     enablePepperFlash = true; # Chromium removed support for Mozilla (NPAPI) plugins so Adobe Flash no longer works
     enablePepperPDF = true;
     enableWideVine = true;
     hiDPISupport = true;
    };

  };

}
