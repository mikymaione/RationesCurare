select
	sum(soldi) as Tot,
	Tipo
from Movimenti
group by
	Tipo
order by
	2