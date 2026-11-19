hl.config({
    decoration = {
        rounding = 5,

        shadow = {
            enabled = false,
        },

    },
})

hl.layer_rule({
    name  = "no-layer-blur",
    match = { namespace = ".*" },
    blur  = false,
})

hl.layer_rule({
    name  = "caelestia-no-blur",
    match = { namespace = "caelestia" },
    blur  = false,
})
