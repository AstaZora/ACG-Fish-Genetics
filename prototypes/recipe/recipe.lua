local fishTypes = {
    "glowfin-trenchers",
    "mukmoux",
    "silverscale-glider"
}

-- Function to create recipes for producing genetic samples from eggs
local function createGeneticSampleRecipe(fishType)
    return {
        type = "recipe",
        name = "produce-genetic-sample-" .. fishType,
        category = "chemistry", -- Adjust the category as needed
        energy_required = 30,
        ingredients = {{type="item", name=fishType .. "-egg", amount=100}},
        results = {
            {type="item", name=fishType .. "-genetic-sample", amount=1, probability=0.01}
        },
        enabled = true, -- Set this according to how you plan to unlock the recipe
        icon = "__base__/graphics/icons/fish.png",
        icon_size = 64,
        subgroup = "acg-genetics",
        order = "a",
    }
end

-- Function to create recipes for identifying G, Y, or B traits from genetic samples
local function createTraitIdentificationRecipe(fishType, trait)
    return {
        type = "recipe",
        name = "identify-" .. trait .. "-trait-" .. fishType,
        category = "chemistry", -- Adjust the category as needed
        energy_required = 60,
        ingredients = {{type="item", name=fishType .. "-genetic-sample", amount=1}},
        results = {
            {type="item", name=fishType .. "-" .. trait .. "-trait", amount=1, probability=0.33}
        },
        enabled = true, -- Set this according to how you plan to unlock the recipe
        icon = "__base__/graphics/icons/fish.png", -- "__your_mod_directory__/graphics/icons/" .. trait .. "-trait.png",
        icon_size = 64,
        subgroup = "acg-genetics",
        order = "b",
    }
end

-- Function to create module production recipes
local function createModuleProductionRecipe(fishType, traits, tier)
    local traitCombination = table.concat(traits, "")
    local ingredientList = {}
    local traitAmount = tier -- Amount of each trait required per tier

    -- Generate ingredients based on traits and tier
    for _, trait in ipairs(traits) do
        table.insert(ingredientList, {type="item", name=fishType .. "-" .. trait .. "-trait", amount=traitAmount})
    end

    return {
        type = "recipe",
        name = fishType .. "-" .. traitCombination .. "-module-tier-" .. tostring(tier),
        category = "advanced-crafting", -- Adjust the category as needed
        energy_required = 15 * tier, -- Increasing energy requirement by tier
        ingredients = ingredientList,
        results = {{type="module", name=fishType .. "-" .. traitCombination .. "-module-tier-" .. tostring(tier), amount=1}},
        enabled = true, -- Set this according to how you plan to unlock the recipe
        icon = "__base__/graphics/icons/fish.png",  --"__your_mod_directory__/graphics/icons/" .. fishType .. "-" .. traitCombination .. "-module-tier-" .. tostring(tier) .. ".png",
        icon_size = 64,
        subgroup = "fish-breeding-modules",
        order = "c",
    }
end

-- Extending data with the module production recipes
local moduleTypes = {{"g", "y"}, {"g", "b"}, {"y", "b"}} -- Define module types as combinations of traits

for _, fishType in ipairs(fishTypes) do
    for _, moduleType in ipairs(moduleTypes) do
        for tier = 1, 3 do -- Tiers 1 to 3
            data:extend({createModuleProductionRecipe(fishType, moduleType, tier)})
        end
    end
end


-- Extending data with the recipes
for _, fishType in ipairs(fishTypes) do
    data:extend({createGeneticSampleRecipe(fishType)})
    data:extend({
        createTraitIdentificationRecipe(fishType, "g"),
        createTraitIdentificationRecipe(fishType, "y"),
        createTraitIdentificationRecipe(fishType, "b")
    })
end
