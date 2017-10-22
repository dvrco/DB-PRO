
SELECT IdGosc, COUNT (IdGosc) 
FROM Rezerwacja Group by IdGosc Having COUNT(IdGosc) > 1;

SELECT NrPokoju, Liczba_miejsc FROM Pokoj 
	WHERE Liczba_miejsc = (Select MAX(Liczba_miejsc) FROM Pokoj);

SELECT NrPokoju, DataOd, DataDo FROM Rezerwacja r1 WHERE r1.DataDo = (SELECT MAX(DataDO) FROM Rezerwacja r2 WHERE r2.NrPokoju = r1.NrPokoju);

SELECT Rezerwacja.NrPokoju, COUNT (*) as 'Liczba rezerwacji' 
FROM Rezerwacja, Pokoj, Kategoria 
WHERE Rezerwacja.NrPokoju = Pokoj.NrPokoju 
		AND Pokoj.IdKategoria = Kategoria.IdKategoria 
		AND Kategoria.Nazwa 
		NOT LIKE 'luksusowy'
GROUP BY Rezerwacja.NrPokoju;

SELECT Gosc.Imie, Gosc.Nazwisko, Rezerwacja.NrPokoju
FROM Gosc, Rezerwacja
WHERE Gosc.IdGosc = Rezerwacja.IdGosc 
		AND Rezerwacja.DataDo = ( SELECT MAX(DataDo) From Rezerwacja);

SELECT Pokoj.NrPokoju, Pokoj.Liczba_miejsc, Pokoj.IdKategoria
FROM Pokoj, Rezerwacja
WHERE Pokoj.NrPokoju = Rezerwacja.NrPokoju 
		AND DataDo IS NULL; 

SELECT Gosc.IdGosc, Gosc.Imie, Gosc.Nazwisko 
	FROM Gosc, Pokoj, Rezerwacja
	WHERE  NOT EXISTS (SELECT Gosc.IdGosc, Gosc.Imie, Gosc.Nazwisko FROM Gosc); 

