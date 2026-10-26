{ pkgs, ... }:

{
  # システム側で flakes が無効なホストで、自分のユーザーだけ有効にする。
  nix.package = pkgs.nix;
  nix.settings.experimental-features = [
    "nix-command"
    "flakes"
  ];
}
