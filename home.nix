{ pkgs, lib, ... }:

{
  imports = [
    ./modules/zsh.nix
    ./modules/neovim.nix
    ./modules/ghostty.nix
    ./modules/starship.nix
    ./modules/git.nix
  ];

  home.username = "kshiva";
  home.homeDirectory = if pkgs.stdenv.isDarwin then "/Users/kshiva" else "/home/kshiva";
  home.stateVersion = "26.05";

  home.sessionVariables = {
    LANG = "ja_JP.UTF-8";
    EDITOR = "nvim";
  };

  home.sessionPath = [
    "$HOME/bin"
    "$HOME/go/bin"
    "$HOME/.cargo/bin"
    "$HOME/.local/share/pnpm"
  ];

  home.packages = with pkgs; [
    bat
    fd
    fzf
    ghq
    ripgrep
  ];

  programs.home-manager.enable = true;
}
