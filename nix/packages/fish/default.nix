{
  root,
  pkgs,
}:
root.lib.wrap {
  basePackage = pkgs.fish;
  flags = ["-C" "source ${./config.fish}"];
  env.STARSHIP_CONFIG.value = "${./starship_config.toml}";
}
