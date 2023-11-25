select
	count(*) as Tot
from Movimenti
where
	tipo = @tipo