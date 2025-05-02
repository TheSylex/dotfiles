{
  self,
  pkgs,
  inputs,
}:
# Append nixpkgs' lib and nix-std's lib to our own lib
pkgs.lib.recursiveUpdate (pkgs.lib.recursiveUpdate pkgs.lib inputs.nix-std.lib) {
  serde = {
    # Example usage: (updateTOML ./config.toml {param = "foo"})
    updateTOML = file: updates: let
      outName = builtins.baseNameOf file;
      content = pkgs.lib.importTOML file;
      merged = self.recursiveUpdate content updates;
      serialized = self.serde.toTOML merged;
    in
      pkgs.writeText outName serialized;
  };
  wrap = wrapper: ((inputs.wrapper-manager.lib.build {
      inherit pkgs;
      modules = [{wrappers.${wrapper.basePackage.name} = wrapper;}];
    })
    // {name = wrapper.basePackage.name;});
}
