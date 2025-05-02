{
  root,
  inputs,
}:
inputs.nix-darwin.lib.darwinSystem {
  modules = [
    ({pkgs, ...}: {
      nixpkgs.hostPlatform = "aarch64-darwin";
      nix.settings.experimental-features = "nix-command flakes";

      programs.fish.enable = true;
      programs.fish.package = root.packages.fish;
      users.users.aitor.shell = root.packages.fish;

      environment = {
        variables = {
          # Remove every executable outside of nix from the global environment
          PATH = "$HOME/.nix-profile/bin:/run/current-system/sw/bin:/nix/var/nix/profiles/default/bin";
          TERM = "xterm-256color";
          COLORTERM = "truecolor";
          EDITOR = "${root.packages.helix}/bin/hx";
        };
      };

      environment.systemPackages = pkgs.lib.attrValues root.packages;

      # Used for backwards compatibility, please read the changelog before changing.
      # $ darwin-rebuild changelog
      system.stateVersion = 6;
    })
  ];
}
