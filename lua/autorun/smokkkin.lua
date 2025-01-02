--- Additions
---@generic T
---@alias List table<number, T>

smokkkin = {}
smokkkin.authors = {"smokingplaya"}
smokkkin.repository = "https://github.com/oosdinc/smokkkinlib"
smokkkin.version = "1.0.3"

if (SERVER) then
  AddCSLuaFile("smokkkin/loader.lua")
end

include("smokkkin/loader.lua")

local load_order = {
  "config.lua",
  "class.lua",
  "logger.lua",
  "util.lua",
  "module.lua",
}

for _, filename in ipairs(load_order) do
  smokkkin.loader:includeSh("smokkkin/" .. filename)
end
