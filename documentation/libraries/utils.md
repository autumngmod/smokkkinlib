# Utils

## ``readJsonFile(path: string)``
```lua
local data = smokkkin.util:readJsonFile("admins.json") -- Reads and parses file GarrysModDS/garrysmod/data/admins.json

PrintTable(data)
```

## ``requireDynamicLibrary(name: string): true | nil``
```lua
--- Если CHTTP не является глобальной переменной
--- то тогда мы загружаем DLL chttp
---
--- Но если она не будет установлена
--- то в консоль выведеться сообщение об этом,
--- а также метод вернет ``true``.
if (!CHTTP && !smokkkin.util:requireDynamicLibary("chttp")) then
  return
end
```