# Edit this configuration file to define what should be installed on
# your system.  Help is available in the configuration.nix(5) man page
# and in the NixOS manual (accessible by running ‘nixos-help’).
{ config, pkgs, ... }:
let
  pkg_categories = with pkgs; {
    utils = [
      unzip
      mc
      git
      wget
      neofetch
      termite
      tlp
      upower
      acpi
      herbstluftwm
      lemonbar
      conky
      pulsemixer
      (import ./nvim.nix)
      newsboat
      qemu
      ghc
              ];
    media = [
      mpv
      zathura
      youtube-dl
    ];
   # office = [
   #    ];
    web = [
      qutebrowser
      irssi
      tdesktop
 ];   
    games = [
      steam
      steam-run
     # steam-run-native
     # (steam.override {
     # extraPkgs = pkgs: [mono gtk3 gtk3-x11 libgdiplus zlib ]; nativeOnly = true;})
      (dwarf-fortress.override {
        enableTruetype = true;
        enableStoneSense = true;
        enableSoundSense = true;
	theme = "phoebus";
      })];
  };
in
{
  imports =
    [ # Include the results of the hardware scan.
    ./hardware-configuration.nix
     (import "${builtins.fetchTarball https://github.com/rycee/home-manager/archive/master.tar.gz}/nixos")
  ];
  # Use the systemd-boot EFI boot loader.i
  nixpkgs.config.allowBroken = true;
  boot.extraModprobeConfig = "options kvm_intel nested=1";
  boot.kernelPackages = pkgs.linuxPackages_latest;
  boot.loader.systemd-boot.enable = true;
  boot.loader.efi.canTouchEfiVariables = true;
  boot.supportedFilesystems = ["zfs"];
  boot.zfs.requestEncryptionCredentials = true;
  networking.hostId = "eba86792";
  networking.hostName = "thinkpad-T430-nixos"; # Define your hostname.
  networking.wireless.enable = true;  # Enables wireless support via wpa_supplicant.
  networking.wireless.networks = {
        RT-WiFi_A91C = {
                psk = "qyj4etEd";
};
        Xperia = {
                psk = "vcxz4321";
};
};
  # The global useDHCP flag is deprecated, therefore explicitly set to false here.
  # Per-interface useDHCP will be mandatory in the future, so this generated config
  # replicates the default behaviour.
  networking.useDHCP = false;
  networking.interfaces.enp0s25.useDHCP = true;
  networking.interfaces.wlp3s0.useDHCP = true;
  networking.interfaces.wwp0s20u4i6.useDHCP = true;

 # Select internationalisation properties.
    i18n.defaultLocale = "en_US.UTF-8";
  console = {
    font = "Lat2-Terminus16";
    keyMap = "us";
  };

  # Set your time zone.
  time.timeZone = "Europe/Moscow";
  # Configure Nix
  nix = {
    trustedUsers = [ "root" "@wheel" "lizard" ]; # Make my main user a trusted user so cachix works
  };
  # ---------- Packages and Apps ----------
  nixpkgs.config = {
  packageOverrides = pkgs: {
        unstable = import (fetchTarball https://github.com/NixOS/nixpkgs-channels/archive/nixos-unstable.tar.gz) {
        config = config.nixpkgs.config;
         };
                                   };
                            };
  nixpkgs.config.allowUnfree = true;
  environment.systemPackages = with pkg_categories;
    utils
    ++ media
    ++ web
    ++ games;
  virtualisation.libvirtd.enable = true;
  # ZFS services huh
  services.zfs.autoSnapshot.enable = true;
  services.zfs.autoScrub.enable = true;
  services.zfs.trim.enable = true;
  # services.printing.enable = true;
  sound.enable = true;
  hardware.pulseaudio = {
    enable = true;
    support32Bit = true;
  };
  services.tlp.enable = true;
  services.upower.enable = true;
  # Configure qt5
  #qt5 = {
  # enable = true;
  # platformTheme = "gtk2";
  # style = "plastique";
  #};
  # Enable openGL
  hardware.opengl = {
    enable = true;
    driSupport = true;
    driSupport32Bit = true;
    extraPackages = with pkgs;
      [ vaapiIntel libva ];
    extraPackages32 = with pkgs.pkgsi686Linux; [ libva glew ];
  };
  # Enable compton
  services.compton = {
    enable = true;
    backend = "glx";
    vSync = true;
  };
  # Enable SSD Trimming
  services.fstrim.enable = true;
  # Enable bitlbee
  services.bitlbee.enable = true;
  services.bitlbee.libpurple_plugins = with pkgs; [ purple-matrix telegram-purple purple-discord ];
  # Enable thinkfan
  services.thinkfan = {
    enable = true;
    sensors = ''
                hwmon /sys/devices/virtual/thermal/thermal_zone0/temp
                hwmon /sys/devices/virtual/thermal/thermal_zone1/temp
          '';
    levels = ''
        (0, 0,  64)
        (1, 60, 68)
        (2, 65, 74)
        (3, 70, 82)
        (6, 80, 90)
        (7, 90, 999)
             '';
  };
  # Enable tmux
  #programs.tmux = {
  #  enable = true;
  #  keyMode = "vi";
  #};
  # Enable the X11 windowing system.
  services.xserver.enable = true;

  # Enable touchpad support.
  services.xserver.libinput.enable = true;
  services.xserver.windowManager.herbstluftwm.enable = true;
  services.xserver.exportConfiguration = true;
  services.xserver.layout = "us,ru";
  services.xserver.xkbOptions = "compose:menu, grp:alt_shift_toggle";

  # Set fonts
  fonts.fonts = with pkgs; [
    noto-fonts
    noto-fonts-emoji
    powerline-fonts
    siji
  ];
  # Define a user account. Don't forget to set a password with ‘passwd’.
  users.users.lizard = {
    isNormalUser = true;
    extraGroups = [ "wheel" "networkmanager" ]; # Enable ‘sudo’ and 'networkmanager' for the user.
    shell = pkgs.zsh;
  };
  programs.zsh = {
    enable = true;
    oh-my-zsh = {
      enable = true;
      plugins = ["git" "sudo"];
      theme = "cypher";
    };
  };
  #programs.home-manager.enable = true;
  #programs.home-manager.path = "$HOME/lizard/home-manager";
  # This value determines the NixOS release with which your system is to be
  # compatible, in order to avoid breaking some software such as database
  # servers. You should change this only after NixOS release notes say you
  # should.
  system.stateVersion = "20.03"; # Did you read the comment?
}
