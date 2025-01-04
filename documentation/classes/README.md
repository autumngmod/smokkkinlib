# Классы
Луа - ООП язык, конечно классов в привычном понимании (как в Java, C++, JavaScript, и так далее) нет,\
зато есть мета-таблицы. Формально мета-таблицы заменяют нужду в классах,\
но они не являются удобными, так как непривычны и работают не так\
интуитивно понятно как могло бы быть.\

Наша библиотека частично решает эту проблему, добавляя систему классов.\
Безусловно, она не решает все проблемы связанные с ООП в Луа, но\
в разы облегчает написание и понимание кода.

# Устройство
Все классы представляют собой мета-таблицу, на базе которой создаются объекты - инстансы класса.\

# Создание класса
Чтобы создать свой класс достаточно создать один файл в папке ``smokkkinlib/lua/smokkkin/classes``.\

Для примера создадим класс с названием ``Human``.\
В папке с классами создадим файл ``human.lua``, и впишем в него следующее содержимое:
```lua
--- Класс Human наследуется от общего класса Class
---@class Human: Class
local class = smokkkin.class:new("Human")
class.defaultName = "George" -- Static variable

--- Метод constructor вызывается всего один раз,
--- при инициализации объекта.
--- @param name? string
function class:constructor(name)
  self.name = name or self.defaultName -- George will be default name of Human
end

---@return name
function class:getName()
  return self.name
end
```

# Использование
Чтобы создать экземпляр (инстанс) класса достаточно использовать функцию ``new``.

> [!TIP]
> Функция ``new`` является алиасом\
> (синтаксическим сахаром) функции ``smokkkin.class.createInstance``

```lua
local george = new "Human"
print(george:getName()) -- George

local matthew = new("Human", "Matthew")
print(matthew:getName()) -- Matthew
```