---@class Logger: Class
local class = smokkkin.class:new("Logger")

---@param name string
function class:constructor(name)
  self.name = name
  self.counter = 0
end

local TRACE = Color(255, 0, 255)
---@param log string
---@vararg ... string | number
function class:trace(log, ...)
  self:log(TRACE, "TRACE", log:format(...))
end

local DEBUG = Color(0, 102, 255)
---@param log string
---@vararg ... string | number
function class:debug(log, ...)
  self:log(DEBUG, "DEBUG", log:format(...))
end

local INFO = Color(0, 204, 102)
---@param log string
---@vararg ... string | number
function class:info(log, ...)
  self:log(INFO, "INFO", log:format(...))
end

local WARN = Color(255, 153, 0)
---@param log string
---@vararg ... string | number
function class:warn(log, ...)
  self:log(WARN, "WARN", log:format(...))
end

local ERROR = Color(255, 0, 0)
---@param log string
---@vararg ... string | number
function class:error(log, ...)
  self:log(ERROR, "ERROR", log:format(...))
end

local FATAL = Color(200, 0, 0)
---@param log string
---@vararg ... string | number
function class:fatal(log, ...)
  self:log(FATAL, "FATAL", log:format(...))
end

---@return integer
function class:getLogCount()
  return self.counter
end

--- Returns formatted time
---
---@private
---@return string Time
function class:getTime()
---@diagnostic disable-next-line: return-type-mismatch
  return os.date(smokkkin.config.timeFormat, os.time())
end

local pattern = "[%s %s %s] "
---@private
---@param color Color Prefix color
---@param prefix string
---@param msg any
function class:log(color, prefix, msg)
  local time = self:getTime()

  MsgC(color, pattern:format(time, prefix, self.name), color_white, msg)
  MsgN()

  self.counter = self.counter + 1
end
