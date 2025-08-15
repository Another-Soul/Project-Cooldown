modifiers = {
    {name = "A01", weight = 105, boosts = {kronoGainBoost = 1.02}, image = modifier_A},
    {name = "A02", weight = 30, boosts = {kronoGainBoost = 1.04}, image = modifier_A},
    {name = "A03", weight = 12, boosts = {kronoGainBoost = 1.06}, image = modifier_A},
    {name = "A04", weight = 3, boosts = {kronoGainBoost = 1.12}, image = modifier_A},

    {name = "B01", weight = 105, boosts = {kronoCooldownReduction = 0.01}, image = modifier_B},
    {name = "B02", weight = 30, boosts = {kronoCooldownReduction = 0.02}, image = modifier_B},
    {name = "B03", weight = 12, boosts = {kronoCooldownReduction = 0.03}, image = modifier_B},
    {name = "B04", weight = 3, boosts = {kronoCooldownReduction = 0.05}, image = modifier_B},

    {name = "C01", weight = 105, boosts = {assemblyCostReduction = 0.01}, image = modifier_C},
    {name = "C02", weight = 30, boosts = {assemblyCostReduction = 0.02}, image = modifier_C},
    {name = "C03", weight = 12, boosts = {assemblyCostReduction = 0.04}, image = modifier_C},
    {name = "C04", weight = 3, boosts = {assemblyCostReduction = 0.06}, image = modifier_C},

    {name = "D01", weight = 105, boosts = {assemblyCooldownReduction = 0.01}, image = modifier_D},
    {name = "D02", weight = 30, boosts = {assemblyCooldownReduction = 0.02}, image = modifier_D},
    {name = "D03", weight = 12, boosts = {assemblyCooldownReduction = 0.03}, image = modifier_D},
    {name = "D04", weight = 3, boosts = {assemblyCooldownReduction = 0.04}, image = modifier_D},

    {name = "E01", weight = 57, boosts = {kronoGainBoost = 1.016, assemblyCostReduction = 0.006}, image = modifier_E},
    {name = "E02", weight = 16, boosts = {kronoGainBoost = 1.035, assemblyCostReduction = 0.011}, image = modifier_E},
    {name = "E03", weight = 6, boosts = {kronoGainBoost = 1.048, assemblyCostReduction = 0.015}, image = modifier_E},
    {name = "E04", weight = 1, boosts = {kronoGainBoost = 1.09, assemblyCostReduction = 0.024}, image = modifier_E},

    {name = "F01", weight = 57, boosts = {kronoCooldownReduction = 0.008, assemblyCooldownReduction = 0.005}, image = modifier_F},
    {name = "F02", weight = 16, boosts = {kronoCooldownReduction = 0.015, assemblyCooldownReduction = 0.009}, image = modifier_F},
    {name = "F03", weight = 6, boosts = {kronoCooldownReduction = 0.024, assemblyCooldownReduction = 0.012}, image = modifier_F},
    {name = "F04", weight = 1, boosts = {kronoCooldownReduction = 0.036, assemblyCooldownReduction = 0.017}, image = modifier_F},

    {name = "G01", weight = 57, boosts = {assemblyCostReduction = 0.008, kronoCooldownReduction = 0.008}, image = modifier_H},
    {name = "G02", weight = 16, boosts = {assemblyCostReduction = 0.015, kronoCooldownReduction = 0.012}, image = modifier_H},
    {name = "G03", weight = 6, boosts = {assemblyCostReduction = 0.025, kronoCooldownReduction = 0.016}, image = modifier_H},
    {name = "G04", weight = 1, boosts = {assemblyCostReduction = 0.04, kronoCooldownReduction = 0.02}, image = modifier_H},

    {name = "H01", weight = 57, boosts = {assemblyCooldownReduction = 0.009, kronoGainBoost = 1.016}, image = modifier_G},
    {name = "H02", weight = 16, boosts = {assemblyCooldownReduction = 0.018, kronoGainBoost = 1.032}, image = modifier_G},
    {name = "H03", weight = 6, boosts = {assemblyCooldownReduction = 0.027, kronoGainBoost = 1.05}, image = modifier_G},
    {name = "H04", weight = 1, boosts = {assemblyCooldownReduction = 0.036, kronoGainBoost = 1.08}, image = modifier_G},
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