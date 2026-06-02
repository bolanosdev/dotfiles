-- Window Rules
-- https://wiki.hypr.land/Configuring/Basics/Window-Rules/

---------------------------------------------------------------------------
-- Floating
---------------------------------------------------------------------------

hl.window_rule({ match = { class = "^org\\.pulseaudio\\.pavucontrol$" },             float = true })
hl.window_rule({ match = { class = "^de\\.haeckerfelix\\.Shortwave$" },              float = true })
hl.window_rule({ match = { class = "^com\\.github\\.iwalton3\\.jellyfin-media-player$" }, float = true })

---------------------------------------------------------------------------
-- Idle inhibit
---------------------------------------------------------------------------

hl.window_rule({ match = { class = "^(.*celluloid.*|.*mpv.*|.*vlc.*)$" },
    idle_inhibit = "fullscreen" })
hl.window_rule({ match = { class = "^.*[Ss]potify.*$" },
    idle_inhibit = "fullscreen" })
hl.window_rule({ match = { class = "^(.*LibreWolf.*|.*floorp.*|.*brave-browser.*|.*firefox.*|.*chromium.*|.*zen.*|.*vivaldi.*)$" },
    idle_inhibit = "fullscreen" })

---------------------------------------------------------------------------
-- Picture-in-Picture
---------------------------------------------------------------------------

hl.window_rule({
    name  = "picture-in-picture",
    match = { title = "^([Pp]icture[-\\s]?[Ii]n[-\\s]?[Pp]icture).*$" },
    tag   = "picture-in-picture",
    float = true,
    keep_aspect_ratio = true,
    pin   = true,
    move  = "73% 72%",
    size  = "25% 25%",
})

---------------------------------------------------------------------------
-- Opacity overrides (all set to fully opaque)
---------------------------------------------------------------------------

-- Browsers
hl.window_rule({ match = { class = "^firefox$" },              opacity = "1.0 1.0" })
hl.window_rule({ match = { class = "^brave-browser$" },        opacity = "1.0 1.0" })

-- Editors / IDEs
hl.window_rule({ match = { class = "^code-oss$" },                      opacity = "1.0 1.0" })
hl.window_rule({ match = { class = "^[Cc]ode$" },                       opacity = "1.0 1.0" })
hl.window_rule({ match = { class = "^code-url-handler$" },              opacity = "1.0 1.0" })
hl.window_rule({ match = { class = "^code-insiders-url-handler$" },     opacity = "1.0 1.0" })

-- Terminals
hl.window_rule({ match = { class = "^com\\.mitchellh\\.ghostty$" },     opacity = "1.0 1.0" })
hl.window_rule({ match = { class = "^foot$" },                          opacity = "1.0 1.0" })

-- File managers / KDE apps
hl.window_rule({ match = { class = "^org\\.kde\\.dolphin$" },           opacity = "1.0 1.0" })
hl.window_rule({ match = { class = "^org\\.kde\\.ark$" },               opacity = "1.0 1.0" })

-- System / theme tools
hl.window_rule({ match = { class = "^nwg-look$" },                      opacity = "1.0 1.0" })
hl.window_rule({ match = { class = "^qt5ct$" },                         opacity = "1.0 1.0" })
hl.window_rule({ match = { class = "^qt6ct$" },                         opacity = "1.0 1.0" })
hl.window_rule({ match = { class = "^extsource$" },                     opacity = "1.0 1.0" })
hl.window_rule({ match = { class = "^kvantummanager$" },                opacity = "1.0 1.0" })

-- Audio / network / bluetooth
hl.window_rule({ match = { class = "^org\\.pulseaudio\\.pavucontrol$" }, opacity = "1.0 1.0" })
hl.window_rule({ match = { class = "^blueman-manager$" },               opacity = "1.0 1.0" })
hl.window_rule({ match = { class = "^nm-applet$" },                     opacity = "1.0 1.0" })
hl.window_rule({ match = { class = "^nm-connection-editor$" },          opacity = "1.0 1.0" })

-- Polkit agents
hl.window_rule({ match = { class = "^org\\.kde\\.polkit-kde-authentication-agent-1$" }, opacity = "1.0 1.0" })
hl.window_rule({ match = { class = "^polkit-gnome-authentication-agent-1$" },           opacity = "1.0 1.0" })

-- Portals
hl.window_rule({ match = { class = "^org\\.freedesktop\\.impl\\.portal\\.desktop\\.gtk$" },      opacity = "1.0 1.0" })
hl.window_rule({ match = { class = "^org\\.freedesktop\\.impl\\.portal\\.desktop\\.hyprland$" }, opacity = "1.0 1.0" })

-- Steam / gaming
hl.window_rule({ match = { class = "^[Ss]team$" },                      opacity = "1.0 1.0" })
hl.window_rule({ match = { class = "^steamwebhelper$" },                opacity = "1.0 1.0" })

-- Spotify
hl.window_rule({ match = { class = "^[Ss]potify$" },                    opacity = "1.0 1.0" })
hl.window_rule({ match = { initial_title = "^Spotify Free$" },          opacity = "1.0 1.0" })
hl.window_rule({ match = { initial_title = "^Spotify Premium$" },       opacity = "1.0 1.0" })

-- Media / utilities
hl.window_rule({ match = { class = "^com\\.github\\.rafostar\\.Clapper$" },     opacity = "1.0 1.0" })
hl.window_rule({ match = { class = "^com\\.github\\.tchx84\\.Flatseal$" },      opacity = "1.0 1.0" })
hl.window_rule({ match = { class = "^hu\\.kramo\\.Cartridges$" },               opacity = "1.0 1.0" })
hl.window_rule({ match = { class = "^com\\.obsproject\\.Studio$" },             opacity = "1.0 1.0" })
hl.window_rule({ match = { class = "^gnome-boxes$" },                           opacity = "1.0 1.0" })
hl.window_rule({ match = { class = "^vesktop$" },                               opacity = "1.0 1.0" })
hl.window_rule({ match = { class = "^discord$" },                               opacity = "1.0 1.0" })
hl.window_rule({ match = { class = "^WebCord$" },                               opacity = "1.0 1.0" })
hl.window_rule({ match = { class = "^ArmCord$" },                               opacity = "1.0 1.0" })
hl.window_rule({ match = { class = "^app\\.drey\\.Warp$" },                     opacity = "1.0 1.0" })
hl.window_rule({ match = { class = "^net\\.davidotek\\.pupgui2$" },             opacity = "1.0 1.0" })
hl.window_rule({ match = { class = "^yad$" },                                   opacity = "1.0 1.0" })
hl.window_rule({ match = { class = "^Signal$" },                                opacity = "1.0 1.0" })
hl.window_rule({ match = { class = "^io\\.github\\.alainm23\\.planify$" },      opacity = "1.0 1.0" })
hl.window_rule({ match = { class = "^io\\.gitlab\\.theevilskeleton\\.Upscaler$" }, opacity = "1.0 1.0" })
hl.window_rule({ match = { class = "^com\\.github\\.unrud\\.VideoDownloader$" },   opacity = "1.0 1.0" })
hl.window_rule({ match = { class = "^io\\.gitlab\\.adhami3310\\.Impression$" },    opacity = "1.0 1.0" })
hl.window_rule({ match = { class = "^io\\.missioncenter\\.MissionCenter$" },       opacity = "1.0 1.0" })
hl.window_rule({ match = { class = "^io\\.github\\.flattool\\.Warehouse$" },       opacity = "1.0 1.0" })

---------------------------------------------------------------------------
-- Floating utilities
---------------------------------------------------------------------------

hl.window_rule({ match = { class = "^Signal$" },                                float = true })
hl.window_rule({ match = { class = "^com\\.github\\.rafostar\\.Clapper$" },     float = true })
hl.window_rule({ match = { class = "^app\\.drey\\.Warp$" },                     float = true })
hl.window_rule({ match = { class = "^net\\.davidotek\\.pupgui2$" },             float = true })
hl.window_rule({ match = { class = "^yad$" },                                   float = true })
hl.window_rule({ match = { class = "^eog$" },                                   float = true })
hl.window_rule({ match = { class = "^io\\.github\\.alainm23\\.planify$" },      float = true })
hl.window_rule({ match = { class = "^io\\.gitlab\\.theevilskeleton\\.Upscaler$" }, float = true })
hl.window_rule({ match = { class = "^com\\.github\\.unrud\\.VideoDownloader$" },   float = true })
hl.window_rule({ match = { class = "^io\\.gitlab\\.adhami3310\\.Impression$" },    float = true })
hl.window_rule({ match = { class = "^io\\.missioncenter\\.MissionCenter$" },       float = true })

---------------------------------------------------------------------------
-- JetBrains popup fix
---------------------------------------------------------------------------

hl.window_rule({
    name  = "jetbrains-popup-fix",
    match = { class = "^.*jetbrains.*$", title = "^win[0-9]+$" },
    no_initial_focus = true,
})

---------------------------------------------------------------------------
-- YAD cheat sheet
---------------------------------------------------------------------------

hl.window_rule({
    name   = "yad-cheat-sheet",
    match  = { class = "^yad$" },
    center = true,
    size   = "1200 900",
})

---------------------------------------------------------------------------
-- Gamescope
---------------------------------------------------------------------------

hl.window_rule({
    name       = "gamescope",
    match      = { class = "^gamescope$" },
    opacity    = "1.0 1.0",
    rounding   = 0,
    no_anim    = true,
    no_shadow  = true,
    no_blur    = true,
    fullscreen = true,
})
