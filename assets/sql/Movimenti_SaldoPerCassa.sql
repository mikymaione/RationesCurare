select
	sum(m.soldi) as Tot,
	COALESCE(c.Nome, m.Tipo) as Cassa
from Movimenti m
left outer join Casse c on
	c.Nome = m.Tipo
group by
	COALESCE(c.Nome, m.Tipo)
order by
	2