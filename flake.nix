{
  description = "Atrium: a polished, mouse-first KDE Plasma flavor for FyxOS";

  inputs = {
    nixpkgs.url = "github:NixOS/nixpkgs/nixos-unstable";
    fyxos = {
      url = "github:FyxOS/FyxOS";
      inputs.nixpkgs.follows = "nixpkgs";
    };
  };

  outputs = { self, nixpkgs, fyxos }:
    let
      system = "x86_64-linux";
    in
    {
      nixosModules.default = ./modules/atrium.nix;

      checks.${system}.desktop = import ./tests/desktop.nix {
        pkgs = nixpkgs.legacyPackages.${system};
        modules = [ fyxos.nixosModules.default self.nixosModules.default ];
      };
    };
}
