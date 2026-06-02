-- Stream coding profile: 1920x1080 content area on workspace 1
-- Monitor switched to 2560x1440 for streaming
hl.monitor({ output = "DP-2", mode = "2560x1440", position = "0x0", scale = 1 })

-- Content area: 1920x1240 on 2560x1440 (1394px usable after 46px bar)
--   left   = 256, right = 384 (15% right margin)
--   top    = (1394 - 1240) / 2 = 77
--   bottom = (1394 - 1240) / 2 = 77
for i = 1, 3 do
    hl.workspace_rule({ workspace = tostring(i), gaps_out = { top = 77, right = 384, bottom = 77, left = 256 } })
end
