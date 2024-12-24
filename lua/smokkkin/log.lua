smokkkin.log = {}

local TRACE = Color(255, 0, 255)
function smokkkin.log:trace(log, ...)
  self:log(TRACE, "TRACE", log:format(...))
end

local DEBUG = Color(0, 102, 255)
---@param log string
function smokkkin.log:debug(log, ...)
  self:log(DEBUG, "DEBUG", log:format(...))
end

local INFO = Color(0, 204, 102)
---@param log string
function smokkkin.log:info(log, ...)
  self:log(INFO, "INFO", log:format(...))
end

local WARN = Color(255, 153, 0)
---@param log string
function smokkkin.log:warn(log, ...)
  self:log(WARN, "WARN", log:format(...))
end

local ERROR = Color(255, 0, 0)
---@param log string
function smokkkin.log:error(log, ...)
  self:log(ERROR, "ERROR", log:format(...))
end

local FATAL = Color(128, 0, 0)
---@param log string
function smokkkin.log:fatal(log, ...)
  self:log(FATAL, "FATAL", log:format(...))
end

---@private
function smokkkin.log:log(prefixColor, prefix, log)
  local currentTime = os.date(smokkkin.config.timeFormat, os.time())

  MsgC(prefixColor, "[" .. currentTime .. " " .. prefix .. "]", color_white, " ", log)
  MsgN()
end
