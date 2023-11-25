select distinct
	MacroArea,
	descrizione
from Movimenti
where
	MacroArea <> ''
order by
	1, 2