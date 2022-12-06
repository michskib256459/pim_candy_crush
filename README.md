Projekt zawiera odwzorowanie gry Candy Crush

Aby włączyć apliakcji użyj poniższej komendy
```
flutter run -d chrome --web-port 5000
```

[Trello](https://trello.com/invite/b/Lg2K48P7/ATTIc5298440becb359fd194575e22dbe6012A9BD5C1/to-do)

# Użyte technologie
- Flutter
- Firebase

# Mockupy interfejsów
![img.png](images/mockupy.png)

# Schematy architektury

## Schemat modeli danych
![model_danych.png](images/model_danych.png)

## Diagram przypadków użycia
![przypadki_uzycia.png](images/przypadki_uzycia.png)

# Testy manualne

### Scenariusz 1: Nowy użytkownik loguje się do aplikacji

#### 1.1 Użytkownik jest niezalogowany
![img.png](images/s1.1.png)
#### 1.2 W bazie danych nie ma żadnych rekordów
![img_1.png](images/s1.2.png)
#### 1.3 Użytkownik się loguje
![img_2.png](images/s1.3.png)
#### 1.4 Lista leveli wyświetla się dla użytkownika poprawnie
![img_3.png](images/s1.4.png)
#### 1.5 Rekordy w bazie danych zostały utworzone
![img_4.png](images/s1.5.png)

### Scenariusz 2: Użytkownik zalicza poziom na większą liczbę gwiazdek niż miał wcześniej
#### 2.1 Użytkownik zaliczył poziom na większą liczbę gwiazdek niż miał wcześniej
![img.png](images/s2.1.png)
#### 2.2 Widok się automatycznie odświeżył: pojawił się nowy wynik i następny level został odblokowany
![img_1.png](images/s2.2.png)
#### 2.3 Rekordy w bazie danych zostały zaktualziowane
![img_2.png](images/s2.3.1.png)

![img.png](images/s2.3.2.png)


### Scenariusz 3: Użytkownik zalicza poziom na mniejszą lub równą liczbę gwiazdek niż miał wcześniej
#### 3.1 Użytkownik ma zaliczony poziom na 0 gwiazdek
![img.png](images/s3.1.png)
#### 3.2 Użytkownik zaliczył poziom na 0 gwiazdek(mniej niż 5 pkt)
![img_1.png](images/s3.2.png)
#### 3.3 Widok się nie odświeżył: level drugi nadal jest zaliczony na zero gwiazdek, a następny level nie został odblokowany
![img_2.png](images/s3.3.png)
#### 3.4 Rekordy w bazie danych zostały zaktualziowane
![img_3.png](images/s3.4.1.png)

![img_4.png](images/s3.4.2.png)
