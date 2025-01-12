---@class WebView: Class
local class = smokkkin.class:new("WebView")
class.panel = NULL
class.jsEventCode = [[
  window.dispatchEvent(new CustomEvent("luaMessage", {
    type: "%s",
    body: %s
  }))
]]

function class:constructor()
  ---@class WebViewPanel: DHTML
  ---@diagnostic disable-next-line: assign-type-mismatch
  self.panel = vgui.Create("DPanel")

  self.panel.OnScreenSizeChanged = function()
    self:onScreenChanged()
  end

  self:onScreenChanged()
end

function class:onScreenChanged()
  self.panel:SetSize(ScrW(), ScrH())
end

---@param url string
function class:setUrl(url)
  self.panel:SetURL(url)
end

--- Adds function into JavaScript
---
---@param name string
function class:define(name, callback)
  self.panel:AddFunction("lua", name, callback)
end

--- Send event to JavaScript side.
--- Spends a lot of resources, so it's not adviced to send too many
--- events in a smoll amount of time
---
---@param name string Name of event
---@generic T
---@param payload T | table
function class:sendEvent(name, payload)
  self.panel:RunJavascript(
    self.jsEventCode:format(name, util.TableToJSON(payload))
  )
end
