use s13898

select * from Gosc;
select * from Rezerwacja;

-- zadanie 1

CREATE PROCEDURE add_guest 
	@Imie VARCHAR(30),
	@Nazwisko VARCHAR(30),
	@Procent_rabatu INT
AS 
BEGIN
  IF EXISTS (SELECT 1 FROM Gosc WHERE Imie=@Imie AND Nazwisko=@Nazwisko)
  PRINT 'Taka osoba już istnieje!'
  ELSE
  BEGIN
    INSERT INTO Gosc(IdGosc, Imie, Nazwisko, Procent_rabatu)
    SELECT isnull(MAX(IdGosc), 0)+1, @Imie, @Nazwisko, @Procent_rabatu FROM Gosc  
    PRINT 'Dodano osobę! '+@Imie+' '+ @Nazwisko
  END
END

EXECUTE add_guest'aa', 'bbb', 12;

-- zadanie 2

CREATE PROCEDURE add_user_with_reservation
	@IdGosc INT, 
	@Imie VARCHAR(30),
	@Nazwisko VARCHAR(30),
	@Procent_rabatu INT,
	@DataOd DATETIME,
	@DataDo DATETIME,
	@NrPokoju INT,
	@Zaplacona BIT	
AS 
BEGIN
  IF EXISTS (SELECT 1 FROM Gosc, Rezerwacja WHERE Imie=@Imie AND Nazwisko=@Nazwisko )
  PRINT 'Taka osoba już jest'
  ELSE
  BEGIN
    INSERT INTO Gosc (IdGosc, Imie, Nazwisko, Procent_rabatu) 
    SELECT isnull(MAX(IdGosc), 0)+1, @Imie, @Nazwisko, @Procent_rabatu FROM Gosc
	INSERT INTO Rezerwacja (IdRezerwacja, DataDo, DataDo, IdGosc, NrPokoju, Zaplacona)
	SELECT isnull(MAX(IdRezerwacja), 0)+1, @DataOd, @DataDo, @IdGosc, @NrPokoju FROM Rezerwacja
    PRINT 'Dodano osobę '+@Imie+' '+ @Nazwisko + 'id rezerwacji ' + @idReservation;
  END
END

-- zadanie 3

CREATE PROCEDURE dokonaj_rezerwacjigosc
@idgosc INT,
@nrpokoj INT,
@dataod DATETIME,
@datado DATETIME
AS BEGIN
	DECLARE 
	@idr INT,
	@zajety INT                                                                                       
	SELECT @idr = (Max(IdRezerwacja)+1) From Rezerwacja                                                                                                                                                                                                                                                                                                                                               
	SELECT @zajety = COUNT(*) FROM Rezerwacja WHERE @nrpokoj = NrPokoju AND @dataod Between DataOd AND DataDo  
	IF @zajety=0
		begin
		INSERT INTO Rezerwacja (IdRezerwacja,IdGosc,DataOd,DataDo,NrPokoju,Zaplacona)
		VALUES (@idr,@idgosc,@dataod,@datado,@nrpokoj,0)
		PRINT 'Zarezerwowano pokoj'
		end
	ELSE
		PRINT 'Pokoj jest juz zajety'
END

execute dokonaj_rezerwacjigosc '1','101','2017-10-14','2017-10-15';
select * from Rezerwacja

-- zadnaie 4

CREATE PROCEDURE dodaj_rabat
@idGosc INT
AS BEGIN
	DECLARE @ile INT, @Procent_rabatu INT
	SELECT @ile = COUNT(*) FROM Rezerwacja WHERE @idGosc=IdGosc AND Zaplacona>0
	IF @ile>2
		SELECT @Procent_rabatu = COUNT(*) FROM Gosc Where Procent_rabatu>10
			IF @Procent_rabatu>10
			BEGIN
				UPDATE Gosc
			SET Procent_rabatu=Procent_rabatu+2
			END

				ELSE

			BEGIN
				UPDATE Gosc
				SET Procent_rabatu=10
			END
END

