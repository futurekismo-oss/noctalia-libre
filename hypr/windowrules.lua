hl.window_rule({
    name  = "btop-special-overlay",
    match = { class = "btop" },

    workspace = "special:special",
})

hl.window_rule({
    name  = "scratchpad-terminal",
    match = { class = "scratchpad" },

    workspace = "special:scratchpad",
    float     = true,
    size      = { "monitor_w * 0.6", "monitor_h * 0.6" },
    center    = true,
})
