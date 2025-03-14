{ pkgs, ... }:{
  home.packages = with pkgs;[
    vscode
    gimp
    mpv
    wechat-uos
    v2raya
    obsidian
    wpsoffice-cn
  ];

  programs = {
    firefox.enable = true;
    chromium.enable = true;
  };

}
