{ pkgs, ... }:{
  home.packages = with pkgs;[
    vscode
    gimp
    mpv
    wechat-uos
    v2raya
    obsidian
    wpsoffice-cn
    clash-verge-rev
  ];

  programs = {
    firefox.enable = true;
    chromium.enable = true;
  };

}
