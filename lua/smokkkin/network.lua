smokkkin.network = smokkkin.network or {
  strings = {},
  receivers = {},
  --- Damn
  types = {
    ["string"] = {net.WriteString, net.ReadString},
    --- Numbers
    ["i8"] = {function(x) net.WriteInt(x, 8) end, function() return net.ReadInt(8) end},
    ["i16"] = {function(x) net.WriteInt(x, 16) end, function() return net.ReadInt(16) end},
    ["i32"] = {function(x) net.WriteInt(x, 32) end, function() return net.ReadInt(32) end},
    ["u8"] = {function(x) net.WriteUInt(x, 8) end, function() return net.ReadUInt(8) end},
    ["u16"] = {function(x) net.WriteUInt(x, 16) end, function() return net.ReadUInt(16) end},
    ["u32"] = {function(x) net.WriteUInt(x, 32) end, function() return net.ReadUInt(32) end},
    ["u64"] = {function(x) net.WriteUInt64(x) end, function() return net.ReadUInt64() end},
    --- Other
    ["angle"] = {net.WriteAngle, net.ReadAngle},
    ["vector"] = {net.WriteVector, net.ReadVector},
    ["bit"] = {net.WriteBit, net.ReadBit},
    ["boolean"] = {net.WriteBool, net.ReadBool},
    ["color"] = {net.WriteColor, net.ReadColor},
    ["data"] = {net.WriteData, net.ReadData},
    ["entity"] = {net.WriteEntity, net.ReadEntity},
    ["player"] = {net.WritePlayer, net.ReadPlayer},
    ["table"] = {net.WriteTable, net.ReadTable}
  }
}

if (SERVER) then
  util.AddNetworkString("smokkkin")
end

--- Caching NetworkMessage
smokkkin.class:get("NetworkMessage")

---@private
---@param name string
---@param action? string
function smokkkin.network:getStrings(name, action)
  return self.strings[name][action or "send"]
end

---@private
---@class NetworkString
---@field key string
---@field type "string" | "i8" | "i16" | "i32" | "u8" | "u16" | "u32" | "u64" | "angle" | "vector" | "bit" | "bool" | "color" | "entity" | "player"

---@private
---@class NetworkStringProvider
---@field send NetworkString[]
---@field reply? NetworkString[]

--- Registeres template for the messages
---
---@param name string
---@param strings NetworkStringProvider 
function smokkkin.network:register(name, strings)
  self.strings[name] = strings
end

--- Registeres a network string listener
---
---@param callback fun(message: NetworkMessage): nil
---@param name string
function smokkkin.network:receive(callback, name)
  self.receivers[name] = callback
end

---@private
---@class NetworkSendArguments
---@field name string
---@field id? string
---@field receiver? Player
---@field isReply? boolean
---@field content? table<string, any>

--- Sends a network message
---
---@param data NetworkSendArguments
function smokkkin.network:send(data)
  data.id = data.id or self:generateUniqueId()
  data.isReply = data.isReply or false
  data.content = data.content or {}

  local strings = self:getStrings(data.name, data.isReply and "reply" or "send")

  net.Start("smokkkin")
  net.WriteString(data.id)
  net.WriteString(data.name)
  net.WriteBool(data.isReply)

  for _, string in ipairs(strings) do
    local write = self.types[string.type][1]

    write(data.content[string.key])
  end

  net[SERVER and "Send" or "SendToServer"](data.receiver)
end

---@private
---@return string MD5 Id
function smokkkin.network:generateUniqueId()
  return util.MD5("network:" .. os.time() .. ":" .. math.random(0, 100))
end

---@private
---@param name string
---@param message NetworkMessage
function smokkkin.network:incoming(name, message)
  local receiver = self.receivers[name]

  if (!receiver) then
    return
  end

  receiver(message)
end

net.Receive("smokkkin", function(len, pl)
  local id = net.ReadString()
  local name = net.ReadString()
  local isReply = net.ReadBool()
  local message = new("NetworkMessage", len, pl, id, name, isReply)

  smokkkin.network:incoming(name, message)
end)
