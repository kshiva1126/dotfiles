{ ... }:

{
  programs.starship = {
    enable = true;
    enableZshIntegration = true;
  };

  xdg.configFile."starship.toml".source = ../config/starship.toml;
}
