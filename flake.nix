{
  description = "Home Manager configuration of kshiva";

  inputs = {
    # Specify the source of Home Manager and Nixpkgs.
    nixpkgs.url = "github:nixos/nixpkgs/nixpkgs-unstable";
    home-manager = {
      url = "github:nix-community/home-manager";
      inputs.nixpkgs.follows = "nixpkgs";
    };
  };

  outputs =
    { nixpkgs, home-manager, ... }:
    let
      mkHome =
        system: username: extraModules:
        home-manager.lib.homeManagerConfiguration {
          pkgs = nixpkgs.legacyPackages.${system};
          modules = [ ./home.nix ] ++ extraModules;
          extraSpecialArgs = { inherit username; };
        };
    in
    {
      homeConfigurations = {
        "kshiva@mac" = mkHome "aarch64-darwin" "kshiva" [ ];
        "kshiva@linux" = mkHome "x86_64-linux" "kshiva" [ ];
        # 共有の NixOS サーバー integritis-dev。ログインシェルを変えられないので bash から zsh に切り替える
        "kshiva1126@linux" = mkHome "x86_64-linux" "kshiva1126" [ ./modules/bash-exec-zsh.nix ];
      };
    };
}
