{ config, pkgs,inputs, ... }:{
  imports =
    [
      ./hardware-configuration.nix
    ];

  # Bootloader.
  boot.loader = {
    systemd-boot = {
      enable = true;
      configurationLimit = 10; #开机启动的grub条数
    };
    efi.canTouchEfiVariables = true;
  };

  #启用自动清理
  nix.gc = {
    automatic = true;
    dates = "weekly";
    options = "--delete-older-than 1w";
  };
  nix.settings = {
    # 启用 Nix Flakes 功能，以及配套的新 nix-command 命令行工具;添加下面配置保存后需要运行 sudo nixos-rebuild switch
    experimental-features = [ "nix-command" "flakes" ];
    # 自动清理优化
    auto-optimise-store = true;
  };

  networking = {
    hostName = "nixos";
    networkmanager.enable = true;
  };
  # Enable automatic login for the user.
  services.displayManager.autoLogin.enable = true;
  services.displayManager.autoLogin.user = "caigx";
  services.displayManager.sddm.enable = true;
  services.displayManager.sddm.wayland.enable = true;
  #services.desktopManager.plasma6.enable = true;
  # 终端自动登陆
  #services.getty.autologinUser = "caigx";
  services.locate.enable = true;

  environment.sessionVariables.NIXOS_OZONE_WL = "1"; #for hyprland
  programs.hyprland = {
    enable = true;
    package = inputs.hyprland.packages.${pkgs.stdenv.hostPlatform.system}.hyprland;
    portalPackage = inputs.hyprland.packages.${pkgs.stdenv.hostPlatform.system}.xdg-desktop-portal-hyprland;
    xwayland.enable = true;
  };

  users.users.caigx = {
    isNormalUser = true;
    description = "caigx";
    extraGroups = [ "networkmanager" "wheel" "video" ];
  };
  programs.zsh.enable = true;
  users.defaultUserShell = pkgs.zsh;

  security.sudo.wheelNeedsPassword = false;
  nixpkgs.config.allowUnfree = true;

  environment.systemPackages = with pkgs; [
    vim-full
    #lyra-cursors
  ];

  fonts = {
    enableDefaultPackages = true;
    packages = with pkgs; [
      nerd-fonts.noto
      nerd-fonts.jetbrains-mono
      wqy_zenhei
    ];
    fontconfig.enable = true;
  };

  time.timeZone = "Asia/Shanghai";
  i18n.defaultLocale = "zh_CN.UTF-8";

  i18n.extraLocaleSettings = {
    LC_ADDRESS = "zh_CN.UTF-8";
    LC_IDENTIFICATION = "zh_CN.UTF-8";
    LC_MEASUREMENT = "zh_CN.UTF-8";
    LC_MONETARY = "zh_CN.UTF-8";
    LC_NAME = "zh_CN.UTF-8";
    LC_NUMERIC = "zh_CN.UTF-8";
    LC_PAPER = "zh_CN.UTF-8";
    LC_TELEPHONE = "zh_CN.UTF-8";
    LC_TIME = "zh_CN.UTF-8";
  };

  # Enable the X11 windowing system.
  # You can disable this if you're only using the Wayland session.
  #services.xserver.enable = true;

  # AMD开源驱动
  services.xserver.videoDrivers = [ "amdgpu" ];

  # Enable CUPS to print documents.
  services.printing.enable = true;

  # Enable sound with pipewire.
  hardware.pulseaudio.enable = false;
  security.rtkit.enable = true;
  security.polkit.enable = true; #for hyprland
  services.pipewire = {
    enable = true;
    alsa.enable = true;
    alsa.support32Bit = true;
    pulse.enable = true;
  };

  system.stateVersion = "24.11";

}
