{
  root,
  pkgs,
  inputs,
}: let
  temporal_pug_highlighting = pkgs.writeText "injections.scm" ''
    (directive_attribute
      (directive_name) @keyword
      (quoted_attribute_value
        (attribute_value) @injection.content)
     (#set! injection.language "javascript"))

    ((interpolation
      (raw_text) @injection.content)
     (#set! injection.language "javascript"))

    ; <script>
    ((script_element
        (start_tag) @_no_lang
        (raw_text) @injection.content)
      (#not-match? @_no_lang "lang=")
      (#set! injection.language "javascript"))

    ; <script lang="...">
    ((script_element
      (start_tag
        (attribute
        (attribute_name) @_attr_name
        (quoted_attribute_value (attribute_value) @injection.language)))
      (raw_text) @injection.content)
      (#eq? @_attr_name "lang"))

    ; <style>
    ((style_element
        (start_tag) @_no_lang
        (raw_text) @injection.content)
      (#not-match? @_no_lang "lang=")
      (#set! injection.language "css"))

    ; <style lang="...">
    ((style_element
      (start_tag
        (attribute
          (attribute_name) @_attr_name
          (quoted_attribute_value (attribute_value) @injection.language)))
       (raw_text) @injection.content)
     (#eq? @_attr_name "lang"))

    ; <template>
    ((template_element
        (start_tag) @_no_lang
        (text) @injection.content)
      (#not-match? @_no_lang "lang=")
      (#set! injection.language "html"))

    ; <template lang="...">
    ((template_element
      (start_tag
        (attribute
          (attribute_name) @_attr_name
          (quoted_attribute_value (attribute_value) @injection.language)))
      (text) @injection.content)
    (#eq? @_attr_name "lang"))

    ((comment) @injection.content
     (#set! injection.language "comment"))
  '';
in
  root.lib.wrap rec {
    basePackage = pkgs.helix;
    pathAdd = with pkgs; [
      fish-lsp
      nixd
      alejandra
      markdown-oxide
    ];
    env.XDG_CONFIG_HOME.value = "${placeholder "out"}/share/.config";
    postBuild = ''
      install -Dm644 ${./config.toml} ${env.XDG_CONFIG_HOME.value}/helix/config.toml
      install -Dm644 ${./languages.toml} ${env.XDG_CONFIG_HOME.value}/helix/languages.toml
      install -Dm644 ${temporal_pug_highlighting} ${env.XDG_CONFIG_HOME.value}/helix/runtime/queries/vue/injections.scm
    '';
  }
