-- Input configuration
-- https://wiki.hypr.land/Configuring/Basics/Variables/

hl.config({
    input = {
        kb_layout = "us",
        numlock_by_default = true,
        repeat_delay = 250,
        repeat_rate = 35,
        accel_profile = "flat",
        special_fallthrough = true,
        follow_mouse = 1,
        touchpad = {
            natural_scroll = true,
            disable_while_typing = true,
            clickfinger_behavior = true,
            scroll_factor = 0.5,
        },
    },
})

-- Gestures
hl.gesture({ fingers = 3, direction = "horizontal", action = "workspace" })
-- Note: pinchin/pinchout gesture API not yet confirmed for Lua — left out until documented
-- hl.gesture({ fingers = 3, direction = "pinchin",  action = "float", target = "tile" })
-- hl.gesture({ fingers = 3, direction = "pinchout", action = "float" })
