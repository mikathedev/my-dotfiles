-- Variables
local terminal = "ghostty"
local fileManager = "nautilus"
local menu = "rofi -show drun"
local rofifile = "pgrep rofi && pkill rofi || rofi -show filebrowser"
local mainMod = "SUPER"

-- Monitors
hl.monitor({ output = "", mode = "preferred", position = "auto", scale = "1" })


hl.on("hyprland.start", function()
    
hl.exec_cmd("waybar & hyprpaper")
hl.exec_cmd("/home/mika/Clipy-the-dipy/ClipboardWriter")
hl.exec_cmd("ghostty -e paru -Syyu")
hl.exec_cmd("MPD_HOST=/home/mika/.config/mpd/socket mpd-mpris")
hl.exec_cmd("gnome-keyring-daemon --start --components=secrets")
hl.exec_cmd("/home/mika/pause.sh")
hl.exec_cmd("numlockx on")
end)

-- Environment Variables
hl.env("HYPRCURSOR_SIZE", "24")
hl.env("HYPRCURSOR_THEME", "Remus-White")

-- Core Configuration
hl.config({
    general = {
        gaps_in = 10,
        gaps_out = 10,
        border_size = 0,
        resize_on_border = false,
        allow_tearing = false,
        layout = "dwindle",
    },
    decoration = {
        rounding = 15,
        rounding_power = 2,
        active_opacity = 0.97,
        inactive_opacity = 0.87,
        shadow = { enabled = false },
        blur = {
            enabled = true,
            size = 3,
            passes = 2,
            vibrancy = 0.1696,
        },
    },
    animations = {
        enabled = true,
        beziers = {
            { "easeOutQuint", 0.23, 1, 0.32, 1 },
            { "easeInOutCubic", 0.65, 0.05, 0.36, 1 },
            { "linear", 0, 0, 1, 1 },
            { "almostLinear", 0.5, 0.5, 0.75, 1 },
            { "quick", 0.15, 0, 0.1, 1 },
        },
        animation = {
            { "global", 1, 10, "default" },
            { "border", 1, 5.39, "easeOutQuint" },
            { "windows", 1, 4.79, "easeOutQuint" },
            { "windowsIn", 1, 4.1, "easeOutQuint", "popin 87%" },
            { "windowsOut", 1, 1.49, "linear", "popin 87%" },
            { "workspaces", 1, 1.94, "almostLinear", "fade" },
        },
    },
    input = {
        kb_layout = "us",
        kb_options = "numlock_by_default=true,caps:none,numpad:mac",
        follow_mouse = 1,
        sensitivity = 0,
        touchpad = {
            disable_while_typing = false,
            natural_scroll = false,
        },
    },
    dwindle = {
        preserve_split = true,
    },
    misc = {
        force_default_wallpaper = 0,
        disable_hyprland_logo = true,
        layers_hog_keyboard_focus = true,
    },
    xwayland = {
        force_zero_scaling = true,
    }
})

hl.window_rule({
    name  = "float-rmpc",
    match = { class = "kitty", title = "rmpc" },
    float = true,
})

hl.window_rule({
    name  = "float-overskride",
    match = { class = "io.github.kaii_lb.Overskride" },

    float = true,
})

hl.window_rule({
    name  = "float-PiP",
    match = { title = "Picture-in-Picture" },

    float = true,
})

-- Keybindings
hl.bind(mainMod .. " + Tab", hl.dsp.exec_cmd(rofifile))
hl.bind("code:66", hl.dsp.layout("togglesplit"))
hl.bind("SHIFT + Print", hl.dsp.exec_cmd("grimblast copy && hyprctl notify 1 2500 'rgb(88c0d0)' 'Copied screenshot to clipboard'"))
hl.bind(mainMod .. " + V", hl.dsp.exec_cmd("/home/mika/Clipy-the-dipy/Clipboard-Manager"))

for i = 1, 9 do
  local ws = tostring(i)
  
  -- Switch to workspace
  hl.bind("SUPER + " .. ws, function()
    -- CRITICAL: hl.dispatch() is required to execute the action
    hl.dispatch(hl.dsp.focus({ workspace = ws })) 
  end)

  -- Move active window to workspace
  hl.bind("SUPER + SHIFT + " .. ws, function()
    hl.dispatch(hl.dsp.window.move({ workspace = ws, follow = true }))
  end)
end


-- Gestures (New Dispatcher Format)
hl.gesture({
    fingers = 3,
    direction = "horizontal",
    action = "workspace"
})

hl.gesture({
    fingers = 4,
    direction = "horizontal",
    action = "resize"
})

hl.gesture({
    fingers = 3,
    direction = "vertical",
    action = "move"
})