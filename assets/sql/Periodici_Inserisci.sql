insert into MovimentiTempo (
	nome,
	tipo,
	descrizione,
	soldi,
	NumeroGiorni,
	GiornoDelMese,
	PartendoDalGiorno,
	Scadenza,
	TipoGiorniMese,
	MacroArea	
) values (
	@nome,
	@tipo,
	@descrizione,
	@soldi,
	@NumeroGiorni,
	@GiornoDelMese,
	@PartendoDalGiorno,
	@Scadenza,
	@TipoGiorniMese,
	@MacroArea	
)