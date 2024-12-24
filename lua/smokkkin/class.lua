--- Library for easier class creation
smokkkin.class = {
  ---@type table<string, ClassObject>
  list = {}
}

---@class ClassObject
---@field __name string Name of the class
local class = {}
class.__index = class
class.__tostring = function(self)
  return "[Instance " .. (self.__name or "n/a") .. "]"
end
class.constructor = function() end

--- Creates a class (metatable) and
--- registers it through RegisterMetaTable
---
--- @param name string Name of the class
function smokkkin.class:new(name)
  local base = setmetatable({}, class)
  base.__index = base

  self.list[name] = base
   
  RegisterMetaTable(name, base)

  return base
end

--- Returns a ClassObject
---
---@param name string
---@param includeState? State
---@return ClassObject? ClassObject
function smokkkin.class:get(name, includeState)
  local class = self.list[name]

  if (!class) then
    local includer = smokkkin.loader[includeState || "shared"]
    -- Well well...
    class = includer(smokkkin.loader, "smokkkin/classes/" .. name:Trim():lower() .. ".lua")
  end

  return class
end

--- Creates instance of the class
---
---@generic R: ClassObject
---@param name string Name/ClassObject of the class
---@return R Instance of the class
function smokkkin.class.createInstance(name, ...)
  local classBase = smokkkin.class:get(name)
  local instance = setmetatable({}, classBase)

  instance:constructor(...)

  return instance
end

new = smokkkin.class.createInstance
