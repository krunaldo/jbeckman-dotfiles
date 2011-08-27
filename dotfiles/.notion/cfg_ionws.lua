--
-- Ion ionws module configuration file
--

-- Bindings for the tiled workspaces (ionws). These should work on any 
-- object on the workspace.

defbindings("WIonWS", {
    
    bdoc("Go to frame above/below/right/left of current frame."),
    kpress(ALTMETA.."S", "WIonWS.goto_dir(_, 'left')"),
    kpress(ALTMETA.."T", "WIonWS.goto_dir(_, 'below')"),
    kpress(ALTMETA.."N", "WIonWS.goto_dir(_, 'above')"),
    kpress(ALTMETA.."H", "WIonWS.goto_dir(_, 'right')"),

    submap(SUBMAP, {
    	bdoc("Split current frame vertically."),
    	kpress("S", "WIonWS.split_at(_, _sub, 'bottom', true)"),

      bdoc("Split current frame horizontally."),
			kpress("W", "WIonWS.split_at(_, _sub, 'right', true)"),

			--      kpress("W",  "WIonWS.split_top(_, 'right')"),

			kpress("Z", "WTiling.spli(_, _sub, 'right', true)"),
        
        bdoc("Destroy current frame."),
        kpress("X", "WIonWS.unsplit_at(_, _sub)"),
    }),
})


-- Frame bindings. These work in (Ion/tiled-style) frames. Some bindings
-- that are common to all frame types and multiplexes are defined in
-- ion-bindings.lua.

--defbindings("WFrame-on-WIonWS", {
--})

-- Context menu for tiled workspaces.

defctxmenu("WIonWS", "Workspace", {
    menuentry("Destroy frame", 
              "WIonWS.unsplit_at(_, _sub)"),

    menuentry("Split vertically", 
              "WIonWS.split_at(_, _sub, 'bottom', true)"),
    menuentry("Split horizontally", 
              "WIonWS.split_at(_, _sub, 'right', true)"),
    
    menuentry("Flip", "WIonWS.flip_at(_, _sub)"),
    menuentry("Transpose", "WIonWS.transpose_at(_, _sub)"),
    
    submenu("Float split", {
        menuentry("At left", 
                  "WIonWS.set_floating_at(_, _sub, 'toggle', 'left')"),
        menuentry("At right", 
                  "WIonWS.set_floating_at(_, _sub, 'toggle', 'right')"),
        menuentry("Above",
                  "WIonWS.set_floating_at(_, _sub, 'toggle', 'up')"),
        menuentry("Below",
                  "WIonWS.set_floating_at(_, _sub, 'toggle', 'down')"),
    }),

    submenu("At root", {
        menuentry("Split vertically", 
                  "WIonWS.split_top(_, 'bottom')"),
        menuentry("Split horizontally", 
                  "WIonWS.split_top(_, 'right')"),
        menuentry("Flip", "WIonWS.flip_at(_)"),
        menuentry("Transpose", "WIonWS.transpose_at(_)"),
    }),
})
