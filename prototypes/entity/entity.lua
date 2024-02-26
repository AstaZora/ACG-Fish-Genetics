
--[[local function deepcopy(orig) -- Since you don't have access to the util table
    local orig_type = type(orig)
    local copy
    if orig_type == 'table' then
        copy = {}
        for orig_key, orig_value in next, orig, nil do
            copy[deepcopy(orig_key)] = deepcopy(orig_value)
        end
        setmetatable(copy, deepcopy(getmetatable(orig)))
    else -- number, string, boolean, etc
        copy = orig
    end
    return copy
end

local function createEntity(name, category)
    local base = deepcopy(data.raw["assembling-machine"]["assembling-machine-2"])
    base.name = name
    base.icon = "__base__/graphics/icons/assembling-machine-1.png"
    base.icon_size = 64
    base.flags = {"placeable-neutral", "placeable-player", "player-creation"}
    base.minable = {mining_time = 0.2, result = name}
    base.max_health = 150
    base.crafting_categories = {category}
    base.crafting_speed = 1
    base.energy_usage = "60kW"
    base.energy_source = {
        type = "electric",
        usage_priority = "secondary-input",
        emissions_per_minute = 0.05
    }
    base.animation = base.animation or base.animations
    base.subgroup = "production-machine"
    base.order = "a[tree-farm]"
    base.collision_box = {{-1.2, -1.2}, {1.2, 1.2}}
    base.selection_box = {{-1.5, -1.5}, {1.5, 1.5}}
    base.next_upgrade = nil
    return base
end


local function createChemical(name, category)
    local base = deepcopy(data.raw["assembling-machine"]["chemical-plant"])
    base.name = name
    base.icon = "__base__/graphics/icons/chemical-plant.png"
    base.icon_size = 64
    base.flags = {"placeable-neutral", "placeable-player", "player-creation"}
    base.minable = {mining_time = 0.2, result = name}
    base.max_health = 150
    base.crafting_categories = {category}
    base.crafting_speed = 1
    base.energy_usage = "300kW"
    base.energy_source = {
        type = "electric",
        usage_priority = "secondary-input",
        emissions_per_minute = 0.05
    }
    base.animation = base.animation or base.animations
    base.subgroup = "production-machine"
    base.order = "a[tree-farm]"
    base.collision_box = {{-1.2, -1.2}, {1.2, 1.2}}
    base.selection_box = {{-1.5, -1.5}, {1.5, 1.5}}
    base.next_upgrade = nil
    return base
end

local function createFurnace(name, category)
    local base = deepcopy(data.raw["furnace"]["stone-furnace"])
    base.name = name
    base.icon = "__base__/graphics/icons/stone-furnace.png"
    base.icon_size = 64
    base.minable = {mining_time = 0.2, result = name}
    base.crafting_categories = {category}
    base.crafting_speed = 1
    base.energy_usage = "90kW"
    base.source_inventory_size = 1
    base.result_inventory_size = 1
    -- Other properties to adjust...
    return base
end

local function createCentrifuge(name, category)
    local base = deepcopy(data.raw["assembling-machine"]["centrifuge"])
    base.name = name
    base.icon = "__base__/graphics/icons/centrifuge.png"
    base.icon_size = 64
    base.minable = {mining_time = 0.2, result = name}
    base.crafting_categories = {category}
    base.crafting_speed = 1
    base.energy_usage = "350kW"
    base.fluid_boxes = {
        {
            production_type = "input",
            pipe_picture = assembler2pipepictures(),
            pipe_covers = pipecoverspictures(),
            base_area = 10,
            base_level = -1,
            pipe_connections = {{ type="input", position = {0, -2} }}
        },
        {
            production_type = "output",
            pipe_picture = assembler2pipepictures(),
            pipe_covers = pipecoverspictures(),
            base_area = 10,
            base_level = 1,
            pipe_connections = {{ type="output", position = {0, 2} }}
        }
    }
    -- Other properties to adjust...
    return base
end

local function createOilRefinery(name, category)
    local base = deepcopy(data.raw["assembling-machine"]["oil-refinery"])
    base.name = name
    base.icon = "__base__/graphics/icons/oil-refinery.png"
    base.icon_size = 64
    base.minable = {mining_time = 0.2, result = name}
    base.crafting_categories = {category}
    base.crafting_speed = 1
    base.emissions_per_minute = 1
    base.energy_usage = "420kW"
    base.module_specification =
    {
        module_slots = 3,
        module_info_icon_shift = {0, 0.8}
    }
    -- Adjust animation or any other necessary properties...
    return base
end
]]
