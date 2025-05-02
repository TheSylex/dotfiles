{
  root,
  pkgs,
}:
root.lib.wrap {
  basePackage = pkgs.zellij;
  env.ZELLIJ_CONFIG_FILE.value = ./config.kdl;
}
