select
	*
from Calendario 
where
	Giorno between @GiornoDa And @GiornoA
order by
	Giorno, 
	Descrizione