{
  self,
  pkgs,
  inputs,
}:
# Append nixpkgs' lib and nix-std's lib to our own lib
pkgs.lib
|> (pkgs.lib.recursiveUpdate inputs.nix-std.lib)
|> (pkgs.lib.recursiveUpdate {
  serde = {
    # Example usage: (updateTOML ./config.toml {param = "foo"})
    updateTOML = file: updates:
      pkgs.writeText
      (builtins.baseNameOf file)
      (file
        |> pkgs.lib.importTOML
        |> (self.recursiveUpdate updates)
        |> self.serde.toTOML);
  };
  wrap = wrapper: ((inputs.wrapper-manager.lib.build {
      inherit pkgs;
      modules = [{wrappers.${wrapper.basePackage.name} = wrapper;}];
    })
    // {name = wrapper.basePackage.name;});
})
