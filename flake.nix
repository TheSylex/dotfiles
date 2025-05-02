{
  inputs = {
    nixpkgs.url = "github:NixOS/nixpkgs/nixpkgs-unstable";

    # For nix managing in MacOS
    nix-darwin.url = "github:nix-darwin/nix-darwin/master";
    nix-darwin.inputs.nixpkgs.follows = "nixpkgs";

    # Extra lib-like utilities
    flake-utils.url = "github:numtide/flake-utils/11707dc";
    nix-std.url = "github:chessai/nix-std?rev=31bbc925750cc9d8f828fe55cee1a2bd985e0c00";

    # File-system-based import statements
    haumea.url = "github:nix-community/haumea/v0.2.2";
    haumea.inputs.nixpkgs.follows = "nixpkgs";

    # Add configuration for packages
    wrapper-manager.url = "github:viperML/wrapper-manager";
    wrapper-manager.inputs.nixpkgs.follows = "nixpkgs";
  };

  outputs = {self, ...} @ inputs:
    inputs.flake-utils.lib.eachDefaultSystem (system: let
      pkgs = inputs.nixpkgs.legacyPackages.${system};
      nix = inputs.haumea.lib.load {
        src = ./nix;
        inputs = {inherit pkgs inputs;};
        transformer = inputs.haumea.lib.transformers.liftDefault;
      };
    in {
      packages = nix.packages;
      devShells = nix.shells;
      __configurations = nix.configurations;
    })
    // {
      darwinConfigurations.sylex-mba = self.outputs.__configurations.aarch64-darwin.darwin;
    };

  # Flake packages
  inputs = {
    rio-flake.url = "github:raphamorim/rio?rev=e8d992c8ae96da7eb238541e154639a9a9b46c30";
    rio-flake.inputs.nixpkgs.follows = "nixpkgs";

    helix-flake.url = "github:helix-editor/helix/25.01.1";
    helix-flake.inputs.nixpkgs.follows = "nixpkgs";

    asciinema-flake.url = "github:asciinema/asciinema?rev=14b374697144a68b0a6731250183ec004b2ce085";
    asciinema-flake.inputs.nixpkgs.follows = "nixpkgs";

    asciinema-gif-generator-flake.url = "github:asciinema/agg?rev=f043c1f54a31381b0ff3a5ca2545ec354de80909";
    asciinema-gif-generator-flake.inputs.nixpkgs.follows = "nixpkgs";

    nix-melt-flake.url = "github:nix-community/nix-melt";
    nix-melt-flake.inputs.nixpkgs.follows = "nixpkgs";
  };
}
