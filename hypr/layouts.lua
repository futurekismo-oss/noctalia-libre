hl.config({
    master = {
        new_status     = "slave",
        orientation    = "left",
        smart_resizing = true,
        drop_at_cursor = true,
    },

    scrolling = {
        -- scroller_default_proportion_single = 1.0
        fullscreen_on_one_column = true,

        -- scroller_default_proportion = 0.8
        column_width = 0.8,

        -- scroller_focus_center = 0 / scroller_prefer_center = 1
        focus_fit_method = 1,

        -- edge_scroller_pointer_focus = 1
        follow_focus       = true,
        follow_min_visible = 0.4,

        -- scroller_proportion_preset = [0.5, 0.8, 1.0]
        explicit_column_widths = "0.5, 0.8, 1.0",

        direction    = "right",
        wrap_focus   = true,
        wrap_swapcol = true,
    },
})
