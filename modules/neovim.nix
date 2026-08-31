{ ... }:

{
  programs.neovim = {
    enable = true;
    withNodeJs = true;
  };

  xdg.configFile."nvim" = {
    source = ../config/nvim;
    recursive = true;
  };
}
