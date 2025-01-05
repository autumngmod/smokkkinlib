# HTTP
smokkkinlib предоставляет библиотеку для удобного использования HTTP\
и составления HTTP/HTTPS запросов.

# HTTPRequest
Отправка HTTP запроса производится через [класс](/documentation/classes/README.md) ``HTTPRequest``.\
HTTPRequest представляет собой билдер HTTP запроса, в который\
можно удобно засовывать необходимые хэдеры/методы/тело запроса и так далее.

## Использование
Базовое использование
```lua
--- Данный пример отправляет HTTP GET запрос
--- на URL google.com, и когда он возвращает ответ
--- выводит в консоль содержимое (тело) ответа.
local request = new("HTTPRequest", "https://google.com")
request:setCallback(function(response)
  print(response:getRawBody())
end)
request:send()
```
Более обширное описание методов класса
```lua
--- Второй аргумент в "new" является необязательным.
--- По умолчанию он имеет значение GET
new("HTTPRequest", "https://jsonplaceholder.typicode.com/todos/1", "GET")
  :setMethod("POST") -- Перезаписываем метод
  :addHeader("Authorization", "Basic tokenForExample")
  :setCallback(function(response)
    print(response:getBody()) -- table 0x00000000
    PrintTable(response:getBody()) -- prints table
  end)
  :send()
```

# HTTPResponse
HTTPResponse это класс, который нужен для более\
удобной обработки/использования ответа от HTTP запроса.\

> [!NOTE]
> ``INTERNAL`` Класс не подразумевает то, что
> вы будете создавать его сами.

## Использование
```lua
--- Переменная response является инстансом HTTPResponse
request:setCallback(function(response))
  if (response:isError()) then
    --                >= 400 and < 500
    return print(response:isClientError() and "Client Error" or "Server Error")
  end

  local body = response:getBody()
  print(type(body)) -- If response has header "Content-Type" setted to "application/json", body will be presented as Lua table

  if (type(body) == "table") then
    PrintTable(body)
  end

  print(body:getRawBody()) -- Returns body as text

  print(body:getContentType()) -- Returns content-type "%s/%s"

  PrintTable(body:getHeaders())
end
```