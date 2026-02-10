{
  description = "A collection of nix packages";

  inputs = {
    nixpkgs.url = "github:NixOS/nixpkgs/nixos-unstable";
  };

  outputs = { self, nixpkgs }:
    let
      systems = [ "x86_64-linux" "aarch64-linux" "x86_64-darwin" "aarch64-darwin" ];
      forAllSystems = nixpkgs.lib.genAttrs systems;
    in
    {
      packages = forAllSystems (system:
        let
          pkgs = nixpkgs.legacyPackages.${system};
        in
        {
          code-cursor = pkgs.callPackage ./pkgs/code-cursor/package.nix { };
          default = self.packages.${system}.code-cursor;
        }
      );

      overlays.default = final: prev: {
        code-cursor = final.callPackage ./pkgs/code-cursor/package.nix { };
      };
    };
}

