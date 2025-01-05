smokkkin = {
  addon = {
    authors = {"smokingplaya"},
    repository = "https://github.com/oosdinc/smokkkinlib",
    version = "1.0.5"
  }
}

IncludeCS("smokkkin/loader.lua")

local load_order = {
  "config.lua",
  "util.lua",
  "class.lua",
  "logger.lua",

  "http.lua",
  "network.lua",
}

for _, filename in ipairs(load_order) do
  smokkkin.loader:includeSh("smokkkin/" .. filename)
end

smokkkin.loader:includeSh("smokkkin/module.lua")