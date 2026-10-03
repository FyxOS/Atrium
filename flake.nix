{
  description = "Atrium: a polished, mouse-first KDE Plasma flavor for Omnix";

  inputs = {
    nixpkgs.url = "github:NixOS/nixpkgs/nixos-unstable";
    omnix = {
      url = "github:Omnix-Linux/Omnix";
      inputs.nixpkgs.follows = "nixpkgs";
    };
  };

  outputs = { self, nixpkgs, omnix }:
    let
      system = "x86_64-linux";
    in
    {
      nixosModules.default = ./modules/atrium.nix;

      checks.${system}.desktop = import ./tests/desktop.nix {
        pkgs = nixpkgs.legacyPackages.${system};
        modules = [ omnix.nixosModules.default self.nixosModules.default ];
      };
    };
}
