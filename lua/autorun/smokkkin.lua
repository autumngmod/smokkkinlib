smokkkin = {
  addon = {
    authors = {"smokingplaya"},
    repository = "https://github.com/oosdinc/smokkkinlib",
    version = "1.0.6"
  }
}

IncludeCS("smokkkin/loader.lua")

local order = {
  shared = {
    "config.lua",
    "util.lua",
    "class.lua",
    "logger.lua",
    "http.lua",
    "network.lua",
  },

  client = {
    "webview.lua"
  }
}

local loader = smokkkin.loader
for state, tab in pairs(order) do
  local include = loader[state]

  for _, filename in ipairs(tab) do
    include(loader, "smokkkin/" .. filename)
  end
end

smokkkin.loader:includeSh("smokkkin/module.lua")
