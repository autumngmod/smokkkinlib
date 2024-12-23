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

--- Creates a class (metatable) and
--- registers it through RegisterMetaTable
---
--- @param name string Name of the class
function smokkkin.class:new(name)
  local class = setmetatable({
    __index = {},
    __name = name,
  }, class)

  self.list[name] = class

  RegisterMetaTable(name, class)

  return class
end

--- Returns a ClassObject
---
---@return ClassObject? ClassObject
function smokkkin.class:get(name)
  return self.list[name]
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
