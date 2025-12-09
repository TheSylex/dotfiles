{
  root,
  inputs,
}:
inputs.nix-darwin.lib.darwinSystem {
  modules = [
    ({pkgs, ...}: {
      nixpkgs.hostPlatform = "aarch64-darwin";
      nix.settings.experimental-features = "nix-command flakes pipe-operators";
      nix.optimise.automatic = true;

      programs.fish.enable = true;
      programs.fish.package = root.packages.fish;

      system.primaryUser = "aitor";
      nix.settings.trusted-users = [ "aitor" ];
      users.users.aitor.shell = root.packages.fish;

      services.openssh.enable = true;

      nix.linux-builder.enable = true;

      environment = {
        variables = {
          # Remove every executable outside of nix from the global environment
          PATH = "$HOME/.nix-profile/bin:/run/current-system/sw/bin:/nix/var/nix/profiles/default/bin";
          TERM = "xterm-256color";
          COLORTERM = "truecolor";
          EDITOR = "hx";
        };
      };

      environment.systemPackages = root.packages
      |> pkgs.lib.filterAttrs (n: _: n != "rio" ) # FIXME: Why the fuck doesn't rio work
      |> pkgs.lib.attrValues
      |> pkgs.lib.filter (pkg: pkg |> pkgs.lib.meta.availableOn pkgs.stdenv.hostPlatform);

      system.defaults.NSGlobalDomain.KeyRepeat = 1;
      system.defaults.NSGlobalDomain.InitialKeyRepeat = 10;

      # Used for backwards compatibility, please read the changelog before changing.
      # $ darwin-rebuild changelog
      system.stateVersion = 6;
    })
  ];
}
