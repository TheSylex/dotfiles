{
  root,
  pkgs,
  inputs,
}:
root.lib.wrap rec {
  basePackage = inputs.helix-flake.packages."${pkgs.system}".default;
  pathAdd = with pkgs; [
    fish-lsp
    nixd
    alejandra
  ];
  env.XDG_CONFIG_HOME.value = "${placeholder "out"}/share/.config";
  postBuild = ''
    install -Dm644 ${./config.toml} ${env.XDG_CONFIG_HOME.value}/helix/config.toml
    install -Dm644 ${./languages.toml} ${env.XDG_CONFIG_HOME.value}/helix/languages.toml
  '';
}
