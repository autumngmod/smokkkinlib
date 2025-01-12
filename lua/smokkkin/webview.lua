--- Webview library
smokkkin.webview = {
  ---@type WebView[]
  list = {}
}

---@param name string Name/Id of panel
---@return WebView | nil
function smokkkin.webview:get(name)
  return self.list[name]
end

--- Creates new WebView panel
---
---@param name string Name/Id of panel
---@param url string | nil
function smokkkin.webview:new(name, url)
  local webview = new("WebView", url)

  self.list[name] = webview

  return webview
end
