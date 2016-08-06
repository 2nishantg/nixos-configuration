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
     chromium
     dbus
     dmenu
     dunst
     emacs
     firefox
     git
     gnumake
     gparted
     htop
     i3status
     mplayer
     mpv
     networkmanagerapplet
     python
     python3
     pythonPackages.pip
     python27Packages.setuptools
     python35Packages.udiskie
     python35Packages.setuptools
     python35Packages.gnureadline
     python35Packages.ipython
     rxvt_unicode-with-plugins
     smplayer
     texlive.combined.scheme-basic
     tor
     vim
     wget
     zsh
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
      i3-gaps.enable = true;
      default = "i3-gaps";
      };
    desktopManager.xterm.enable = false;
    displayManager.sessionCommands = ''
      ${pkgs.xorg.xset}/bin/xset r rate 200 50
      ${pkgs.networkmanagerapplet}/bin/nm-applet &
    '';
    displayManager.slim.defaultUser = "nis";
   };

  fileSystems."/home/nis/IPT" =
  { device = "/dev/sdb4";
    fsType = "ext4";
  };

  # Enable Optimus(hopefully)
  hardware.bumblebee.enable = true;


  # Virtualbox
  virtualisation.virtualbox.host.enable = true;

 services.redshift =
 {
     enable = true;
     latitude = "26.4499";
     longitude = "80.3319";
     temperature.night = 3500;
 };

  users.extraUsers.nis =
  { isNormalUser = true;
    home = "/home/nis";
    description = "Nishant Gupta";
    extraGroups = [ "wheel" "networkmanager" "vboxusers"];
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
