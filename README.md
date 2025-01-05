# smokkkinlib
smokkkkinlib (smokkkin) - Lua библиотека для игры Garry's Mod.\
Она представляет собой сборище библиотек, которые дополняют/улучшают функционал\
для скриптинга в игре.

# Установка
## Git CLI
Выполните эту команду в папке (pwd) ``GarrysModDS/garrysmod/addons``

```bash
git clone https://github.com/autumngmod/smokkkinlib
```
## Manual
На главной странице проекта нажмите кнопку "Code",\
и в выпавшем списке выберите кнопку "Download ZIP".\
Затем распакуйте архив в ``GarrysModDS/garrysmod/addons``.

# Документация
* Основы
  * [Код стайл](/documentation/basics/code-style.md)
  * [Настройка Lua Language Server](/documentation/basics/lua-ls.md)
* Классы
  * [Общие сведения](/documentation/classes/README.md)
* Модули
  * [Общие сведения](/documentation/classes/README.md)
* Библиотеки
  * [Class](/documentation/classes/README.md)
  * [HTTP](/documentation/libraries/http.md)
  * [Loader](/documentation/libraries/loader.md)
  * [Logger](/documentation/classes/logger.md)
  * [Module](/documentation/modules/README.md)
  * [Network (based on ``net.*``)](/documentation/libraries/network.md)
  * [Utils](/documentation/libraries/utils.md)

# Советы
* Используйте [Lua Language Server]() (работает во всех редакторах, поддерживающих Language Serverы - VSCode, Neovim, Sublime Text и так далее)

# Использование
Библиотеку можно использовать как обособленно в своих скриптах,\
так и писать встроенные в библиотеку [модули](/documentation/modules/README.md).