---@alias Header
---| "Content-Type"

---@class Headers
---@field Content-Type? string

---@class HTTPResponse: Class
---@field code number
---@field isErr boolean
---@field error string
---@field body string
---@field headers Headers
local class = smokkkin.class:new("HTTPResponse")

---@param code number | string
---@param body string
---@param headers Headers
function class:constructor(code, body, headers)
---@diagnostic disable-next-line: assign-type-mismatch
  self.code = type(code) == "string" and 400 or code
  self.body = body or ""
  self.headers = headers or {}
  self.isErr = type(code) == "string" or self.code >= 300

  if (self.isErr) then
    self.error = type(code) == "string" and code or self.body
    self:tellAboutError()
  end
end

---@return string
function class:getRawBody()
  return self.body
end

---@return string | table
function class:getBody()
  return self:getContentType() == "application/json" and util.JSONToTable(self.body) or self.body
end

---@return Headers
function class:getHeaders()
  return self.headers
end

---@return string
function class:getContentType()
  return (self.headers["Content-Type"] or ""):Split(";")[1]
end

---@return any?
function class:getHeader(key)
  return self.headers[key]
end

---@return boolean
function class:isError()
  return self.isErr
end

---@return string?
function class:getError()
  return self.error
end

---@return boolean
function class:isClientError()
  return self.code >= 400 and self.code < 500
end

---@return boolean
function class:isServerError()
  return self.code >= 500
end

---@return boolean
function class:isSuccess()
  return self.code >= 200 and self.code < 300
end

---@return boolean
function class:isOk()
  return self.code < 400
end

local possibleSolutions = {
  ["invalid url"] = "You may have forgotten to specify the URL in the request.",
  ["invalid request"] = "Problems with Steam API or connection.",
  ["unsuccessful"] = "You may be trying to make a LAN request without specifying the '-allowlocalhttp' flag.",

  ["Couldn't connect to server"] = "Check your internet connection/check if the site is up and running."
}

possibleSolutions["Timeout was reached"] = possibleSolutions["Couldn't connect to server"]

---@private
function class:tellAboutError()
  smokkkin.logger:error("HTTP Request failed: %s", self.error)

  local solution = possibleSolutions[self.error]

  if (solution) then
    smokkkin.logger:warn("Possible solution: %s", solution)
  end
end