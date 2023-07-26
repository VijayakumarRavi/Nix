
{ config, pkgs, ... }:

{
  # Enable networking
  networking.networkmanager.enable = true;
  # Enable Flakes and the new command-line tool  
  nix.settings.experimental-features = [ "nix-command" "flakes" ];

  # Set your time zone.
  time.timeZone = "Asia/Kolkata";

  # Select internationalisation properties.
  i18n.defaultLocale = "en_US.UTF-8";

  nixpkgs.config.permittedInsecurePackages = [
    "python-2.7.18.6"
  ];

  i18n.extraLocaleSettings = {
    LC_ADDRESS = "en_IN";
    LC_IDENTIFICATION = "en_IN";
    LC_MEASUREMENT = "en_IN";
    LC_MONETARY = "en_IN";
    LC_NAME = "en_IN";
    LC_NUMERIC = "en_IN";
    LC_PAPER = "en_IN";
    LC_TELEPHONE = "en_IN";
    LC_TIME = "en_IN";
  };

  # Configure keymap in X11
  services.xserver = {
    layout = "us";
    xkbVariant = "";
  };

  fonts = {
    fonts = with pkgs; [
      # icon fonts
      material-design-icons

      # normal fonts
      noto-fonts
      noto-fonts-cjk
      noto-fonts-emoji

      # nerdfonts
      (nerdfonts.override { fonts = [ "FiraCode" "JetBrainsMono" ]; })
    ];

    # use fonts specified by user rather than default ones
    enableDefaultFonts = false;

    # user defined fonts
    # the reason there's Noto Color Emoji everywhere is to override DejaVu's
    # B&W emojis that would sometimes show instead of some Color emojis
    fontconfig.defaultFonts = {
      serif = [ "Noto Serif" "Noto Color Emoji" ];
      sansSerif = [ "Noto Sans" "Noto Color Emoji" ];
      monospace = [ "JetBrainsMono Nerd Font" "Noto Color Emoji" ];
      emoji = [ "Noto Color Emoji" ];
    };
  };

  # Allow unfree packages
  nixpkgs.config.allowUnfree = true;

  # Some programs need SUID wrappers, can be configured further or are
  # started in user sessions.
  # programs.mtr.enable = true;
  programs.gnupg.agent = {
    enable = true;
    pinentryFlavor = "curses";
    enableSSHSupport = true;
  };

  programs.dconf.enable = true;

  # List services that you want to enable:
  # Enable the OpenSSH daemon.
  services.openssh = {
    enable = true;
    settings = {
      X11Forwarding = true;
      PermitRootLogin = "no";         # disable root login
      PasswordAuthentication = false; # disable password login
    };
    openFirewall = true;
  };

  # Perform garbage collection weekly to maintain low disk usage
  nix.gc = {
    automatic = true;
    dates = "weekly";
    options = "--delete-older-than 1w";
  };

  # Optimize storage
  # You can also manually optimize the store via:
  #    nix-store --optimise
  # Refer to the following link for more details:
  # https://nixos.org/manual/nix/stable/command-ref/conf-file.html#conf-auto-optimise-store
  nix.settings.auto-optimise-store = true;

  # Define a user account. Don't forget to set a password with ‘passwd’.
  users.users.vijay = {
    isNormalUser = true;
    description = "vijay";
    extraGroups = [ "networkmanager" "wheel" "docker"];
    openssh.authorizedKeys.keys = [ "ssh-ed25519 AAAAC3NzaC1lZDI1NTE5AAAAII8O84V4KrHZGAtdgY9vTYOGdH/BPcI846sM+MbCYuLX" ];
    packages = with pkgs; [];
  };
  # Disable sudo password promt for wheel users
  security.sudo.wheelNeedsPassword = false;

  # List packages installed in system profile. To search, run:
  # $ nix search wget
  environment.systemPackages = with pkgs; [
    vim # Do not forget to add an editor to edit configuration.nix! The Nano editor is also installed by default.
    wget
    curl
    git
    htop
    tmux
    sysstat
    pinentry
    pinentry-curses
    python2
    gnupg
    lm_sensors  # for `sensors` command
    neofetch
    lf          # terminal file manager
  ];
}
