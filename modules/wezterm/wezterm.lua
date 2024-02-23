local wezterm = require("wezterm")
local act = wezterm.action

local rose_pine = require("colors/rose-pine").colors()
local rose_pine_palette = require("colors/rose-pine").get_palette()
local update_status_bar = require("utils").update_status_bar
local toggle_padding = require("utils").toggle_padding

local keys = require("keybinds")
local launch_menu = {
  {
    args = { "top" },
  },
}

wezterm.on("update-status", update_status_bar)

wezterm.on("toggle-padding", toggle_padding)

wezterm.on("get-pane-id", function(window, pane)
  local pane_id = pane:pane_id()
  window:copy_to_clipboard(pane_id)
end)

wezterm.on(
  "format-tab-title",
  function(tab, tabs, panes, config, hover, max_width)
    local title

    if tab.tab_title and tab.tab_title ~= "" then
      title = tab.tab_title
    else
      title = tab.active_pane.title
    end

    title = wezterm.truncate_right(title, max_width - 2)

    local unseen_info = false

    for _, pane in ipairs(tab.panes) do
      if pane.has_unseen_output then
        unseen_info = true
        break
      end
    end

    local dot = wezterm.format({
      { Foreground = { Color = rose_pine_palette.love } },
      { Text = "·" },
    })

    local unseen = unseen_info and dot or " "

    return {
      {
        Text = " " .. tab.tab_index + 1 .. ": " .. title .. " " .. unseen,
      },
    }
  end
)
return {
  check_for_updates = false,
  allow_square_glyphs_to_overflow_width = "WhenFollowedBySpace",
  default_cursor_style = "BlinkingBlock",
  max_fps = 240,
  tab_max_width = 30,
  animation_fps = 1,
  freetype_load_flags = "NO_HINTING",
  launch_menu = launch_menu,
	enable_wayland = false,
  cursor_blink_ease_in = "Constant",
  cursor_blink_ease_out = "Constant",
  status_update_interval = 500,
  cursor_thickness = 3,
  default_cwd = "~/Code",
  exit_behavior = "Close",
  window_close_confirmation = "NeverPrompt",
  native_macos_fullscreen_mode = false,
  quick_select_patterns = {
    "[A-Za-z0-9-_]{22}",
  },
  window_padding = {
    left = 2,
    right = 0,
    top = 0,
    bottom = 0,
  },
  enable_scroll_bar = false,
  colors = rose_pine,
  front_end = "WebGpu",
  command_palette_fg_color = rose_pine.foreground,
  command_palette_bg_color = rose_pine.background,
  ui_key_cap_rendering = "AppleSymbols",
  command_palette_font_size = 16.0,
  use_fancy_tab_bar = false,
  tab_bar_at_bottom = true,
  hide_tab_bar_if_only_one_tab = true,
	hide_mouse_cursor_when_typing = false,
  xcursor_theme = "Adwaita",
  adjust_window_size_when_changing_font_size = false,
  font_size = 16.0,
  line_height = 1.2,
  font = wezterm.font("Berkeley Mono Variable"),
  harfbuzz_features = { "calt=0", "clig=0", "liga=0" },
  warn_about_missing_glyphs = false,
  mouse_bindings = {
    {
      event = { Up = { streak = 1, button = "Left" } },
      mods = "NONE",
      action = act.CompleteSelection("ClipboardAndPrimarySelection"),
    },
    {
      event = { Up = { streak = 1, button = "Left" } },
      mods = "SUPER",
      action = act.OpenLinkAtMouseCursor,
    },
    {
      event = { Down = { streak = 1, button = "Left" } },
      mods = "SUPER",
      action = act.Nop,
    },
    {
      event = { Down = { streak = 3, button = "Left" } },
      action = act.SelectTextAtMouseCursor("SemanticZone"),
      mods = "NONE",
    },
  },

  leader = { key = "x", mods = "CTRL", timeout_milliseconds = 1000 },
  keys = keys,
}
