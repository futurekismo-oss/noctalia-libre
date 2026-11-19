
hl.config({
    misc = {
        background_color = "rgba(141408FF)",

        disable_hyprland_logo    = true,
        disable_splash_rendering = true,
        force_default_wallpaper  = 0,

        disable_autoreload = false,

        enable_swallow = true,
        swallow_regex  = "^(foot|footclient|Alacritty|alacritty)$",
    },

    cursor = {
        inactive_timeout  = 60,
        hide_on_key_press = true,

        no_warps                 = false,
        warp_on_change_workspace = true,
        warp_on_toggle_special   = true,
    },
})
