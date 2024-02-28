-- Define limitations specifically for mukmoux fish type.
local mukmouxLimitations = {
    "ac-breed-mukmoux",
    "ac-breed-mukmoux-egg",
    "ac-process-mukmoux-eggs-for-fish"
}

-- Apply limitations to mukmoux modules
for moduleName, moduleData in pairs(data.raw["module"]) do
    if string.find(moduleName, "^mukmoux") then
        -- Ensure the module is limited to recipes of the mukmoux fish type
        moduleData.limitations = mukmouxLimitations
        log("Successfully applied limitations to module: " .. moduleName)
    else
        moduleData.limitations = nil
        log("Failed to apply limitations to module: " .. moduleName)
    end
end

-- Definine limitations specifically for glowfin-trenchers fish type
local glowfinTrenchersLimitations = {
    "ac-breed-glowfin-trenchers",
    "ac-breed-glowfin-trenchers-egg",
    "ac-process-glowfin-trenchers-eggs-for-fish"
}

-- Apply limitations to glowfin-trenchers modules
for moduleName, moduleData in pairs(data.raw["module"]) do
    if string.find(moduleName, "^glowfin-trenchers") then
        -- Ensure the module is limited to recipes of the glowfin-trenchers fish type
        moduleData.limitations = glowfinTrenchersLimitations
        log("Successfully applied limitations to module: " .. moduleName)
    else
        moduleData.limitations = nil
        log("Failed to apply limitations to module: " .. moduleName)
    end
end

-- Define limitations specifically for silverscale-glider fish type
local silverscaleGliderLimitations = {
    "ac-breed-silverscale-glider",
    "ac-breed-silverscale-glider-egg",
    "ac-process-silverscale-glider-eggs-for-fish"
}

-- Apply limitations to silverscale-glider modules
for moduleName, moduleData in pairs(data.raw["module"]) do
    if string.find(moduleName, "^silverscale-glider") then
        -- Ensure the module is limited to recipes of the silverscale-glider fish type
        moduleData.limitations = silverscaleGliderLimitations
        log("Successfully applied limitations to module: " .. moduleName)
    else
        moduleData.limitations = nil
        log("Failed to apply limitations to module: " .. moduleName)
    end
end