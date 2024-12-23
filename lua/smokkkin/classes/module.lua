---@class Module: ClassObject
local class = smokkkin.class:new("Module")

---@param name string
function class:constructor(name)
  self.name = name
end

--- Enables module: adds hooks, commands etc
---@param log? boolean
function class:enable(log)
  if (log) then
    smokkkin.log:debug("Enabling module %s", self.name)
  end

  self:enableHooks()
  self:enableCommands()

  self:onEnable()
end

--- Function, that calls on module enabling
--- Plug function that needed for overriding
function class:onEnable()
end

---@param log? boolean
function class:disable(log)
  if (log) then
    smokkkin.log:debug("Disabling module %s", self.name)
  end

  self:disableHooks()
  self:disableCommands()

  self:onDisable()
end

--- Function, that calls on module disabling
--- Plug function that needed for overriding
function class:onDisable()
end

return class
