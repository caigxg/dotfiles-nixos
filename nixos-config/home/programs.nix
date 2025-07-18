{ pkgs, ... }:{
  home.packages = with pkgs;[
    vscode
    gimp3
    mpv
    wechat-uos
    obsidian
    wpsoffice-cn
    clash-verge-rev
  ];

  programs = {
    firefox.enable = true;
    chromium.enable = true;
  };

}
