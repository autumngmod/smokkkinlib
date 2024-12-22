--- A library that add logic for the modules.
smokkkin.module = {
  --- A list of modules.
  ---@type Module
  list = {}
}

---@class Module
local module_class = {
  --- Fields
  name = "",
  version = "1.0.0",
  repository = "https://github.com/smokingplaya/",
  description = "",
  authors = {},
  hooks = {},
}

module_class.__index = module_class

--- Creates and insertes a new module to the list.
---@param name string
function smokkkin.module:new(name)
  local module = setmetatable({
    name = name,
  }, module_class)

  -- If module already existed
  if (self:get(name)) then
    self:remove(name)
  end

  self:set(name, module)

  return module
end

---@param name string
---@return Module | nil
function smokkkin.module:get(name)
  return self.list[name]
end

---@private
---@param name string
---@param module Module | nil
function smokkkin.module:set(name, module)
  self.list[name] = module
end

--- Safely removing a already existed module
---@param name string
function smokkkin.module:remove(name)
  local module = self:get(name)

  if (!module) then
    return
  end

  module:disable()

  self:set(name, nil)
end

--- todo @
---@param name string
function smokkkin.module:enable(name)
  local module = self:get(name)

  if (!module) then
    return
  end

  module:enable()
end

--- todo @
---@param name string
function smokkkin.module:disable(name)
  local module = self:get(name)

  if (!module) then
    return
  end

  module:disable()
end

--- Loades all modules
---@private
function smokkkin.module:initialize()

end
