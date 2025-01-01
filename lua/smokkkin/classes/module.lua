---@class Module: ClassObject
---@field path string Path to the module
---@field base string
---@field hooks table<string, table<string, function>>
local class = smokkkin.class:new("Module")
class.base = "smokkkin/modules/"
class.path = class.base
class.hooks = {}

--- A table contains aliases for the events name
---
--- Example
--- ```lua
--- local class = smokkkin.class:get("Module")
--- class.events["playerDie"] = "PlayerDeath"
--- ````
---
---@type table<string, string>
class.events = {
  playerDie = "PlayerDeath",
  playerSpawn = "PlayerSpawn",
  playerJoined = "PlayerInitialSpawn",
}

---@param name string
function class:constructor(name)
  -- Magic number (stack)
  local moduleDir = debug.getinfo(4)
    .source:match("modules/([^/]+)/") -- yep

  self.name = name
  self.path = self.path .. moduleDir
end

--- Generates unique id for the event listener.
---
---@private
---@param eventId string Id of the event
---@return string
function class:getEventId(eventId)
  return "smokkkin:" .. self.name .. ":" .. eventId
end

function class:getEventName(eventName)
  return self.events[eventName] or eventName
end

--- Enables module: adds hooks, commands etc
---@param log? boolean
function class:enable(log)
  if (log) then
    smokkkin.log:debug("Enabling module %s", self.name)
  end

  self:enableHooks()
  --todo
  --self:enableCommands()

  self:onEnable()
end

function class:enableHooks()
  for eventName, event in pairs(self.hooks) do
    for eventId, callback in pairs(event) do
      hook.Add(self:getEventName(eventName), self:getEventId(eventId), callback)
    end
  end
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
  --todo
  --self:disableCommands()

  self:onDisable()
end

function class:disableHooks()
  for eventName, event in pairs(self.hooks) do
    for eventId in pairs(event) do
      hook.Remove(self:getEventName(eventName), self:getEventId(eventId))
    end
  end
end

--- Adds callback for a event (hook)
--- 
--- @param callback function
--- @param eventName string
--- @param listenerId string
function class:listen(callback, eventName, listenerId)
  local eventTable = self.hooks[eventName]

  if (!eventTable) then
    self.hooks[eventName] = {}
    eventTable = self.hooks[eventName]
  end

  eventTable[listenerId] = callback
end

--- Function, that calls on module disabling
--- Plug function that needed for overriding
function class:onDisable()
end

---@alias State "client" | "shared" | "server"

--- Includes files that associated with module
---
---@param fileList table<State, List<string>>
function class:include(fileList)
  local loader = smokkkin.loader

  for state, files in pairs(fileList) do
    for _, file in ipairs(files) do
      local includer = loader[state]

      includer(loader, self.path .. "/" .. file)
    end
  end  
end

return class
