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

-- Constants
local CHEMISTRY = "chemistry"
local FISH_ICON = "__base__/graphics/icons/fish.png"
local GENETICS = "acg-genetics"

-- Generic function to create a recipe
local function createRecipe(recipeType, recipeName, category, energyRequired, ingredients, results, icon, subgroup, order)
    return {
        type = recipeType,
        name = recipeName,
        category = category,
        energy_required = energyRequired,
        ingredients = ingredients,
        results = results,
        enabled = true,
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
    local results = {{type="item", name=fishType .. "-genetic-sample", amount=1, probability=0.1}}
    
    return createRecipe("recipe", recipeName, CHEMISTRY, 30, ingredients, results, FISH_ICON, GENETICS, "a")
end

local function createTraitIdentificationRecipe(fishType, trait)
    local recipeName = "identify-" .. trait .. "-trait-" .. fishType
    local ingredients = {{type="item", name=fishType .. "-genetic-sample", amount=1}}
    local results = {{type="item", name=fishType .. "-" .. trait .. "-trait", amount=1, probability=0.33}}
    
    return createRecipe("recipe", recipeName, CHEMISTRY, 60, ingredients, results, FISH_ICON, GENETICS, "b")
end

local function createModuleRecipe(fishType, traits, tier)
    local recipeName = fishType .. "-" .. table.concat(traits, "") .. "-module-tier-" .. tostring(tier)
    local ingredients = {}
    local previousModule = fishType .. "-" .. table.concat(traits, "") .. "-module-tier-" .. tostring(tier - 1)
    if tier == 1 then
        for _, trait in ipairs(traits) do
            table.insert(ingredients, {type="item", name=fishType .. "-" .. trait .. "-trait", amount=3})
        end
    else
        for _, trait in ipairs(traits) do
            table.insert(ingredients, {type="item", name=fishType .. "-" .. trait .. "-trait", amount=3})
        end
        table.insert(ingredients, {type="item", name=previousModule, amount=1})
    end
    local results = {{type="item", name=recipeName, amount=1}}
    
    return createRecipe("recipe", recipeName, CHEMISTRY, 120, ingredients, results, FISH_ICON, GENETICS, "c")
end

-- Generate recipes
local recipes = {}
for _, fishType in ipairs(fishTypes) do
    table.insert(recipes, createGeneticSampleRecipe(fishType))
    table.insert(recipes, createTraitIdentificationRecipe(fishType, "g"))
    table.insert(recipes, createTraitIdentificationRecipe(fishType, "y"))
    table.insert(recipes, createTraitIdentificationRecipe(fishType, "b"))
    
    for tier = 1, 3 do
        table.insert(recipes, createModuleRecipe(fishType, {"g"}, tier))
        table.insert(recipes, createModuleRecipe(fishType, {"y"}, tier))
        table.insert(recipes, createModuleRecipe(fishType, {"b"}, tier))
        table.insert(recipes, createModuleRecipe(fishType, {"g", "y"}, tier))
        table.insert(recipes, createModuleRecipe(fishType, {"g", "b"}, tier))
        table.insert(recipes, createModuleRecipe(fishType, {"y", "b"}, tier))
    end
end

-- Extend data
data:extend(recipes)
