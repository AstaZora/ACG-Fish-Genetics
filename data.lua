require("prototypes.entity.entity")
require("prototypes.item.item")
require("prototypes.recipe.recipe")
require("prototypes.categories.fluid-recipes")
require("prototypes.categories.recipe-category")
require("prototypes.technologies.technologies")
require("prototypes.categories.fuel-category")
require("prototypes.entity.resources")
require("prototypes.entity.autoplace-controls")

local fishTypes = {
    "glowfin-trenchers",
    "mukmoux",
    "silverscale-glider",
    "neon-nocturne",
    "silent-drifter",
    "stream-sifter",
    "spiral-shellfish",
    "twilight-tetra",
    "starfin-darters"
}

local fishTypeLimitations = {
    ["glowfin-trenchers"] = {
        "ac-breed-glowfin-trenchers",
        "ac-process-glowfin-trenchers-eggs-for-fish",
        "ac-breed-glowfin-trenchers-egg",
    },
    ["mukmoux"] = {
        "ac-breed-mukmoux",
        "ac-process-mukmoux-eggs-for-fish",
        "ac-breed-mukmoux-egg",
    },
    ["silverscale-glider"] = {
        "ac-breed-silverscale-glider",
        "ac-process-silverscale-glider-eggs-for-fish",
        "ac-breed-silverscale-glider-egg",
    },
    ["neon-nocturne"] = {
        "ac-breed-neon-nocturne",
        "ac-process-neon-nocturne-eggs-for-fish",
        "ac-breed-neon-nocturne-egg",
    },
    ["silent-drifter"] = {
        "ac-breed-silent-drifter",
        "ac-process-silent-drifter-eggs-for-fish",
        "ac-breed-silent-drifter-egg",
    },
    ["stream-sifter"] = {
        "ac-breed-stream-sifter",
        "ac-process-stream-sifter-eggs-for-fish",
        "ac-breed-stream-sifter-egg",
    },
    ["spiral-shellfish"] = {
        "ac-breed-spiral-shellfish",
        "ac-process-spiral-shellfish-eggs-for-fish",
        "ac-breed-spiral-shellfish-egg",
    },
    ["twilight-tetra"] = {
        "ac-breed-twilight-tetra",
        "ac-process-twilight-tetra-eggs-for-fish",
        "ac-breed-twilight-tetra-egg",
    },
    ["starfin-darters"] = {
        "ac-breed-starfin-darters",
        "ac-process-starfin-darters-eggs-for-fish",
        "ac-breed-starfin-darters-egg",
    },  
}

-- Function to create genetic items for a fish type
local function createGeneticItemsForFishType(fishType)
    local geneticItems = {}
    
    -- Generic Genetic Sample
    table.insert(geneticItems, {
        type = "item",
        name = fishType .. "-genetic-sample",
        icon = "__base__/graphics/icons/fish.png", -- Placeholder icon
        icon_size = 64,
        subgroup = "acg-genetics",
        order = "a[" .. fishType .. "-genetic-sample]",
        stack_size = 100
    })

    -- Trait items: G, Y, B
    local traits = {"g", "y", "b"}
    for _, trait in ipairs(traits) do
        table.insert(geneticItems, {
            type = "item",
            name = fishType .. "-" .. trait .. "-trait",
            icon = "__base__/graphics/icons/fish.png", -- Placeholder icon
            icon_size = 64,
            subgroup = "acg-genetics",
            order = "b[" .. fishType .. "-" .. trait .. "-trait]",
            stack_size = 100
        })
    end

    return geneticItems
end

-- Generate and extend data for each fish type
for _, fishType in ipairs(fishTypes) do
    local geneticItems = createGeneticItemsForFishType(fishType)
    data:extend(geneticItems)
end

-- Define the fish types and traits
local moduleTraits = {"g", "y", "b", "gy", "gb", "yb"}
local tierLevels = {1, 2, 3}

-- Define the effects for each trait
local traitEffects = {
    g = {speed = 0.2},    -- Each G trait increases speed
    y = {productivity = 0.2}, -- Each Y trait increases productivity
    b = {productivity = 0.4}, -- Each B trait increases productivity for eggs
    gy = {speed = 0.1, productivity = 0.2}, -- GY combination
    gb = {speed = 0.1, productivity = 0.4}, -- GB combination
    yb = {productivity = 0.4}, -- YB combination
}

local function createModuleItem(fishType, traits, tier)
    local moduleName = fishType .. "-" .. table.concat(traits, "") .. "-module-tier-" .. tostring(tier)
    local effects = {
        tier = tier,
        speed = 0,
        productivity = 0,
        consumption = 0
    }

    -- Accumulate effects for each trait
    for _, trait in ipairs(traits) do
        for effect, value in pairs(traitEffects[trait]) do
            effects[effect] = (effects[effect] or 0) + value
        end
    end

    -- Multiply the total effects by the tier
    for effect, _ in pairs(effects) do
        effects[effect] = effects[effect] * tier
    end
    return {
        type = "module",
        name = moduleName,
        icon = "__base__/graphics/icons/fish.png",
        icon_size = 64,
        category = fishType .. "-genetics",
        tier = tier,
        effect = {
            speed = effects.speed > 0 and {bonus = effects.speed} or nil,
            productivity = effects.productivity > 0 and {bonus = effects.productivity} or nil,
        },
        limitations = fishTypeLimitations[fishType],
        limitation_message_key = "Only-allowed-with-" .. fishType .. "-recipes",
        subgroup = "module",
        order = "a",
        stack_size = 50
    }
end

-- Generate module items for each fish type, combination of traits, and tier
local moduleItems = {}
for _, fishType in ipairs(fishTypes) do
    for _, traitCombination in ipairs(moduleTraits) do
        local traits = {}
        for trait in traitCombination:gmatch(".") do
            table.insert(traits, trait)
        end

        for _, tier in ipairs(tierLevels) do
            local moduleItem = createModuleItem(fishType, traits, tier)
            table.insert(moduleItems, moduleItem)
        end
    end
end

data:extend(moduleItems)

