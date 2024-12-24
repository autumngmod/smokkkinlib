--- A library that add logic for the modules.
smokkkin.module = {
  --- A list of modules.
  ---@type table<number, Module>
  list = {}
}

local moduleClass = smokkkin.class:get("Module")

---@private
---@class ModuleData
---@field data table<"name" | "description" | "version" | "repository", string>
---@field include table<State, table<number, string>>

--- Creates and insertes a new module to the list.
---
---@param name string
---@param data ModuleData
function smokkkin.module:new(name, data)
  local module = new("Module", name)
  -- todo @ place "data" field somewhere...

  -- If module already existed
  if (self:get(name)) then
    self:remove(name)
  end

  self:set(name, module)

  module:include(data.include or {})
  module:enable()

  return module
end

---@param name string
---@return Module?
function smokkkin.module:get(name)
  return self.list[name]
end

---@private
---@param name string
---@param module? Module
function smokkkin.module:set(name, module)
  self.list[name] = module
end

--- Safely removing a already existed module
---@param name string
function smokkkin.module:remove(name)
  local module = self:get(name)

  if (module) then
    module:disable(false)
  end

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

local moduleBasePath = moduleClass.base
local moduleEntrypoint = "_module.lua"
--- Loades all modules
---@private
function smokkkin.module:initialize()
  smokkkin.log:info("Loading modules")

  local loadedModules = 0
  local _, dirs = file.Find(moduleBasePath .. "*", "LUA")

  for _, module in ipairs(dirs) do
    smokkkin.loader:includeSh(moduleBasePath .. module .. "/" .. moduleEntrypoint)
  end

  smokkkin.log:info("Loaded %s modules", loadedModules)
end

smokkkin.module:initialize()
