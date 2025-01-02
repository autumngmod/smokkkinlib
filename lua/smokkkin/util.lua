smokkkin.util = {}

--- Reads JSON file from /data/, and returns its content as Lua table
---
---@param path string
function smokkkin.util:readJsonFile(path)
  local content = file.Read(path, "DATA")

  return util.JSONToTable(content)
end
