smokkkin.util = {}

--- Reads JSON file from /data/, and returns its content as Lua table
---
---@param path string
---@return table | false
function smokkkin.util:readJsonFile(path)
  if (!file.Exists(path, "DATA")) then
    return false
  end

  local content = file.Read(path, "DATA")

  return util.JSONToTable(content)
end

--- Loads
---
---@param name string
---@return any
function smokkkin.util:requireDynamicLibary(name)
  if (!util.IsBinaryModuleInstalled(name)) then
    smokkkin.logger:fatal("Failed to load the %s dynamic module.", name)

    return true
  end

  require(name)
end