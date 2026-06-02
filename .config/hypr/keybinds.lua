-- Keybindings
-- https://wiki.hypr.land/Configuring/Basics/Binds/

local mod  = "SUPER"
local scrPath = os.getenv("HOME") .. "/.config/hypr/Scripts"

-- Applications
local terminal = "ghostty"
local editor   = "code"
local explorer = "thunar"
local browser  = scrPath .. "/browser-launcher.sh"

hl.bind(mod .. " + Return", hl.dsp.exec_cmd(terminal))
hl.bind(mod .. " + E",      hl.dsp.exec_cmd(explorer))
hl.bind(mod .. " + C",      hl.dsp.exec_cmd(editor))
hl.bind(mod .. " + B",      hl.dsp.exec_cmd(browser))

-- Noctalia shell
hl.bind(mod .. " + D", hl.dsp.exec_cmd("qs -c noctalia-shell ipc call launcher toggle"))
hl.bind(mod .. " + L", hl.dsp.exec_cmd("qs -c noctalia-shell ipc call lockScreen lock"))
hl.bind(mod .. " + T", hl.dsp.exec_cmd("qs -c noctalia-shell ipc call settings toggle"))
hl.bind(mod .. " + O", hl.dsp.exec_cmd("qs -c noctalia-shell ipc call controlCenter toggle"))
hl.bind(mod .. " + H", hl.dsp.exec_cmd("qs -c noctalia-shell ipc call plugin:keybind-cheatsheet toggle"))
hl.bind(mod .. " + K", hl.dsp.exec_cmd("qs -c noctalia-shell ipc call plugin:hyprland-keybinds toggle"))

-- Window management
hl.bind(mod .. " + Q", hl.dsp.window.close())
hl.bind(mod .. " + W", hl.dsp.window.float({ action = "toggle" }))
hl.bind(mod .. " + F", hl.dsp.window.fullscreen({}))

-- Focus
hl.bind(mod .. " + Left",  hl.dsp.focus({ direction = "left" }))
hl.bind(mod .. " + Right", hl.dsp.focus({ direction = "right" }))
hl.bind(mod .. " + Up",    hl.dsp.focus({ direction = "up" }))
hl.bind(mod .. " + Down",  hl.dsp.focus({ direction = "down" }))
hl.bind("ALT + Tab",       hl.dsp.exec_cmd("hyprctl dispatch cyclenext"))

-- Workspace navigation
hl.bind(mod .. " + Tab",       hl.dsp.focus({ workspace = "m+1" }))
hl.bind(mod .. " + SHIFT + Tab", hl.dsp.focus({ workspace = "m-1" }))

-- Resize windows
hl.bind(mod .. " + SHIFT + Right", hl.dsp.window.resize({ x =  30, y =   0 }))
hl.bind(mod .. " + SHIFT + Left",  hl.dsp.window.resize({ x = -30, y =   0 }))
hl.bind(mod .. " + SHIFT + Up",    hl.dsp.window.resize({ x =   0, y = -30 }))
hl.bind(mod .. " + SHIFT + Down",  hl.dsp.window.resize({ x =   0, y =  30 }))

-- Move window (floating: move by delta; tiled: swap direction)
local function moveOrShift(dx, dy, dir)
    return hl.dsp.exec_cmd(string.format(
        "grep -q 'true' <<< $(hyprctl activewindow -j | jq -r .floating)" ..
        " && hyprctl dispatch moveactive %d %d" ..
        " || hyprctl dispatch movewindow %s",
        dx, dy, dir
    ))
end

hl.bind(mod .. " + SHIFT + CTRL + Left",  moveOrShift(-30,   0, "l"))
hl.bind(mod .. " + SHIFT + CTRL + Right", moveOrShift( 30,   0, "r"))
hl.bind(mod .. " + SHIFT + CTRL + Up",    moveOrShift(  0, -30, "u"))
hl.bind(mod .. " + SHIFT + CTRL + Down",  moveOrShift(  0,  30, "d"))

-- Mouse move / resize
hl.bind(mod .. " + mouse:272", hl.dsp.window.drag(),   { mouse = true })
hl.bind(mod .. " + mouse:273", hl.dsp.window.resize(), { mouse = true })

-- Interactive move / resize via keyboard
hl.bind(mod .. " + Z", hl.dsp.exec_cmd("hyprctl dispatch movewindow"))
hl.bind(mod .. " + X", hl.dsp.exec_cmd("hyprctl dispatch resizewindow"))

-- Screenshots
hl.bind(mod .. " + Print",       hl.dsp.exec_cmd("HYPRSHOT_DIR=~/Pictures/Screenshots hyprshot -m window"))
hl.bind("ALT + Print",           hl.dsp.exec_cmd("HYPRSHOT_DIR=~/Pictures/Screenshots hyprshot -m output"))
hl.bind(mod .. " + SHIFT + Print", hl.dsp.exec_cmd("HYPRSHOT_DIR=~/Pictures/Screenshots hyprshot -m region"))
hl.bind(mod .. " + A",           hl.dsp.exec_cmd([[grim -g "$(slurp)" - | satty --filename - --output-filename ~/Pictures/Screenshots/Screenshot-$(date '+%Y%m%d-%H:%M:%S').png]]))

-- Workspaces 1–10  (key 0 → workspace 10)
for i = 1, 10 do
    local key = i % 10
    hl.bind(mod .. " + " .. key,             hl.dsp.focus({ workspace = i }))
    hl.bind(mod .. " + SHIFT + " .. key,     hl.dsp.window.move({ workspace = i }))
end

hl.bind(mod .. " + CTRL + Right", hl.dsp.focus({ workspace = "r+1" }))
hl.bind(mod .. " + CTRL + Left",  hl.dsp.focus({ workspace = "r-1" }))
hl.bind(mod .. " + CTRL + Down",  hl.dsp.focus({ workspace = "empty" }))

hl.bind(mod .. " + mouse_down", hl.dsp.focus({ workspace = "e+1" }))
hl.bind(mod .. " + mouse_up",   hl.dsp.focus({ workspace = "e-1" }))

hl.bind(mod .. " + CTRL + ALT + Right", hl.dsp.window.move({ workspace = "r+1" }))
hl.bind(mod .. " + CTRL + ALT + Left",  hl.dsp.window.move({ workspace = "r-1" }))

-- Stream profile toggle
hl.bind(mod .. " + CTRL + S", hl.dsp.exec_cmd(scrPath .. "/stream-code-toggle.sh"))

-- Hardware controls
hl.bind("XF86AudioPlay",        hl.dsp.exec_cmd("playerctl play-pause"))
hl.bind("XF86AudioNext",        hl.dsp.exec_cmd("playerctl next"))
hl.bind("XF86AudioPrev",        hl.dsp.exec_cmd("playerctl previous"))
hl.bind("XF86AudioRaiseVolume", hl.dsp.exec_cmd("pamixer -i 5"))
hl.bind("XF86AudioLowerVolume", hl.dsp.exec_cmd("pamixer -d 5"))
