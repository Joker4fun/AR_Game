
## Main Stack :
- Swift 
- Core Data
- Core Location
- User Defaults 

## Screenshots

  ![Снимок экрана 2023-07-01 в 17 00 48](https://github.com/Joker4fun/AR_Game/assets/33445216/56b7512d-118c-4d57-83f4-87505e3cdda3)


## Introduction:
This is a simple application similar to the Pokemon Go game.
The main screen is a map screen with monsters within a radius of 1km from the player's current position. The app keeps track of the current location all the time and updates the list of monsters on the map and their labels.
All monsters in the area of level 5-25 are randomly generated. When catching a monster, experience is awarded. The essence of the game is pumping the character and catching new monsters.

**Основные сущности**
```
- Основные сущности это: Доходы, Графики и Расходы.
- Есть возможность построения графика платежей
- Есть статистика в виде графиков по всем движениям средств
```

**Доходы**
```
Главный экран приложения.
В верхнем правом углу отображается строка с "Балансом всех средств"
В нижней части экрана распологается кнопка "Добавить доход", по нажаматию на которую - можно увеличить текущий баланс средств
```

**Графики**


![Снимок экрана 2023-07-01 в 17 00 48](https://github.com/Joker4fun/MyFinance/assets/33445216/542edcc9-c6d1-4e3b-aafd-cb26941b00a9)


```
Категория необходима для структурирования транзакций, а также для наглядной статистики по расходам и доходам. 
```

**Расходы**
```
Экран со списком "Категорий рассходов" (Дом, Машина, ЖКХ), есть возможностью добавить новую категории расходов, удалить категорию и просмотреть записи по каждой из них.
```

**Категория расходов**
```
Экран со списком внесенных затрат. 
Пример: Категория "Дом", в ней список трат - 
- Шторы 25.10.22 350 Р
- Чашка 23.10.22 150 Р
- Кровать 21.10.22 22999 Р

Есть возможность добавить новый расход, удалить старый и просмотреть все статистику трат на графике.

```
