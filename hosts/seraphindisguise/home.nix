{ inputs, pkgs, lib, ... }:

{
  imports = [

  ];
  home.username = "seraphindisguise";
  home.homeDirectory = "/home/seraphindisguise";

  home.stateVersion = "26.05"; # Please read the comment before changing
  home.packages = with pkgs; [
    lazygit
    firefox
    brave
    vlc
    libreoffice
    texliveFull 
    discord
    spotify
    vscode
    emacs
    netbeans
    xterm
    vim
  ];

  home.file = {
    bashrc = {
      target = "/home/seraphindisguise/.bashrc";
      text = ''
        echo "Hi"
      '';
    };
  };
  home.sessionVariables = {
    EDITOR = "nano";
  };

  programs.home-manager.enable = true;
}
