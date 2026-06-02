-- Hyprland Lua configuration (v0.55+)
-- https://wiki.hypr.land/Configuring/Start/

require("monitors")
require("startup")
require("inputs")
require("keybinds")
require("windowrules")
require("animations")
require("themes.theme")

-- Workspace → monitor pinning
-- DP-2 (LG 34"): workspaces 1–3   HDMI-A-1 (Dell 27"): workspaces 4–6
for i = 1, 3 do hl.workspace_rule({ workspace = tostring(i), monitor = "DP-2",     default = (i == 1) }) end
for i = 4, 6 do hl.workspace_rule({ workspace = tostring(i), monitor = "HDMI-A-1", default = (i == 4) }) end

-- Layouts
hl.config({
    dwindle = {
        preserve_split = true,
    },
    master = {
        new_status = "master",
    },
})

-- Misc
hl.config({
    misc = {
        vrr = 0,
        disable_hyprland_logo = true,
        disable_splash_rendering = true,
        force_default_wallpaper = 0,
        anr_missed_pings = 5,
        allow_session_lock_restore = true,
    },
    xwayland = {
        force_zero_scaling = true,
    },
})
