
local mainMod = "SUPER"

-----------------------
---- Helper functions --
-----------------------

local function current_workspace()
    local special = hl.get_active_special_workspace()
    if special then
        return special
    end
    return hl.get_active_workspace()
end

local function set_layout(layout, workspace)
    workspace = workspace or current_workspace()
    if not workspace then
        return
    end

    if workspace.special then
        hl.workspace_rule({ workspace = tostring(workspace.name), layout = layout })
    else
        hl.workspace_rule({ workspace = "name:" .. tostring(workspace.name), layout = layout })
    end
end

local function switch_layout()
    local workspace = current_workspace()
    if not workspace then
        return
    end

    local next_layout = "master"
    if workspace.tiled_layout == "master" then
        next_layout = "scrolling"
    end

    set_layout(next_layout, workspace)
end

local function toggle_gaps()
    local gaps = hl.get_config("general.gaps_in")
    local current = 5

    if type(gaps) == "table" then
        current = gaps.top or 5
    elseif type(gaps) == "number" then
        current = gaps
    end

    local value = 0
    if current == 0 then
        value = 5
    end

    hl.config({
        general = {
            gaps_in  = value,
            gaps_out = value,
        },
    })
end

local function has_plugin(name)
    for _, plugin in ipairs(hl.get_loaded_plugins()) do
        if plugin.name and plugin.name:lower():find(name, 1, true) then
            return true
        end
    end
    return false
end

local function toggle_overview()
    if has_plugin("hyprexpo") then
        hl.exec_cmd("hyprctl dispatch hyprexpo:expo toggle")
    else
        hl.exec_cmd("noctalia msg panel-toggle launcher")
    end
end

local function toggle_btop()
    local windows = hl.get_windows({ class = "btop" })
    local special = hl.get_active_special_workspace()
    local special_visible = special
        and (special.name == "special:special" or special.name == "special")

    if #windows > 0 then
        hl.dispatch(hl.dsp.workspace.toggle_special("special"))
        return
    end

    hl.exec_cmd("footclient --app-id btop -e btop")

    -- If the overlay is already visible the window appears there directly.
    -- Otherwise reveal it once the window has had time to map.
    if not special_visible then
        hl.timer(function()
            hl.dispatch(hl.dsp.workspace.toggle_special("special"))
        end, { timeout = 350, type = "oneshot" })
    end
end

local function toggle_scratchpad()
    if #hl.get_windows({ workspace = "special:scratchpad" }) == 0 then
        hl.exec_cmd("footclient --app-id scratchpad")
    end

    hl.dispatch(hl.dsp.workspace.toggle_special("scratchpad"))
end

local function minimize()
    local window = hl.get_active_window()
    if not window then
        return
    end

    hl.dispatch(hl.dsp.window.tag({ tag = "+minimized", window = window }))
    hl.dispatch(hl.dsp.window.move({
        workspace = "special:minimized",
        window    = window,
        follow    = false,
    }))
end

local function restore_minimized()
    local workspace = hl.get_active_workspace()
    if workspace and workspace.special then
        workspace = hl.get_last_workspace()
    end
    if not workspace then
        return
    end

    for _, window in ipairs(hl.get_windows({ tag = "minimized" })) do
        hl.dispatch(hl.dsp.window.move({
            workspace = workspace,
            window    = window,
            follow    = false,
        }))
        hl.dispatch(hl.dsp.window.clear_tags({ window = window }))
    end
end

-----------------------
---- Terminal/launchers
-----------------------

hl.bind(mainMod .. " + Return", hl.dsp.exec_cmd("footclient"))
hl.bind(mainMod .. " + space",  hl.dsp.exec_cmd("noctalia msg panel-toggle launcher"))
hl.bind(mainMod .. " + s",      hl.dsp.exec_cmd("noctalia msg panel-toggle control-center"))
hl.bind(mainMod .. " + comma",  hl.dsp.exec_cmd("noctalia msg settings-toggle"))
hl.bind(mainMod .. " + d",      hl.dsp.exec_cmd("goofcord"))
hl.bind(mainMod .. " + b",      hl.dsp.exec_cmd("zen-beta"))
hl.bind(mainMod .. " + e",      hl.dsp.exec_cmd("nemo"))
hl.bind(mainMod .. " + slash",  hl.dsp.exec_cmd("skwd-wall-v2"))

-----------------------
---- Session/windows ----
-----------------------

hl.bind(mainMod .. " + r",              hl.dsp.exec_cmd("hyprctl reload"))
hl.bind(mainMod .. " + SHIFT + Escape", hl.dsp.exit())
hl.bind(mainMod .. " + q",              hl.dsp.window.close())
hl.bind(mainMod .. " + Delete",         hl.dsp.exec_cmd("noctalia msg panel-toggle session"))
hl.bind(mainMod .. " + ALT + l",        hl.dsp.exec_cmd("noctalia msg session lock"))
hl.bind(mainMod .. " + Escape",         toggle_btop)
hl.bind(mainMod .. " + SHIFT + e",      hl.dsp.exec_cmd("noctalia msg desktop-widgets-toggle-edit"))

-----------------------
---- Screenshots etc. ---
-----------------------

hl.bind("Print",         hl.dsp.exec_cmd("noctalia msg screenshot-region"))
hl.bind("SHIFT + Print", hl.dsp.exec_cmd("hyprshot -m region --clipboard-only"))
hl.bind(mainMod .. " + c", hl.dsp.exec_cmd("hyprpicker -a"))
hl.bind(mainMod .. " + v", hl.dsp.exec_cmd("noctalia msg panel-toggle clipboard"))

-----------------------
---- Tags/workspaces ----
-----------------------

for i = 1, 9 do
    hl.bind(mainMod .. " + " .. i, hl.dsp.focus({ workspace = i }))
end

for i = 1, 9 do
    hl.bind(mainMod .. " + ALT + " .. i, hl.dsp.window.move({ workspace = i, follow = false }))
end

hl.bind(mainMod .. " + 0",        toggle_overview)
hl.bind(mainMod .. " + SHIFT + s", hl.dsp.workspace.toggle_special("special"))

-----------------------
---- Layouts ------------
-----------------------

hl.bind(mainMod .. " + t", function()
    set_layout("master")
end)

hl.bind(mainMod .. " + x", function()
    set_layout("scrolling")
end)

hl.bind(mainMod .. " + a", switch_layout)

hl.bind(mainMod .. " + i", hl.dsp.layout("addmaster"))
hl.bind(mainMod .. " + p", hl.dsp.layout("removemaster"))
hl.bind(mainMod .. " + n", toggle_gaps)

-----------------------
---- Window state -------
-----------------------

hl.bind(mainMod .. " + f",         hl.dsp.window.fullscreen())
hl.bind(mainMod .. " + ALT + space", hl.dsp.window.float({ action = "toggle" }))
hl.bind(mainMod .. " + ALT + i",   minimize)
hl.bind(mainMod .. " + SHIFT + i", restore_minimized)
hl.bind("ALT + z",                 toggle_scratchpad)
hl.bind("Caps_Lock",               hl.dsp.exec_cmd("swayosd-client --caps-lock"), { locked = true })

-----------------------
---- Focus --------------
-----------------------

hl.bind(mainMod .. " + j", hl.dsp.window.cycle_next())
hl.bind(mainMod .. " + k", hl.dsp.window.cycle_next({ next = false }))
hl.bind(mainMod .. " + h", hl.dsp.focus({ direction = "left" }))
hl.bind(mainMod .. " + l", hl.dsp.focus({ direction = "right" }))
hl.bind("ALT + Tab",       toggle_overview)

-----------------------
---- Swap windows -------
-----------------------

hl.bind(mainMod .. " + SHIFT + k", hl.dsp.window.swap({ direction = "up" }))
hl.bind(mainMod .. " + SHIFT + j", hl.dsp.window.swap({ direction = "down" }))
hl.bind(mainMod .. " + SHIFT + h", hl.dsp.window.swap({ direction = "left" }))
hl.bind(mainMod .. " + SHIFT + l", hl.dsp.window.swap({ direction = "right" }))

-----------------------
---- Hardware keys ------
-----------------------

hl.bind("XF86MonBrightnessUp",   hl.dsp.exec_cmd("noctalia msg brightness-up"),   { locked = true })
hl.bind("XF86MonBrightnessDown", hl.dsp.exec_cmd("noctalia msg brightness-down"), { locked = true })
hl.bind("XF86AudioRaiseVolume",  hl.dsp.exec_cmd("pamixer -u && pamixer -i 5"),   { locked = true })
hl.bind("XF86AudioLowerVolume",  hl.dsp.exec_cmd("pamixer -u && pamixer -d 5"),   { locked = true })
hl.bind("XF86AudioMute",         hl.dsp.exec_cmd("noctalia msg volume-mute"),     { locked = true })

-----------------------
---- Mouse binds --------
-----------------------

hl.bind(mainMod .. " + mouse:272", hl.dsp.window.drag(),   { mouse = true })
hl.bind(mainMod .. " + mouse:273", hl.dsp.window.resize(), { mouse = true })

-----------------------
---- Gestures -----------
-----------------------

hl.gesture({
    fingers   = 3,
    direction = "left",
    action    = function()
        hl.dispatch(hl.dsp.focus({ direction = "left" }))
    end,
})

hl.gesture({
    fingers   = 3,
    direction = "right",
    action    = function()
        hl.dispatch(hl.dsp.focus({ direction = "right" }))
    end,
})

hl.gesture({
    fingers   = 3,
    direction = "up",
    action    = function()
        hl.dispatch(hl.dsp.focus({ direction = "up" }))
    end,
})

hl.gesture({
    fingers   = 3,
    direction = "down",
    action    = function()
        hl.dispatch(hl.dsp.focus({ direction = "down" }))
    end,
})

hl.gesture({
    fingers   = 4,
    direction = "left",
    action    = "workspace",
})

hl.gesture({
    fingers   = 4,
    direction = "right",
    action    = "workspace",
})

hl.gesture({
    fingers   = 4,
    direction = "up",
    action    = toggle_overview,
})

hl.gesture({
    fingers   = 4,
    direction = "down",
    action    = toggle_overview,
})
