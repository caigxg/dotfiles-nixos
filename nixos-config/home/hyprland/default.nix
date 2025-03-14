{ config, pkgs, ...}: let 
  hyprPath = "${config.home.homeDirectory}/nixos-config/home/hyprland/hypr";
  waybarPath = "${config.home.homeDirectory}/nixos-config/home/waybar";
in {

  home.packages = with pkgs;[
    hyprpaper
    hyprlock
    hypridle
    waybar
    dunst
    wl-clipboard
    cliphist
    udiskie
    wlogout
    rofi
    nautilus
    grim
    wf-recorder
    slurp
    nwg-look
    wev #key board:get key's value
    nautilus-open-any-terminal
  ];

  home.file.".config/hypr".source = config.lib.file.mkOutOfStoreSymlink hyprPath;
  home.file.".config/waybar".source = config.lib.file.mkOutOfStoreSymlink waybarPath;
  home.file.".config/rofi".source = ../rofi;
  home.file.".config/dunst".source = ../dunst;
  home.file.".config/wlogout".source = ../wlogout;
}
