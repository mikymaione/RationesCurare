update MovimentiTempo set
	nome = @nome,
	tipo = @tipo,
	descrizione = @descrizione,
	soldi = @soldi,
	NumeroGiorni = @NumeroGiorni,
	GiornoDelMese = @GiornoDelMese,
	PartendoDalGiorno = @PartendoDalGiorno,
	Scadenza = @Scadenza,
	TipoGiorniMese = @TipoGiorniMese,
	MacroArea = @MacroArea	
where
	ID = @ID