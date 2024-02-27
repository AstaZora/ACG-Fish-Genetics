local fishTypes = {
    "glowfin-trenchers",
    "mukmoux",
    "silverscale-glider"
}

-- Constants
local CHEMISTRY = "chemistry"
local FISH_ICON = "__base__/graphics/icons/fish.png"
local GENETICS = "acg-genetics"

-- Generic function to create a recipe
local function createRecipe(recipeType, recipeName, category, energyRequired, ingredients, results, enabled, icon, subgroup, order)
    return {
        type = recipeType,
        name = recipeName,
        category = category,
        energy_required = energyRequired,
        ingredients = ingredients,
        results = results,
        enabled = enabled,
        icon = icon,
        icon_size = 64,
        subgroup = subgroup,
        order = order,
    }
end

-- Functions to create specific recipes
local function createGeneticSampleRecipe(fishType)
    local recipeName = "produce-genetic-sample-" .. fishType
    local ingredients = {{type="item", name=fishType .. "-egg", amount=100}}
    local results = {{type="item", name=fishType .. "-genetic-sample", amount=1, probability=0.01}}
    
    return createRecipe("recipe", recipeName, CHEMISTRY, 30, ingredients, results, true, FISH_ICON, GENETICS, "a")
end

local function createTraitIdentificationRecipe(fishType, trait)
    local recipeName = "identify-" .. trait .. "-trait-" .. fishType
    local ingredients = {{type="item", name=fishType .. "-genetic-sample", amount=1}}
    local results = {{type="item", name=fishType .. "-" .. trait .. "-trait", amount=1, probability=0.33}}
    
    return createRecipe("recipe", recipeName, CHEMISTRY, 60, ingredients, results, true, FISH_ICON, GENETICS, "b")
end

-- Generate recipes
local recipes = {}
for _, fishType in ipairs(fishTypes) do
    table.insert(recipes, createGeneticSampleRecipe(fishType))
    table.insert(recipes, createTraitIdentificationRecipe(fishType, "g"))
    table.insert(recipes, createTraitIdentificationRecipe(fishType, "y"))
    table.insert(recipes, createTraitIdentificationRecipe(fishType, "b"))
end

-- Extend data
data:extend(recipes)