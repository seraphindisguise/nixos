{ pkgs, inputs, ... }:

{
  imports = 
    [
      ../../modules/nixos/steam.nix
    ];

  # Boot
  boot.loader.systemd-boot.enable = true;
  boot.loader.efi.canTouchEfiVariables = true;
  boot.kernelPackages = pkgs.linuxPackages;

  # Hardware Options
  hardware.bluetooth.enable = true;
  hardware.bluetooth.powerOnBoot = true;
  hardware.graphics = {
    enable = true;
    enable32Bit = true;
  };

  # Services
  virtualisation.docker.enable = true;
  services.xserver.xkb = {
    layout = "us";
    variant = "";
  };

  # Locale Settings
  time.timeZone = "America/Chicago";
  i18n.defaultLocale = "en_US.UTF-8";
  i18n.extraLocaleSettings = {
    LC_ADDRESS = "en_US.UTF-8";
    LC_IDENTIFICATION = "en_US.UTF-8";
    LC_MEASUREMENT = "en_US.UTF-8";
    LC_MONETARY = "en_US.UTF-8";
    LC_NAME = "en_US.UTF-8";
    LC_NUMERIC = "en_US.UTF-8";
    LC_PAPER = "en_US.UTF-8";
    LC_TELEPHONE = "en_US.UTF-8";
    LC_TIME = "en_US.UTF-8";
  };

  # Nix
  nix.settings.experimental-features = [ "nix-command" "flakes" ];
  nixpjgs.config.allowUnfree = true;

  # Networking 
  networking.nameservers = [ "1.1.1.1" "8.8.8.8" ];
  netowrking.hostName = "Heaven";

  # Audio
  services.pulseaudio.enable = false;
  security.rtkit.enable = true;
  services.pipewire = {
    enable = true;
    alsa.enable = true;
    alsa.support32Bit = true;
    pulse.enable = true;
    jack.enable = true;
  };

  # User
  users.users."seraphindisguise" = {
    isNormalUser = true;
    description = "Teratoma";
    extraGroups = [ "networkmanager" "wheel" "dialout" "docker" ];
  };
  nix.settings.trusted-users = [ "root" "seraphindisguise" ];

  # Home Manager
  home-manager = {
    backupFileExtension = "backup";
    extraSpecialArgs = { inherit inputs; };
    users = {
      "seraphindisguise" = import ./home.nix;
    };
  };

  # Desktop 
  services.xserver.enable = true;
  services.xserver.desktopManager.cinnamon.enable = true;
  services.displayManager.lightdm.enable = true;
  
  # Environment 
  environment.systemPackages = with pkgs; [
    zip
    unzip
    wget
    git
    curl 
    fastfetch
    silver-searcher
    lsof
    file
    tree
  ];

  system.stateVersion = "26.05"; # Did you read the comment?
}
