{
  programs.zsh = {
    enable = true;
    enableCompletion = true;
    autosuggestion.enable = true;
    syntaxHighlighting.enable = true;
    history.save = 200;
    initContent = ''

    '';
    shellAliases = {};
    oh-my-zsh = {
      enable = true;
      #plugins = [ "git" "zsh-autosuggestions" ];
      theme = "ys";
    };
  };
}
