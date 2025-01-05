# Network
smokkkinlib предоставляет библиотеку для удобного\
менеджмента network сообщениями.

# Устройство

## Поддерживаемые типы
* ``i8`` - (+ -) Integer 8 bit
* ``i16`` - (+ -) Integer 16 bit
* ``i32`` - (+ -) Integer 32 bit
* ``u8`` - (+) Unsigned Integer 8 bit
* ``u16`` - (+) Unsigned Integer 16 bit
* ``u32`` - (+) Unsigned Integer 32 bit
* ``u64`` - (+) Unsigned Integer 64 bit
* ``angle`` - Angle
* ``vector`` - Vector
* ``bit`` - Bit
* ``color`` - Color
* ``data`` - Binary data
* ``entity`` - Entity
* ``player`` - Player
* ``string`` - String
* ``bool`` - Boolean
* ``table`` - Table

# Пример
```lua
--- smokkkin.network:register(name: string, {
---   send = {
---     key = "type"
---   },
---   reply? = {}
--- })

--- Метод, как util.AddNetworkString
if (SERVER) then
  smokkkin.network:register("example", {
    send = {
      steamid = "string",
      money = "u64"
    },
    reply = {
      isSuccess = "boolean"
    }
  })

  smokkkin.network:receive(function(message)
    local data = message:getData()

    print(data.isSuccess)
  end, "example")

  smokkkin.network:send({
    name = "example",
    receiver = Player(1),
    content = {
      steamid = Player(1):SteamID()
      money = 6000
    }
  })
else
  smokkkin.network:receive(function(message)
    local data = message:getData()

    print(data.steamid, data.money)

    message:reply({
      isSuccess = true
    })
  end, "example")
end
```