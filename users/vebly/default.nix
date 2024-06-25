{config, pkgs, pkgs-unstable, lib, fn, ... }:
let 
    imports = fn.imports[ 
        ../../modules/user/dev
        ../../modules/user/apps
        ../../modules/user/sh/zsh/zsh.nix
        ../../modules/user/wm/awesome.nix 
    ];
in 
{
    inherit imports;
    home.username = "vebly";
    home.homeDirectory = "/home/vebly";


    home.stateVersion = "24.05"; 

    home.packages = with pkgs; [
        discord
        arandr
        freetube
        obsidian
        dbeaver-bin
        octaveFull
        emacs
        emacs-all-the-icons-fonts
        emacsPackages.fontawesome
        emacsPackages.unicode-fonts
    ];

    programs.git = {
        enable = true;
        userName = "vebly";
        userEmail = "";
    };


    home.sessionVariables = {
        EDITOR = "nvim";
    };
# Let Home Manager install and manage itself.
    programs.home-manager.enable = true;
}