# Шаблон курсовой работы 22 кафедры МИФИ

## Ссылка на авторов

### [gitlab.com/skibcsit/thesis-template](https://gitlab.com/skibcsit/thesis-template)

## Компиляция

### Локально

1. **Установите Docker**
   - Для Mac или Windows: установите через Docker Desktop.
   - Для Linux: найдите инструкцию установки для вашей версии Linux.

2. **Запустите Docker**

3. **Выполните в папке проекта**
   ```
   docker compose up
   ```
   Результирующие файлы будут в папке `build`.

4. **Примечание**
   Docker контейнер занимает около 3.5 ГБ и устанавливается до 10 минут. Учитывайте это при планировании места на диске.

5. **Исправление ошибок**
   При ошибке во время работы `docker compose`, читайте логи. Очистите кеш контейнера командой:
   ```
   docker compose up --force-recreate
   ```

### Через GitHub Actions

При пуше в GitHub репозиторий запустится пайплайн, создающий zip-архив с pdf. Архив будет залит как артефакт работы пайплайна.

### Через GitLab CI/CD

Аналогично GitHub Actions.

## Изменение шаблона

1. **Титульный лист**: `title/title.tex`
   - Замените "Ваша тема" на тему вашей курсовой.
   - Обновите информацию о группе и участниках.

2. **Содержание проекта**: `chapters/_content.tex`
   - Добавляйте новые главы с помощью команды `\input{chapters/your-chapter-file.tex}`.
   - Для отображения Антиплагиата, разместите его отчет в предусмотренном месте.

3. **Добавление ссылок**: `chapters/biblio.bib`
   - Используйте стандартный формат BibTeX для добавления ссылок.
   - Для получения BibTeX записей из Google Scholar, найдите нужную публикацию, нажмите на ссылку “Цитировать” под ней и выберите “BibTeX”.

4. **Добавление картинок**
   - Разместите изображения в папке `images`.
   - Вставляйте в текст с помощью команды `\includegraphics{path/to/your/image}`.

5. **Добавление кода**
   - Используйте пакет `listings` для добавления кода.
   - Вставляйте код с помощью команды `\begin{lstlisting} ... \end{lstlisting}`.

6. **Добавление приложений**
   - Приложения находятся в `chapters/thesis-template-appendix*.tex`.
   - Для добавления нового приложения создайте файл в этой папке и подключите его с помощью `\input{chapters/your-appendix-file.tex}` в конце документа.

7. **Структура проекта**
   - Введение: `chapters/thesis-template-intro.tex`
   - Главы: `chapters/thesis-template-chapter*.tex`
   - Заключение: `chapters/thesis-template-conclusion.tex`
   - Приложения: `chapters/thesis-template-appendix*.tex`
