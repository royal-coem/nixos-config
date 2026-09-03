# Edit this configuration file to define what should be installed on
# your system.  Help is available in the configuration.nix(5) man page
# and in the NixOS manual (accessible by running ‘nixos-help’).

{ config, pkgs, ... }:

{
  imports =
    [ # Include the results of the hardware scan.
      ./hardware-configuration.nix
    ];

  # Bootloader.
  boot.loader.grub.enable = true;
  boot.loader.grub.efiSupport = true;
  boot.loader.efi.canTouchEfiVariables = true;
  boot.loader.grub.device = "nodev";
  boot.loader.grub.useOSProber = true;

  networking.hostName = "nixos"; # Define your hostname.
  # networking.wireless.enable = true;  # Enables wireless support via wpa_supplicant.

  # Configure network proxy if necessary
  # networking.proxy.default = "http://user:password@proxy:port/";
  # networking.proxy.noProxy = "127.0.0.1,localhost,internal.domain";

  # Enable networking
  networking.networkmanager.enable = true;

  # Set your time zone.
  time.timeZone = "Europe/Paris";

  # Select internationalisation properties.
  i18n.defaultLocale = "fr_FR.UTF-8";

  i18n.extraLocaleSettings = {
    LC_ADDRESS = "fr_FR.UTF-8";
    LC_IDENTIFICATION = "fr_FR.UTF-8";
    LC_MEASUREMENT = "fr_FR.UTF-8";
    LC_MONETARY = "fr_FR.UTF-8";
    LC_NAME = "fr_FR.UTF-8";
    LC_NUMERIC = "fr_FR.UTF-8";
    LC_PAPER = "fr_FR.UTF-8";
    LC_TELEPHONE = "fr_FR.UTF-8";
    LC_TIME = "fr_FR.UTF-8";
  };

  # Enable the X11 windowing system.
  # You can disable this if you're only using the Wayland session.
  services.xserver.enable = true;

  # Enable the KDE Plasma Desktop Environment.
  services.displayManager.sddm.enable = true;
  services.desktopManager.plasma6.enable = true;

  #bureau hyprland
  programs.hyprland.enable = true;

  # Configure keymap in X11
  services.xserver.xkb = {
    layout = "fr";
    variant = "azerty";
  };

  # Configure console keymap
  console.keyMap = "fr";

  # Enable CUPS to print documents.
  services.printing.enable = true;

  # Enable sound with pipewire.
  services.pulseaudio.enable = false;
  security.rtkit.enable = true;
  services.pipewire = {
    enable = true;
    alsa.enable = true;
    alsa.support32Bit = true;
    pulse.enable = true;
    # If you want to use JACK applications, uncomment this
    #jack.enable = true;

    # use the example session manager (no others are packaged yet so this is enabled by default,
    # no need to redefine it in your config for now)
    #media-session.enable = true;
  };

  # Enable touchpad support (enabled default in most desktopManager).
  # services.xserver.libinput.enable = true;

  programs.zsh = {
    enable = true;
    autosuggestions.enable = true;
    syntaxHighlighting.enable = true;
    promptInit = "source ${pkgs.zsh-powerlevel10k}/share/zsh-powerlevel10k/powerlevel10k.zsh-theme";
  
    interactiveShellInit = ''
    fetch
  '';

  shellAliases = {
    nixconf = "sudo nvim ~/nixos-config/configuration.nix";
    nswitch = "sudo nixos-rebuild switch --flake ~/nixos-config/#nixos";
    homenix = "sudo nvim ~/nixos-config/home.nix";
    flakenix = "sudo nvim ~/nixos-config/flake.nix";
    hyprconf = "sudo nvim ~/nixos-config/dotfiles/hypr/hyprland.conf";
    nixlist = "sudo nixos-rebuild list-generations";
    delconf = "sudo nix-env --profile /nix/var/nix/profiles/system --delete-generations";
    nixclean = "sudo nix-collect-garbage -d";
  };
 };
 
  nix.gc = {
  automatic = true;
  dates = "weekly";
  options = "--delete-older-than 7d";
 };

  virtualisation.libvirtd = {
    enable = true;
    qemu = {
      package = pkgs.qemu_kvm;
      runAsRoot = true;
    };

  };
 
  xdg.portal = {
    enable = true;
    extraPortals = [
      pkgs.xdg-desktop-portal-hyprland
      pkgs.xdg-desktop-portal-gtk
    ];
    config = {
      common = {
        default = [ "hyprland" "gtk" ];
      };
      hyprland = {
        default = [ "hyprland" "gtk" ];
      };
    };
  };

  # 2. Configurer OBS Studio avec les wrappers Wayland / PipeWire
  programs.obs-studio = {
    enable = true;
    plugins = with pkgs.obs-studio-plugins; [
      wlrobs
      obs-vkcapture
      obs-pipewire-audio-capture
    ];
  };

  # Define a user account. Don't forget to set a password with ‘passwd’.
  users.users."royalc" = {
    isNormalUser = true;
    description = "royalc";
    shell = pkgs.zsh;
    extraGroups = [ "networkmanager" "wheel" "libvirtd" "kvm" ];
    packages = with pkgs; [
      kdePackages.kate
      # UI & Desktop
      rofi
      waybar
      swaynotificationcenter
      awww
      hyprlock
      hypridle
      fetch
      font-awesome
      nerd-fonts.jetbrains-mono
      swaynotificationcenter
  
      # Outils & Système
      kitty
      grim
      slurp
      swappy
      cliphist
      pavucontrol
      btop
      fastfetch
      wl-clipboard
      pinta
  
      # Apps
      vscode
      mpv
      # thunderbird
    ];
  };

  # Install firefox
  programs.firefox.enable = true;

  # 2. Activer le module Steam
  programs.steam = {
    enable = true;
    remotePlay.openFirewall = true; # Optionnel
    dedicatedServer.openFirewall = true; # Optionnel
  };
  # Allow unfree packages
  nixpkgs.config.allowUnfree = true;

  # Activer le support de Discover et PackageKit
  services.packagekit.enable = true;

  # Si tu veux aussi utiliser les applications Flatpak via Discover (très recommandé)
  services.flatpak.enable = true;

  systemd.services.packagekit.wantedBy = [ "multi-user.target" ];

  # List packages installed in system profile. To search, run:
  # $ nix search wget
  environment.systemPackages = with pkgs; [
    neovim # Do not forget to add an editor to edit configuration.nix! The Nano editor is also installed by default.
    wget
    fastfetch
    wl-clip-persist
    wl-clipboard
    git
    brave
    cava
    cmatrix
    playerctl
    jdk8
    jdk17
    jdk21
    jdk25

    # UI & Desktop
    rofi
    waybar
    swaynotificationcenter
    awww
    hyprlock
    hypridle
    font-awesome
    nerd-fonts.jetbrains-mono
    fetch
    hyprpaper
    psmisc
    
    # Outils & Système
    kitty
    grim
    slurp
    swappy
    cliphist
    pavucontrol
    btop
    fastfetch
    wl-clipboard
    pinta
    libnotify
    wev
    evtest

    # Apps
    vscode
    mpv
    thunderbird
    brave
    vesktop
    modrinth-app
    kdePackages.discover
    firefox
    easyeffects
    mapscii
    pipes
    jq
    unzip
    cbonsai
    gnome-boxes
    (pkgs.wrapOBS {
    plugins = with pkgs.obs-studio-plugins; [
      wlrobs
      obs-pipewire-audio-capture
      obs-vkcapture
     ];
    })
   ];

  # Some programs need SUID wrappers, can be configured further or are
  # started in user sessions.
  # programs.mtr.enable = true;
  # programs.gnupg.agent = {
  #   enable = true;
  #   enableSSHSupport = true;
  # };

  qt = {
   enable = true;
   platformTheme = "kde";
   style = "breeze";
  };

  # List services that you want to enable:

  # Enable the OpenSSH daemon.
  # services.openssh.enable = true;

  # Open ports in the firewall.
  # networking.firewall.allowedTCPPorts = [ ... ];
  # networking.firewall.allowedUDPPorts = [ ... ];
  # Or disable the firewall altogether.
  # networking.firewall.enable = false;

  fileSystems."/home/royalc/Jeux" = {
    device = "/dev/disk/by-uuid/1088E3AA88E38D12";
    fsType = "ntfs-3g"; # ou ntfs3
    options = [ "rw" "uid=1000" "gid=100" "nofail" ];
  };

  # This value determines the NixOS release from which the default
  # settings for stateful data, like file locations and database versions
  # on your system were taken. It‘s perfectly fine and recommended to leave
  # this value at the release version of the first install of this system.
  # Before changing this value read the documentation for this option
  # (e.g. man configuration.nix or on https://nixos.org/nixos/options.html).
  system.stateVersion = "26.05"; # Did you read the comment?

  nix.settings.experimental-features = [ "nix-command" "flakes" ];
  zramSwap.enable = true;
}


