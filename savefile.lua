savefile = {}
function savefile.read()
    player = {}
    if love.filesystem.getInfo("SAVEFILE.sav") then
        file = love.filesystem.read("SAVEFILE.sav")
        data = lume.deserialize(file)

        player.krono = data.krono or 0
        player.kronoButtonsCooldowns = data.kronoButtonsCooldowns or {0, 0, 0, 0, 0}
        player.rank = data.rank or 0
        player.modifierSlots = data.modifierSlots or {{}, {}, {}}
        player.modifier = {}
        player.modifier.assemblyCooldown = data.modifier.assemblyCooldown or 0
        player.modifier.openOnNextClick = data.modifier.openOnNextClick or false
        player.menu = {
            modifierDrawn = false
        }
        player.theme = data.theme or "sunset"
    else
        player.krono = 0
        player.kronoButtonsCooldowns = {0, 0, 0, 0, 0}
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
        player.theme = "sunset"
    end
end

function savefile.write()
    data = {}
    data.krono = player.krono
    data.kronoButtonsCooldowns = {}
    for i,v in ipairs(kronoButtons) do
        table.insert(data.kronoButtonsCooldowns, v.cooldownTimer)
    end
    data.rank = player.rank
    data.modifierSlots = player.modifierSlots
    data.modifier = {}
    data.modifier.assemblyCooldown = player.modifier.assemblyCooldown
    data.modifier.openOnNextClick = player.modifier.openOnNextClick
    data.theme = player.theme
    serialized = lume.serialize(data)
    love.filesystem.write("SAVEFILE.sav", serialized)
end