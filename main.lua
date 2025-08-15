function love.load()
    lume = require "lume"
    require "savefile"
    require "modifiers"
    background = love.graphics.newImage("background.png")
    modifier_frame = love.graphics.newImage("modifier_frame.png")
    modifier_A = love.graphics.newImage("modifier_A.png")
    modifier_B = love.graphics.newImage("modifier_B.png")
    modifier_C = love.graphics.newImage("modifier_C.png")
    modifier_D = love.graphics.newImage("modifier_D.png")
    kronoButtons = {}
    createKronoButton({520, 10}, 1, 15, 0, 0) -- 0.0(6) Krono/s
    createKronoButton({520, 50}, 6, 45, 0, 2) -- 0.1(3) Krono/s
    createKronoButton({520, 90}, 30, 100, 0, 5) -- 0.3 Krono/s
    createKronoButton({520, 130}, 264, 480, 0, 12) -- 0.55 Krono/s
    createKronoButton({520, 170}, 1168, 1320, 0, 20) -- 0.8(84) Krono/s
    Exo2_12R = love.graphics.newFont("Exo2-Regular.ttf", 12)
    Exo2_12M = love.graphics.newFont("Exo2-Medium.ttf", 12)
    Exo2_14R = love.graphics.newFont("Exo2-Regular.ttf", 14)
    Exo2_16R = love.graphics.newFont("Exo2-Regular.ttf", 16)
    Exo2_16M = love.graphics.newFont("Exo2-Medium.ttf", 16)
    Exo2_16S = love.graphics.newFont("Exo2-SemiBold.ttf", 16)
    Exo2_18R = love.graphics.newFont("Exo2-Regular.ttf", 18)
    Exo2_24M = love.graphics.newFont("Exo2-Medium.ttf", 24)
    Exo2_32M = love.graphics.newFont("Exo2-Medium.ttf", 32)
    FiraMono_12M = love.graphics.newFont("FiraMono-Medium.ttf", 12)
    FiraMono_14M = love.graphics.newFont("FiraMono-Medium.ttf", 14)
    FiraMono_32M = love.graphics.newFont("FiraMono-Medium.ttf", 32)
    rankRequirements = {}
    for i=1,30,1 do
        table.insert(rankRequirements, 2+2*i*(i-1))
    end
    table.insert(rankRequirements, math.huge)
    savefile.read()
    updateModifierBoosts()
end

function updateModifierBoosts()
    player.modifier.boosts = {}
    local kronoGainMultiplier = 1
    local kronoCooldownMultiplier = 1
    local assemblyCostMultiplier = 1
    local assemblyCooldownMultiplier = 1
    for i,v in ipairs(player.modifierSlots) do
        if v.boosts then
            for key,value in pairs(v.boosts) do
                if key == "kronoGainBoost" then
                    kronoGainMultiplier = kronoGainMultiplier + (value - 1)
                elseif key == "kronoCooldownReduction" then
                    kronoCooldownMultiplier = kronoCooldownMultiplier * (1 - value)
                elseif key == "assemblyCostReduction" then
                    assemblyCostMultiplier = assemblyCostMultiplier * (1 - value)
                elseif key == "assemblyCooldownReduction" then
                    assemblyCooldownMultiplier = assemblyCooldownMultiplier * (1 - value)
                end
            end
        end
    end
    player.modifier.boosts.kronoGain = kronoGainMultiplier
    player.modifier.boosts.kronoCooldown = kronoCooldownMultiplier
    player.modifier.boosts.assemblyCost = assemblyCostMultiplier
    player.modifier.boosts.assemblyCooldown = assemblyCooldownMultiplier
end

function math.pfloor(n, precision)
    local rounded = math.floor(n * 10^precision) / 10^precision
    local integerPart, decimalPart = tostring(rounded):match("^(%d+)%.?(%d*)$")
    local currentPrecision = #decimalPart
    for _=1,precision-currentPrecision do
        decimalPart = decimalPart .. "0"
    end
    if precision == 0 then
        return integerPart
    else
        return integerPart .. "." .. decimalPart
    end
    return tostring(rounded)
end

function createKronoButton(position, kronoGain, cooldown, cooldownTimer, unlockRank)
    local _ = {}
    _.position = position
    _.kronoGain = kronoGain
    _.cooldown = cooldown
    _.cooldownTimer = cooldownTimer
    _.unlockRank = unlockRank
    table.insert(kronoButtons, _)
end

function love.graphics.setHexColor(hex)
	local str = hex:gsub('0[xX]','') -- get rid of hex prefix if it exists
	local val = tonumber(str, 16) -- base 16 number conversion
	-- from here, same as above
	local bit = require('bit')
	local r = bit.rshift(bit.band(val, 0xff0000), 16) / 255
	local g = bit.rshift(bit.band(val, 0xff00), 8) / 255
	local b = bit.band(val, 0xff) / 255
	return love.graphics.setColor(r, g, b)
end

function love.draw()
    love.graphics.draw(background)
    for _,v in pairs(kronoButtons) do
        if player.rank >= v.unlockRank then
            love.graphics.setLineStyle("smooth")
            love.graphics.setLineWidth(2)
            love.graphics.setFont(FiraMono_14M)
            love.graphics.setHexColor("ff007a")
            love.graphics.rectangle("fill", v.position[1], v.position[2], 240, 28, 3, 3)
            love.graphics.setHexColor("40001e")
            love.graphics.rectangle("line", v.position[1], v.position[2], 240, 28, 3, 3)
            love.graphics.setHexColor("ffffff")
            local textY = math.floor((v.position[2] + 14) - (Exo2_16M:getHeight("Collect " .. v.kronoGain .. " Krono") / 2))
            if v.cooldownTimer <= 0 then
                love.graphics.printf("Collect " .. v.kronoGain * player.modifier.boosts.kronoGain .. ((v.kronoGain > 1) and " Kronoe" or " Krono"), v.position[1], textY, 240, "center")
            else
                love.graphics.printf("Check back in " .. math.pfloor(v.cooldownTimer, 1) .. " seconds", v.position[1], textY, 240, "center")
            end
        else
            love.graphics.setHexColor("ffffff")
            love.graphics.printf("Next button unlocks at Rank" .. v.unlockRank, 520, v.position[2], 240, "center")
        end
    end
    love.graphics.setFont(Exo2_16R)
    love.graphics.setHexColor("ff6a80")
    love.graphics.rectangle("fill", 440, 640, 400, 85, 4, 4)
    love.graphics.setHexColor("ffffff")
    love.graphics.rectangle("line", 440, 640, 400, 85, 4, 4)
    love.graphics.setColor(185/255, 225/255, 69/255, 128/255)
    love.graphics.rectangle("fill", 445, 649, 390, 20, 2, 2)
    love.graphics.setHexColor("b9e145")
    local progressRounding = (math.floor(390 * (player.krono / rankRequirements[player.rank + 1])) > 6) and 3 or 0
    love.graphics.rectangle("fill", 445, 649, math.floor(390 * (player.krono / rankRequirements[player.rank + 1])), 20, progressRounding, progressRounding)
    love.graphics.setHexColor("ffffff")
    love.graphics.setLineStyle("rough")
    love.graphics.line(445, 645, 445, 673)
    love.graphics.line(835, 645, 835, 673)
    love.graphics.setHexColor("000000")
    love.graphics.printf("Krono: " .. string.format("%d", player.krono) .. "/" .. string.format("%d", rankRequirements[player.rank + 1]), 445, 648, 390, "center")
    love.graphics.setHexColor("2ab2d3")
    love.graphics.rectangle("fill", 445, 692, 390, 20, 2, 2)
    love.graphics.setHexColor("ffba5e")
    love.graphics.setLineWidth(3)
    love.graphics.line(450, 680, 830, 680)
    love.graphics.setHexColor("ffffff")
    love.graphics.setLineWidth(2)
    love.graphics.line(445, 688, 445, 716)
    love.graphics.line(835, 688, 835, 716)
    love.graphics.setHexColor("000000")
    love.graphics.setFont(Exo2_16M)
    love.graphics.printf("Rank " .. player.rank, 445, 691, 390, "center")
    love.graphics.setHexColor("ffffff")

    local nonEmptyModifierSlots = 0
    for i,v in pairs(player.modifierSlots) do
        if v.name then
            nonEmptyModifierSlots = nonEmptyModifierSlots + 1
        end
    end
    love.graphics.setFont(Exo2_24M)
    love.graphics.printf("Active: " .. nonEmptyModifierSlots .. "/" .. #player.modifierSlots, 926, 5, 240, "center")
    if player.rank >= -1 then
        local nameColor = "ffffff"
        for i,v in pairs(player.modifierSlots) do
            if v.name and v.name:sub(1, 1) == "D" then
                nameColor = "000000"
            end
            if v.name then
                love.graphics.draw(v.image, 898 + i * 62, 42, 0, 48/128)
                love.graphics.setHexColor(nameColor)
                love.graphics.setFont(FiraMono_12M)
                love.graphics.print(v.name, 920 + i * 62, 44)
                love.graphics.setHexColor("ffffff")
            end
            love.graphics.draw(modifier_frame, 896 + i * 62, 40)
        end
    end
    love.graphics.setLineStyle("smooth")
    love.graphics.setLineWidth(2)
    love.graphics.setHexColor("ff7100")
    love.graphics.rectangle("fill", 926, 120, 240, 50, 3, 3)
    love.graphics.setHexColor("ffffff")
    love.graphics.rectangle("line", 926, 120, 240, 50, 3, 3)
    love.graphics.setFont(Exo2_12M)
    love.graphics.setHexColor("000000")
    love.graphics.printf("Start assembling a random modifier\n\nCosts " .. 90 * player.modifier.boosts.assemblyCost .. " Krono and takes " .. 240 * player.modifier.boosts.assemblyCooldown .. "s", 926, 123, 240, "center")
    love.graphics.setColor(255/255, 113/255, 0/255, 96/255)
    love.graphics.rectangle("fill", 926, 173, 240, 10)
    love.graphics.setHexColor("8cd500")
    love.graphics.rectangle("fill", 1166 - math.floor(240 - player.modifier.assemblyCooldown), 173, 240 - math.ceil(240 * (player.modifier.assemblyCooldown / 240)), 10)

    if player.menu.modifierDrawn then
        love.graphics.setColor(0/255, 0/255, 0/255, 128/255)
        love.graphics.rectangle("fill", 0, 0, 1280, 720)
        love.graphics.setHexColor("ffffff")
        love.graphics.setFont(Exo2_32M)
        love.graphics.printf("Modifier drawn!", 0, 150, 1280, "center")
        love.graphics.setFont(FiraMono_32M)
        love.graphics.draw(player.modifier.lastDrawn.image, 482, 200)
        if player.modifier.lastDrawn.name:sub(1, 1) == "D" then
            love.graphics.setHexColor("000000")
        end
        love.graphics.print(player.modifier.lastDrawn.name, 547, 200)
        love.graphics.setHexColor("ffffff")
        love.graphics.line(655, 325, 655, 200, 775, 200)
        love.graphics.setFont(Exo2_16M)
        local i = 0
        for key,value in pairs(player.modifier.lastDrawn.boosts) do
            i = i + 1
            if key == "kronoGainBoost" then
                love.graphics.printf(string.format("+%d%% Krono", (value - 1) * 100), 660, 170 + i * 30, 400, "left")
            elseif key == "kronoCooldownReduction" then
                love.graphics.printf(string.format("-%d%% Krono button cooldown", value * 100), 660, 170 + i * 30, 400, "left")
            elseif key == "assemblyCostReduction" then
                love.graphics.printf(string.format("-%d%% Assembly cost", value * 100), 660, 170 + i * 30, 400, "left")
            elseif key == "assemblyCooldownReduction" then
                love.graphics.printf(string.format("+%d%% Assembly cooldown", value * 100), 660, 170 + i * 30, 400, "left")
            end
        end
        local totalModifierWeight = 0
        for _,v in pairs(modifiers) do
            totalModifierWeight = totalModifierWeight + v.weight
        end
        love.graphics.setFont(Exo2_12R)
        love.graphics.printf("Obtainment rate: " .. (player.modifier.lastDrawn.weight / totalModifierWeight) * 100 .. "%", 660, 310, 400, "left")
        love.graphics.setFont(Exo2_18R)
        love.graphics.printf("Choose a slot to equip this modifier...", 440, 350, 400, "center")
        for i,v in pairs(player.modifierSlots) do
            if v.name ~= nil then
                love.graphics.draw(v.image, 490 + i * 62, 380, 0, 48/128)
            end
            love.graphics.draw(modifier_frame, 488 + i * 62, 380)
        end
        love.graphics.setLineStyle("smooth")
        love.graphics.setLineWidth(2)
        love.graphics.setFont(FiraMono_14M)
        love.graphics.setHexColor("ff007a")
        love.graphics.rectangle("fill", 520, 480, 240, 28, 3, 3)
        love.graphics.setHexColor("ffffff")
        love.graphics.rectangle("line", 520, 480, 240, 28, 3, 3)
        love.graphics.setFont(Exo2_16R)
        love.graphics.printf("Discard", 520, 483, 240, "center")
        love.graphics.setFont(Exo2_14R)
        love.graphics.printf("Discarded modifiers can't be restored", 440, 510, 400, "center")
    end
    love.graphics.setHexColor("ffffff")
end

function love.update(dt)
    for _,v in pairs(kronoButtons) do
        if v.cooldownTimer > 0 then
            v.cooldownTimer = v.cooldownTimer - dt
        else
            v.cooldownTimer = 0
        end
    end
    if player.modifier.assemblyCooldown > 0 then
        player.modifier.assemblyCooldown = math.max(0, player.modifier.assemblyCooldown - dt)
    end
end

function love.mousepressed(x, y, button)
    for _,v in pairs(kronoButtons) do
        if x >= v.position[1] and x <= v.position[1] + 240 and y >= v.position[2] and y <= v.position[2] + 28 and v.cooldownTimer <= 0 and player.rank >= v.unlockRank then
            player.krono = player.krono + v.kronoGain * player.modifier.boosts.kronoGain
            v.cooldownTimer = v.cooldown * player.modifier.boosts.kronoCooldown
            if player.krono >= rankRequirements[player.rank + 1] then
                player.krono = player.krono - rankRequirements[player.rank + 1]
                player.rank = player.rank + 1
            end
        end
    end
    if x >= 926 and x <= 1166 and y >= 120 and y <= 170 and player.rank >= 11 and player.modifier.assemblyCooldown <= 0 and not player.menu.modifierDrawn then
        if player.modifier.openOnNextClick then
            player.menu.modifierDrawn = true
            player.modifier.openOnNextClick = false
            player.modifier.lastDrawn = dropTable.draw(modifiers)
        else
            player.krono = player.krono - 90 * player.modifier.boosts.assemblyCost
            player.modifier.openOnNextClick = true
            if player.krono < 0 then
                player.rank = player.rank - 1
                player.krono = rankRequirements[player.rank + 1] + player.krono
            end
            player.modifier.assemblyCooldown = 240 * player.modifier.boosts.assemblyCooldown
        end
    end
    if player.menu.modifierDrawn then
        for i,v in ipairs(player.modifierSlots) do
            if x >= 490 + i * 62 and x <= 542 + i * 62 and y >= 380 and y <= 432 then
                player.modifierSlots[i] = player.modifier.lastDrawn
                player.menu.modifierDrawn = false
                updateModifierBoosts()
            end
        end
        if x >= 520 and x <= 760 and y >= 480 and y <= 508 then
            player.menu.modifierDrawn = false
        end
    end
end

function love.quit()
    savefile.write()
end