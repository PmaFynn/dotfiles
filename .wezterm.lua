local wezterm = require("wezterm")

return {
	-- Font
	font = wezterm.font_with_fallback({
		"JetBrains Mono",
		"FiraCode Nerd Font",
	}),
	font_size = 16,

	-- Appearance
	color_scheme = "Catppuccin Macchiato", -- or Macchiato, Frappe, Latte, Mocha
	window_decorations = "RESIZE", -- cleaner look, no full titlebar
	enable_tab_bar = true,
	hide_tab_bar_if_only_one_tab = true,

	-- Leader key (like tmux)
	leader = { key = "b", mods = "CTRL", timeout_milliseconds = 2000 },

	-- Keybindings for productivity
	keys = {
		-- split panes
		{ key = "d", mods = "LEADER", action = wezterm.action.SplitHorizontal({ domain = "CurrentPaneDomain" }) },
		{ key = "D", mods = "LEADER", action = wezterm.action.SplitVertical({ domain = "CurrentPaneDomain" }) },

		-- pane navigation
		{ key = "h", mods = "LEADER", action = wezterm.action.ActivatePaneDirection("Left") },
		{ key = "l", mods = "LEADER", action = wezterm.action.ActivatePaneDirection("Right") },
		{ key = "k", mods = "LEADER", action = wezterm.action.ActivatePaneDirection("Up") },
		{ key = "j", mods = "LEADER", action = wezterm.action.ActivatePaneDirection("Down") },

		-- resize panes
		{ key = "H", mods = "LEADER", action = wezterm.action.AdjustPaneSize({ "Left", 3 }) },
		{ key = "L", mods = "LEADER", action = wezterm.action.AdjustPaneSize({ "Right", 3 }) },
		{ key = "K", mods = "LEADER", action = wezterm.action.AdjustPaneSize({ "Up", 3 }) },
		{ key = "J", mods = "LEADER", action = wezterm.action.AdjustPaneSize({ "Down", 3 }) },

		-- new tab
		{ key = "t", mods = "LEADER", action = wezterm.action.SpawnTab("CurrentPaneDomain") },
		-- cycle tabs
		{ key = "n", mods = "LEADER", action = wezterm.action.ActivateTabRelative(1) },
		{ key = "p", mods = "LEADER", action = wezterm.action.ActivateTabRelative(-1) },
	},

	-- Quality of life
	scrollback_lines = 5000,
	enable_wayland = true,
}
