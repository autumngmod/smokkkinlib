smokkkin.util = {}

--- Reads JSON file from /data/, and returns its content as Lua table
---
---@param path string
function smokkkin.util:readJsonFile(path)
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

    return false
  end

  require(name)
end