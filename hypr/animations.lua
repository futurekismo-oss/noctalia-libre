
hl.config({
    animations = {
        enabled = true,
    },
})

hl.curve("mangoOpen",    { type = "bezier", points = { { 0.46, 1.0 }, { 0.29, 1.0 } } })
hl.curve("mangoMove",    { type = "bezier", points = { { 0.46, 1.0 }, { 0.29, 1.0 } } })
hl.curve("mangoTag",     { type = "bezier", points = { { 0.46, 1.0 }, { 0.29, 1.0 } } })
hl.curve("mangoClose",   { type = "bezier", points = { { 0.08, 0.92 }, { 0.0, 1.0 } } })
hl.curve("mangoFocus",   { type = "bezier", points = { { 0.46, 1.0 }, { 0.29, 1.0 } } })
hl.curve("mangoFadeIn",  { type = "bezier", points = { { 0.46, 1.0 }, { 0.29, 0.5 } } })
hl.curve("mangoFadeOut", { type = "bezier", points = { { 0.5, 0.5 }, { 0.5, 0.5 } } })

hl.animation({ leaf = "global", enabled = true, speed = 10, bezier = "default" })

hl.animation({ leaf = "border", enabled = true, speed = 0.1, bezier = "mangoFocus" })

hl.animation({ leaf = "windows",    enabled = true, speed = 5.0, bezier = "mangoMove" })
hl.animation({ leaf = "windowsIn",  enabled = true, speed = 3.0, bezier = "mangoOpen",  style = "slide" })
hl.animation({ leaf = "windowsOut", enabled = true, speed = 2.5, bezier = "mangoClose", style = "popin 100%" })

-- Opacity fades.
hl.animation({ leaf = "fadeIn",  enabled = true, speed = 3.0, bezier = "mangoFadeIn" })
hl.animation({ leaf = "fadeOut", enabled = true, speed = 2.5, bezier = "mangoFadeOut" })
hl.animation({ leaf = "fade",    enabled = true, speed = 3.0, bezier = "mangoOpen" })

hl.animation({ leaf = "layers",        enabled = false, speed = 1, bezier = "default" })
hl.animation({ leaf = "layersIn",      enabled = false, speed = 1, bezier = "default" })
hl.animation({ leaf = "layersOut",     enabled = false, speed = 1, bezier = "default" })
hl.animation({ leaf = "fadeLayersIn",  enabled = false, speed = 1, bezier = "default" })
hl.animation({ leaf = "fadeLayersOut", enabled = false, speed = 1, bezier = "default" })

-- Tag (workspace) switching.
hl.animation({ leaf = "workspaces",    enabled = true, speed = 3.5, bezier = "mangoTag", style = "slide" })
hl.animation({ leaf = "workspacesIn",  enabled = true, speed = 3.5, bezier = "mangoTag", style = "slide" })
hl.animation({ leaf = "workspacesOut", enabled = true, speed = 3.5, bezier = "mangoTag", style = "slide" })

hl.animation({ leaf = "zoomFactor", enabled = true, speed = 3.0, bezier = "mangoOpen" })
