smokkkin.log = {}

local TRACE = Color(255,255,255)
function smokkkin.log:trace(log, ...)
  self:log(TRACE, "Trace", log:format(...))
end

local DEBUG = Color(255,255,255)
---@param log string
function smokkkin.log:debug(log, ...)
  self:log(DEBUG, "Debug", log:format(...))
end

local INFO = Color(255,255,255)
---@param log string
function smokkkin.log:info(log, ...)
  self:log(INFO, "Info", log:format(...))
end

local WARN = Color(255,255,255)
---@param log string
function smokkkin.log:warn(log, ...)
  self:log(WARN, "Warn", log:format(...))
end

local ERROR = Color(255,255,255)
---@param log string
function smokkkin.log:error(log, ...)
  self:log(ERROR, "Error", log:format(...))
end

local FATAL = Color(255,255,255)
---@param log string
function smokkkin.log:fatal(log, ...)
  self:log(FATAL, "Fatal", log:format(...))
end

---@private
function smokkkin.log:log(prefixColor, prefix, log)
  MsgC(prefixColor, prefix, color_white, " ", log)
  MsgN()
end
