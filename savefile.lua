savefile = {}
function savefile.read()
    player = {}
    if love.filesystem.getInfo("SAVEFILE.sav") then
        file = love.filesystem.read("SAVEFILE.sav")
        data = lume.deserialize(file)

        player.krono = data.krono
        player.rank = data.rank
        player.modifierSlots = data.modifierSlots
        player.modifier = {}
        player.modifier.assemblyCooldown = data.modifier.assemblyCooldown
        player.modifier.openOnNextClick = data.modifier.openOnNextClick
        player.menu = {
            modifierDrawn = false
        }
    else
        player.krono = 0
        player.rank = 0
        player.modifierSlots = {
            {}, {}, {}
        }
        player.modifier = {}
        player.modifier.assemblyCooldown = 0
        player.modifier.openOnNextClick = false
        player.menu = {
            modifierDrawn = false
        }
    end
end

function savefile.write()
    data = {}
    data.krono = player.krono
    data.rank = player.rank
    data.modifierSlots = player.modifierSlots
    data.modifier = {}
    data.modifier.assemblyCooldown = player.modifier.assemblyCooldown
    data.modifier.openOnNextClick = player.modifier.openOnNextClick
    serialized = lume.serialize(data)
    love.filesystem.write("SAVEFILE.sav", serialized)
end