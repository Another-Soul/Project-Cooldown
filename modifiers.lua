modifiers = {
    {name = "A01", weight = 35, boosts = {kronoGainBoost = 1.02}, image = love.graphics.newImage("modifier_A.png")},
    {name = "A02", weight = 10, boosts = {kronoGainBoost = 1.04}, image = love.graphics.newImage("modifier_A.png")},
    {name = "A03", weight = 4, boosts = {kronoGainBoost = 1.06}, image = love.graphics.newImage("modifier_A.png")},
    {name = "A04", weight = 1, boosts = {kronoGainBoost = 1.12}, image = love.graphics.newImage("modifier_A.png")},

    {name = "B01", weight = 35, boosts = {kronoCooldownReduction = 0.01}, image = love.graphics.newImage("modifier_B.png")},
    {name = "B02", weight = 10, boosts = {kronoCooldownReduction = 0.02}, image = love.graphics.newImage("modifier_B.png")},
    {name = "B03", weight = 4, boosts = {kronoCooldownReduction = 0.03}, image = love.graphics.newImage("modifier_B.png")},
    {name = "B04", weight = 1, boosts = {kronoCooldownReduction = 0.05}, image = love.graphics.newImage("modifier_B.png")},

    {name = "C01", weight = 35, boosts = {assemblyCostReduction = 0.01}, image = love.graphics.newImage("modifier_C.png")},
    {name = "C02", weight = 10, boosts = {assemblyCostReduction = 0.02}, image = love.graphics.newImage("modifier_C.png")},
    {name = "C03", weight = 4, boosts = {assemblyCostReduction = 0.04}, image = love.graphics.newImage("modifier_C.png")},
    {name = "C04", weight = 1, boosts = {assemblyCostReduction = 0.06}, image = love.graphics.newImage("modifier_C.png")},

    {name = "D01", weight = 35, boosts = {assemblyCooldownReduction = 0.01}, image = love.graphics.newImage("modifier_D.png")},
    {name = "D02", weight = 10, boosts = {assemblyCooldownReduction = 0.02}, image = love.graphics.newImage("modifier_D.png")},
    {name = "D03", weight = 4, boosts = {assemblyCooldownReduction = 0.03}, image = love.graphics.newImage("modifier_D.png")},
    {name = "D04", weight = 1, boosts = {assemblyCooldownReduction = 0.04}, image = love.graphics.newImage("modifier_D.png")},
}

dropTable = {}
function dropTable.draw(tbl)
    local totalItemWeight = 0
    for _,v in pairs(tbl) do
        totalItemWeight = totalItemWeight + v.weight
    end
    local weightLeftToDraw = love.math.random(0, totalItemWeight)
    for _,v in pairs(tbl) do
        weightLeftToDraw = weightLeftToDraw - v.weight
        if weightLeftToDraw <= 0 then
            return v
        end
    end
end