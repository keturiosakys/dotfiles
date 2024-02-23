{ config, pkgs, lib, ... }:
let
  yaml = pkgs.formats.yaml { };
  macOsConfigPath = "Library/Application Support";
  configs = {
    default = {
      toggle_key = "RIGHT_ALT";
      search_shortcut = "off";
      show_icon = false;
    };
    obsidian = {
      filter_class = "obsidian";
      extra_includes = [ "../match/_obsidian.yml" ];
    };
  };
  matches = {
    base = { };
    dates = {
      matches = [
        {
          trigger = "ddate";
          replace = "{{date}}";
        }
        {
          trigger = "isodate";
          replace = "{{iso_date}}";
        }
        {
          trigger = "sqldate";
          replace = "{{sqldate}}";
        }
      ];
    };
    fiberplane = {
      matches = [
        {
          trigger = "em\\";
          replace = "laurynas@fiberplane.com";
        }
      ];
    };
    _obsidian = {
      matches = [ ];
    };
    global_vars = {
      global_vars = [
        {
          name = "date";
          type = "date";
          params = { format = "%e %b %Y"; };
        }
        {
          name = "iso_date";
          type = "date";
          params = { format = "%F"; };
        }
        {
          name = "sqldate";
          type = "date";
          params = { format = "+%Y%m%d%H%M"; };
        }
      ];
    };
  };
in
{

  services.espanso = {
    enable = !pkgs.stdenv.isDarwin;
    inherit configs;
    inherit matches;
  };


  # set the below one only in Darwin
  home.file =
    let
      configFiles = lib.mapAttrs'
        (name: value: {
          name = "${macOsConfigPath}/espanso/config/${name}.yml";
          value = { source = yaml.generate "${name}.yml" value; };
        })
        configs;

      matchFiles = lib.mapAttrs'
        (name: value: {
          name = "${macOsConfigPath}/espanso/match/${name}.yml";
          value = { source = yaml.generate "${name}.yml" value; };
        })
        matches;

      personalMatch =
        {
          "${macOsConfigPath}/espanso/match/personal.yml" = {
            source = config.lib.file.mkOutOfStoreSymlink ./personal.yml;
          };
        };
    in
    lib.optionalAttrs pkgs.stdenv.isDarwin (configFiles // matchFiles // personalMatch);



}
