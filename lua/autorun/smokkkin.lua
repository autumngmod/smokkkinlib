smokkkin = {}
smokkkin.authors = {"smokingplaya"}
smokkkin.repository = "https://github.com/oosdinc/smokkkinlib"
smokkkin.version = "1.0.0"

if (SERVER) then
  AddCSLuaFile("lua/smokkkin/loader.lua")
end

include("lua/smokkkin/loader.lua")

local load_order = {
  "log.lua",
  "class.lua",
  "module.lua"
}

for _, filename in ipairs(load_order) do
  smokkkin.loader:includeSh("lua/smokkkin/" .. filename)
end
