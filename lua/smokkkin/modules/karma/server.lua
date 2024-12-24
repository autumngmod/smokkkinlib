local module = smokkkin.module:get("karma")

if (module == nil) then
  error("No module 'karma' found")
else
  smokkkin.log:trace "hi from karma/server.lua"
end

module.onEnable = function(self)
  smokkkin.log:debug("Enabling module %s", self.name)
end

module.onDisable = function(self)
  smokkkin.log:debug("Disabling module %s", self.name)
end

module:listen(function(player)
  print(player)
end, "playerJoined", "id")
