smokkkin.loader = {}

--- Includes file only on clientside
---
---@param path string Path to the script
---@return string? Returnable content of the script
function smokkkin.loader:includeCl(path)
  if (SERVER) then
    return AddCSLuaFile(path)
  end

  return include(path)
end

smokkkin.loader.client = smokkkin.loader.includeCl

--- Includes file on a both sides
---
---@param path string Path to the script
---@return string Returnable content of the script
function smokkkin.loader:includeSh(path)
  if (SERVER) then
    AddCSLuaFile(path)
  end

  return include(path)
end

smokkkin.loader.shared = smokkkin.loader.includeSh

--- Includes file only on serverside
---
---@param path string
---@return string? Returnable content of the script
function smokkkin.loader:includeSv(path)
  if (SERVER) then
    return include(path)
  end
end

smokkkin.loader.server = smokkkin.loader.includeSv

smokkkin.loader.prefix = {
  cl_ = smokkkin.loader.includeCl,
  sh_ = smokkkin.loader.includeSh,
  sv_ = smokkkin.loader.includeSv
}

--- Includes file and automaticly identifies the side by prefix
---
---@param path string Path to the script
---@return string? Returnable content of the script
function smokkkin.loader:includeAuto(path)
  --- K R A C U B O
  local includer = self.prefix[path:sub(0, 3)]

  if (!includer) then
    error("Invalid file prefix on " .. path)
  end

  return includer(self, path)
end

smokkkin.loader.include = smokkkin.loader.includeAuto

--- Automaticly includes all files in directory, relative to the depth parameter
---
---@param path string Path to the directory
---@param depth? number | 1
---@return table<string, string> Filename = Content
function smokkkin.loader:includeDir(path, depth)
  local result = {}

  local files, dirs = file.Find(path .. "/*", "LUA")

  for _, filename in ipairs(files) do
    local content = self:includeAuto(path .. "/" .. filename)

    if (content) then
      result[filename] = content
    end
  end

  if (depth > 0) then
    for _, dir in ipairs(dirs) do
      self:includeDir(path .. "/" .. dir, depth - 1)
    end
  end

  return result
end
