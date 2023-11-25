SELECT 
	*
FROM MovimentiTempo
where
	(GiornoDelMese between @GiornoDa And @GiornoA) or
	(PartendoDalGiorno between @GiornoDa And @GiornoA)