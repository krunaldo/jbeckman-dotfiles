--
-- Ion ionws module configuration file
--

-- Bindings for the tiled workspaces (ionws). These should work on any
-- object on the workspace.

defbindings("WTiling", {

    bdoc("Go to frame above/below/right/left of current frame."),
    kpress(META.."N", "ioncore.goto_next(_sub, 'up', {no_ascend=_})"),
    kpress(META.."T", "ioncore.goto_next(_sub, 'down', {no_ascend=_})"),
    kpress(META.."S", "ioncore.goto_next(_sub, 'right')"),
    kpress(META.."H", "ioncore.goto_next(_sub, 'left')"),
    kpress("Scroll_Lock", "ioncore.exec_on(_, 'xlock -mode blank')"),

    submap(SUBMAP, {
      bdoc("Split current frame vertically."),
      kpress("W", "WTiling.split_at(_, _sub, 'bottom', true)"),
        bdoc("Split current frame horizontally."),
        kpress("S", "WTiling.split_at(_, _sub, 'right', true)"),

        bdoc("Destroy current frame."),
        kpress("X", "WTiling.unsplit_at(_, _sub)"),
    }),
})


-- Frame bindings. These work in (Ion/tiled-style) frames. Some bindings
-- that are common to all frame types and multiplexes are defined in
-- ion-bindings.lua.

defbindings("WFrame.tiled", {
    submap(SUBMAP, {
        bdoc("Detach window from tiled frame"),
        kpress("D", "mod_tiling.detach(_sub)", "_sub:non-nil"),
    }),
})


defbindings("WFrame.floating", {
    submap(SUBMAP, {
        bdoc("Tile frame, if no tiling exists on the workspace"),
        kpress("B", "mod_tiling.mkbottom(_)"),
    }),
})



-- Frame bindings. These work in (Ion/tiled-style) frames. Some bindings
-- that are common to all frame types and multiplexes are defined in
-- ion-bindings.lua.

--defbindings("WFrame-on-WTiling", {
--})

-- Context menu for tiled workspaces.

defctxmenu("WTiling", "Workspace", {
    menuentry("Destroy frame",
              "WTiling.unsplit_at(_, _sub)"),

    menuentry("Split vertically",
              "WTiling.split_at(_, _sub, 'bottom', true)"),
    menuentry("Split horizontally",
              "WTiling.split_at(_, _sub, 'right', true)"),

    menuentry("Flip", "WTiling.flip_at(_, _sub)"),
    menuentry("Transpose", "WTiling.transpose_at(_, _sub)"),

    submenu("Float split", {
        menuentry("At left",
                  "WTiling.set_floating_at(_, _sub, 'toggle', 'left')"),
        menuentry("At right",
                  "WTiling.set_floating_at(_, _sub, 'toggle', 'right')"),
        menuentry("Above",
                  "WTiling.set_floating_at(_, _sub, 'toggle', 'up')"),
        menuentry("Below",
                  "WTiling.set_floating_at(_, _sub, 'toggle', 'down')"),
    }),

    submenu("At root", {
        menuentry("Split vertically",
                  "WTiling.split_top(_, 'bottom')"),
        menuentry("Split horizontally",
                  "WTiling.split_top(_, 'right')"),
        menuentry("Flip", "WTiling.flip_at(_)"),
        menuentry("Transpose", "WTiling.transpose_at(_)"),
    }),
})

-- Extra context menu extra entries for floatframes.

defctxmenu("WFrame.tiled", "Tiled frame", {
  menuentry("Detach", "mod_tiling.detach(_sub)", "_sub:non-nil"),
})

defctxmenu("WFrame.floating", "Floating frame", {
    append=true,
    menuentry("New tiling", "mod_tiling.mkbottom(_)"),
})



-- Adjust default workspace layout

local a_frame = {
    type="WSplitRegion",
    regparams = {
        type = "WFrame",
        frame_style = "frame-tiled"
    }
}

ioncore.set{
    default_ws_params = {
        -- Destroy workspace if the 'bottom' tiling is destroyed last
        bottom_last_close = true,
        -- Layout
        managed = {
            {
                type = "WTiling",
                bottom = true,
                -- The default is a single 1:1 horizontal split
                split_tree = {
                    type = "WSplitSplit",
                    dir = "horizontal",
                    tls = 1,
                    brs = 1,
                    tl = a_frame,
                    br = a_frame
                }
                -- For a single frame
                --split_tree = nil
            }
        }
    }
}

