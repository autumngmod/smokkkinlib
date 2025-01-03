---@class NetworkMessage: Class
---@field length integer
---@field sender Player
---@field id string
---@field name string
---@field isReply boolean
---@field data table<string, any>
local class = smokkkin.class:new("NetworkMessage")

---@param len integer
---@param sender Player
---@param id string
---@param name string
---@param isReply boolean
function class:constructor(len, sender, id, name, isReply)
  self.length = len
  self.sender = sender
  self.id = id
  self.name = name
  self.isReply = isReply

  self.data = self:readData()
end

---@private
---@return table<string, any>
function class:readData()
  local data = {}
  local cache = smokkkin.network.strings[self.name]

  local strings = smokkkin.network.strings[self.name][self.isReply and "reply" or "send"]

  if (!strings) then
    return data
  end

  for _, string in ipairs(strings) do
    local read = smokkkin.network.types[string.type][2]
    data[string.key] = read()
  end

  return data
end

---@return table<string, any>
function class:getData()
  return self.data
end

---@return Player Sender
function class:getSender()
  return self.sender
end

---@return integer Length
function class:getLength()
  return self.length
end

---@return string Message id
function class:getId()
  return self.id
end

---@return string Message name
function class:getName()
  return self.name
end

---@param data NetworkSendArguments
function class:reply(data)
  smokkkin.network:send({
    name = self.name,
    id = self.id,
    isReply = true,
    content = data
  })
end
