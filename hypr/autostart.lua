
hl.on("hyprland.start", function()
    hl.exec_cmd("hyprctl setcursor Bibata-Modern-Ice 24")

    hl.exec_cmd("wl-paste --type text --watch cliphist store")
    hl.exec_cmd("wl-paste --type image --watch cliphist store")

    hl.exec_cmd("foot --server")

    hl.exec_cmd("noctalia")
    hl.exec_cmd("gsr-ui launch-daemon")
end)
