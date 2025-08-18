themes = {}
function themes.load()
    themeColors = {}
    themeColors.sunset = {
        background = love.graphics.newImage("images/background.png"),
        kronoButtonFill = "ff007a",
        kronoButtonOutline = "40001e",
        bottomStatusBar = "ff6a80",
        kronoProgressBar = "b9e145",
        rankProgressBar = "2ab2d3",
        modifierFrame = modifier_frame,
        assemblyButton = "ff7100",
        assemblyButtonText = "000000",
        discardButton = "ff007a"
    }
    themeColors.neon = {
        background = love.graphics.newImage("images/background_neon.png"),
        kronoButtonFill = "000000",
        kronoButtonOutline = "8000ff",
        bottomStatusBar = "000000",
        kronoProgressBar = "ff0062",
        rankProgressBar = "bb00ff",
        modifierFrame = modifier_frame_neon,
        assemblyButton = "000000",
        assemblyButtonText = "ffb496",
        discardButton = "9500ff"
    }
    themeColors.basalt = {
        background = love.graphics.newImage("images/background_basalt.png"),
        kronoButtonFill = "302c42",
        kronoButtonOutline = "7d72ad",
        bottomStatusBar = "000000",
        kronoProgressBar = "bdbdbd",
        rankProgressBar = "a1a1a1",
        modifierFrame = modifier_frame_basalt,
        assemblyButton = "705741",
        assemblyButtonText = "d1d1d1",
        discardButton = "666666"
    }
end

function themes.set(theme)
    player.theme = theme
end

themes.load()