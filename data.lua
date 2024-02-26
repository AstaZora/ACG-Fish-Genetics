require("prototypes.entity.entity")
require("prototypes.item.item")
require("prototypes.recipe.recipe")
require("prototypes.categories.fluid-recipes")
require("prototypes.categories.recipe-category")
require("prototypes.technologies.technologies")
require("prototypes.categories.fuel-category")
require("prototypes.entity.resources")
require("prototypes.entity.autoplace-controls")

-- List of fish types
local fishTypes = {
    "glowfin-trenchers",
    "mukmoux",
    "silverscale-glider"
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

