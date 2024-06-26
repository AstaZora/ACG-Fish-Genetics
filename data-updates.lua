-- Predefined list of fish types
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

-- Utility function to determine if a string starts with another string
local function starts_with(str, start)
    return str:sub(1, #start) == start
end

-- Sort the fishTypes table
table.sort(fishTypes)

-- Iterating over fishTypes to apply module limitations
for _, fishType in ipairs(fishTypes) do
    for moduleName, module in pairs(data.raw.module) do
        -- Check if the module name starts with the fishType followed by a hyphen
        if starts_with(moduleName, fishType .. "-") then
            -- Apply limitations based on fishType
            module.limitation = module.limitation or {}
            table.insert(module.limitation, "ac-breed-" .. fishType)
            --print("Applied limitation: ac-breed-" .. fishType .. " to module: " .. moduleName)
            table.insert(module.limitation, "ac-process-" .. fishType .. "-eggs-for-fish")
            --print("Applied limitation: ac-process-" .. fishType .. "-eggs-for-fish to module: " .. moduleName)
            table.insert(module.limitation, "ac-breed-" .. fishType .. "-egg")
            --print("Applied limitation: ac-breed-" .. fishType .. "-egg to module: " .. moduleName)
            table.insert(module.limitation, "produce-genetic-sample-" .. fishType)
            --print("Applied limitation: produce-genetic-sample-" .. fishType .. " to module: " .. moduleName)
            table.insert(module.limitation, "identify-b-trait-" .. fishType)
            --print("Applied limitation: identify-b-trait-" .. fishType .. " to module: " .. moduleName)
            table.insert(module.limitation, "identify-g-trait-" .. fishType)
            --print("Applied limitation: identify-g-trait-" .. fishType .. " to module: " .. moduleName)
            table.insert(module.limitation, "identify-y-trait-" .. fishType)
            --print("Applied limitation: identify-y-trait-" .. fishType .. " to module: " .. moduleName)
        else
            --print("Skipped module:", moduleName, "for fish type:", fishType)
        end
    end
end

--print("Module limitations update completed.")