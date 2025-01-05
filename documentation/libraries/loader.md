# Loader
Loader (``smokkkin.loader``) это вспомогательная библиотека, нужная для удобного\
менеджмента скриптовыми файлами и их зависимостями.

| Method name | Load on the client | Load on the server |
| ----------- | ------------------ | ------------------ |
| ``includeCl`` | ✅ | ⛔️ |
| ``includeSh`` | ✅ | ✅ |
| ``includeSv`` | ⛔️ | ✅ |

# Использование
```lua
local config = smokkkin.loader:includeSh("smokkkin/module/test/config.lua")

PrintTable(config)
```
```lua
local keys = smokkkin.loader:includeSv("smokkkin/module/test/config/keys.lua")

PrintTable(keys["steam_api_key"])
```