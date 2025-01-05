# Logger (Class)
Logger - вспомогательный класс, который нужен для более унифицированного\
логгирования в консоли.

Сам лог представляет собой текст вида ``[TIME LOG_LEVEL MODULE_NAME] FORMATTED MESSAGE``
# Использование
Каждый метод ``Logger`` принимает в себя [vararg](https://www.lua.org/pil/5.2.html).\
Первый аргумент всегда должен быть строкой с текстом сообщения.
Первый аргумент - строка, форматируется, вставляя в себя аргументы из vararg.

## Пример
```lua
local logger = smokkkin.logger

logger:info("Example values: %s, %s, %s", "Hello", 4, 2) -- Example values: Hello, 4, 2
```

## Модули

В каждом модуле есть собственный инстанс Logger'а\
который задается ещё на этапе создания инстанса модуля.\
Доступ к нему можно получить через ``module.logger``.

### Пример
```lua
---@class TestModule: Module
local module = smokkkin.module:get("test")

---@param player Player
function module:kill(player)
  player:Kill()

  self.logger:info("Player %s was killed", player:Nick())
end

---@param player Player
module:listen(function(player)
  module.logger:info("Player %s has joined our server", player)
end, "playerJoined", "testHook")
```

## Инстанс Logger в библиотеке
Доступ к нему можно получить через ``smokkkin.logger``.
```lua
smokkkin.logger:info("Hello")

smokkkin.logger:fatal("ur mom is gay")
```

# Методы
```lua
local logger = smokkkin.logger

logger:trace("Yo")
logger:debug("Yo")
logger:info("Yo")
logger:warn("Yo")
logger:error("Yo")
logger:fatal("Yo")
```