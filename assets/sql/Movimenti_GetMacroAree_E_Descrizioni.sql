select distinct
	MacroArea
from Movimenti
where
	descrizione = @descrizione
order by
	1
limit 1