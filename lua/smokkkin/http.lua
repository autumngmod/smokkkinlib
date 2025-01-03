smokkkin.http = {}

if (!CHTTP && smokkkin.util:requireDynamicLibary("chttp")) then
  return
end

---@class CHTTPRequest
---@field url string
---@field method  HTTPMethods
---@field success fun(code: number, body: string, headers: table)
---@field failed fun(reason: string)
---@field parameters? table
---@field body? string
---@field headers? table
---@field type? string
---@field timeout? integer

---@type fun(requestData: CHTTPRequest): nil
CHTTP = CHTTP

--- Sends a HTTP request to server
---
---@private
---@param request HTTPRequest
function smokkkin.http:send(request)
  CHTTP({
    url = request.url,
    method = request.method,
    success = function(...) request.callback(new("HTTPResponse", ...)) end,
    failed = function(e) request.callback(new("HTTPResponse", e)) end,
    timeout = request.timeout or 10
  })
end