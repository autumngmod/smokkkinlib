---@alias HTTPMethods
---| "GET"
---| "POST"
---| "PUT"
---| "DELETE"
---| "PATCH"

---@class HTTPRequest: Class
---@field url string
---@field method HTTPMethods
---@field headers table
---@field body string
---@field isAlreadySended boolean
---@field callback fun(response: HTTPResponse): nil
local class = smokkkin.class:new("HTTPRequest")

---@param url string
---@param method HTTPMethods
function class:constructor(url, method)
  self.url = url
  self.method = method || "GET"
  self.headers = {}
  self.body = ""
  self.isAlreadySended = false
  self.callback = function() end
end

---@param body table | string
---@return HTTPRequest
function class:setBody(body)
---@diagnostic disable-next-line: assign-type-mismatch
  self.body = type(body) == "table" and util.TableToJSON(body) or body

  return self
end

---@param method HTTPMethods
---@return HTTPRequest
function class:setMethod(method)
  self.method = method

  return self
end

---@param headers table
---@return HTTPRequest
function class:setHeaders(headers)
  self.headers = headers

  return self
end

---@param key string
---@param value any
---@return HTTPRequest
function class:addHeader(key, value)
  self.headers[key] = value

  return self
end

---@param key string
---@return HTTPRequest
function class:removeHeader(key)
  self.headers[key] = nil

  return self
end

---@param callback fun(response: HTTPResponse): nil
---@return HTTPRequest
function class:setCallback(callback)
  self.callback = callback

  return self
end

function class:send()
  if (self.isAlreadySended) then
    return
  end

  smokkkin.http:send(self)
end