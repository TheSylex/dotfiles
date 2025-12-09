{
  root,
  pkgs,
}: root.lib.wrap {
  basePackage = pkgs.glow;
  prependFlags = ["-s" ./theme.json];
}
