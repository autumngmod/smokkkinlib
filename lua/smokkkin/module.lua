--- A library that add logic for the modules.
smokkkin.module = {
  --- A list of modules.
  ---@type Module[]
  list = {}
}

local moduleClass = smokkkin.class:get("Module")

---@private
---@class ModuleDataInfo
---@field name string
---@field description string?
---@field authors string[]
---@field git string?
---@field version string
---@field libVersion string?

---@private
---@class ModuleDataInclude
---@field client string[]?
---@field shared string[]?
---@field server string[]?

---@private
---@class ModuleData
---@field info ModuleDataInfo
---@field include ModuleDataInclude
---@field config? table<string, any>

--- Creates and insertes a new module to the list.
---
---@param name string
---@param data ModuleData
function smokkkin.module:new(name, data)
  local module = new("Module", data)
  -- todo @ place "info" field field somewhere...

  if (self:get(name)) then -- If module already existed
    self:remove(name)
  end

  self:set(name, module)

  module:include(data.include or {})
  module:enable(true)

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
  smokkkin.logger:info("Loading modules")

  local _, dirs = file.Find(moduleBasePath .. "*", "LUA")

  for _, module in ipairs(dirs) do
    smokkkin.loader:includeSh(moduleBasePath .. module .. "/" .. moduleEntrypoint)
  end

  smokkkin.logger:info("Loaded %s modules", #dirs)
end

smokkkin.module:initialize()
