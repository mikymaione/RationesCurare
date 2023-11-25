select distinct
	descrizione
from Movimenti
where
	(('FALSE' = @MacroArea) or (MacroArea = '' or MacroArea is null))
order by
	1