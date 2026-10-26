{ config, ... }:

{
  # ログインシェルが bash のホストで、対話シェルを zsh に切り替える。
  programs.bash = {
    enable = true;
    initExtra = ''
      if [[ -z "''${ZSH_VERSION-}" ]]; then
        exec ${config.programs.zsh.package}/bin/zsh -l
      fi
    '';
  };
}
