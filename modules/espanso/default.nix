{ config, pkgs, lib, ... }:
let
  yaml = pkgs.formats.yaml { };
  configPath = "Library/Application Support";
  configs = {
    default = {
      toggle_key = "RIGHT_ALT";
      search_shortcut = "off";
      show_icon = false;
    };
  };
  matches = {
    base = { matches = [ ]; };
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
          trigger = "fdate";
          replace = "{{full_date}}";
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
          name = "full_date";
          type = "date";
          params = { format = "%b %e, %Y"; };
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
    enable = false;
    inherit configs;
    inherit matches;
  };

  home.file =
    let
      configFiles = lib.mapAttrs'
        (name: value: {
          name = "${configPath}/espanso/config/${name}.yml";
          value = { source = yaml.generate "${name}.yml" value; };
        })
        configs;

      matchFiles = lib.mapAttrs'
        (name: value: {
          name = "${configPath}/espanso/match/${name}.yml";
          value = { source = yaml.generate "${name}.yml" value; };
        })
        matches;

      personalMatch =
        {
          "${configPath}/espanso/match/personal.yml" = {
            source = config.lib.file.mkOutOfStoreSymlink ./personal.yml;
          };
        };
    in
    configFiles // matchFiles // personalMatch;



}
