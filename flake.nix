{
  description = "My Nixpkgs - a custom collection of Nix packages";

  inputs = {
    flake-parts.url = "github:hercules-ci/flake-parts";
    nixpkgs.url = "github:NixOS/nixpkgs/nixos-unstable";
    systems.url = "github:nix-systems/default";
    scikit-learn-1-2.url = "github:NixOS/nixpkgs/e08e100b0c6a6651c3235d1520c53280142d9d5f";
  };

  outputs =
    inputs@{ flake-parts, systems, ... }:
    flake-parts.lib.mkFlake { inherit inputs; } {
      systems = import systems;

      imports = [
        inputs.flake-parts.flakeModules.easyOverlay
        ./imports/overlay.nix
        ./imports/formatter.nix
        ./imports/pkgs-by-name.nix
        ./imports/pkgs-all.nix
      ];
    };
}
