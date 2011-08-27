-- look_tiny.lua: an ion3 style for small screens...like mine :(
-- based on look_minimalist.lua

if not gr.select_engine("de") then return end

de.reset()

de.defstyle("*", {
    bar_inside_border = false,
    background_colour = "#000000",
    foreground_colour = "#ffffff",
    padding_colour = "#fefefe",
    padding_pixels = 0,
    highlight_pixels = 0,
    shadow_pixels = 0,
    border_style = "ridge",
    font = "-*-lucida-medium-r-normal-*-10-*-*-*-*-*-*-*",
    text_align = "left",
    transparent_background = true,
})

de.defstyle("moveres_display", {
	based_on = "*",
  padding_pixels = 1,
	padding_colour = "#fefefe",
})


de.defstyle("frame", {
    based_on = "*",
    padding_colour = "#000000",

    spacing = 0,
    padding_pixels = 0,
    padding_colour = "#fefefe",
    highlight_pixels = 0,
    shadow_pixels = 0,

})


de.defstyle("frame-floating", {
    based_on = "frame",
    padding_colour = "#dadada",
    highlight_colour = "#888888",
    shadow_colour = "#333333",
    highlight_pixels = 0,
    shadow_pixels = 0,

    de.substyle("active", {
			padding_colour = "#7788cc",
    }),

})

de.defstyle("frame-tiled", {
	based_on = "frame",

	de.substyle("active", {
		padding_colour    = "#c9c9e3",
		background_colour = "#c9c9e3",
  }),

  de.substyle("inactive", {
	  padding_colour    = "#fefefe",
    background_colour = "#fefefe",
  }),

})

de.defstyle("tabstyle", {
    based_on = "*",

    de.substyle("inactive-unselected", {
		padding_colour = "#fefefe",
 		background_colour = "#fefefe",
 		foreground_colour = "#111111"
    }),

    de.substyle("active-unselected", {
	    padding_colour    = "#fefefe",
        background_colour = "#fefefe",
		foreground_colour = "#111111"
    }),
    de.substyle("inactive-selected", {
	    padding_colour    = "#fefefe",
        background_colour = "#fefefe",
		foreground_colour = "#111111"
    }),
    de.substyle("active-selected", {
        padding_colour    = "#00ff00",
        background_colour = "#00ff00",
				foreground_colour = "#111111"
    }),
})

de.defstyle("tab", {
    based_on = "tabstyle",
    spacing = 0,
    padding_pixels = 1,
    text_align = "center",
})

de.defstyle("tab-menuentry", {
    spacing = 1,
    based_on = "tabstyle",
    font = "-*-lucida-medium-r-normal-*-10-*-*-*-*-*-*-*",
    text_align = "left",
})

de.defstyle("tab-menuentry-big", {
    spacing = 2,
    based_on = "tab-menuentry",
    font = "-*-lucida-medium-r-normal-*-18-*-*-*-*-*-*-*",
})

de.defstyle("input", {
    based_on = "*",
    padding_pixels = 1,
    font = "-*-lucida-medium-r-normal-*-14-*-*-*-*-*-*-*",
    de.substyle("*-cursor", {
        background_colour = "#00ff00",
        foreground_colour = "#000000",
    }),
    de.substyle("*-selection", {
        foreground_colour = "#5555cc",
    }),
})

de.defstyle("stdisp", {
    based_on = "tab",
    background_colour = "#000000",
    padding_colour = "#000000",
    de.substyle("important", { foreground_colour = "#ffff00", }),
    de.substyle("critical", { foreground_colour = "#ff0000", }),
    de.substyle("gray", { foreground_colour = "#505050", }),
    de.substyle("red", { foreground_colour = "#ff0000", }),
    de.substyle("green", { foreground_colour = "#00ff00", }),
    de.substyle("blue", { foreground_colour = "#0000ff", }),
    de.substyle("cyan", { foreground_colour = "#00ffff", }),
    de.substyle("magenta", { foreground_colour = "#ff00ff", }),
    de.substyle("yellow", { foreground_colour = "#ffff00", }),
})

gr.refresh()
