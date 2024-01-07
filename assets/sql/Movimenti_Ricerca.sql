select
	m.*,
	coalesce(c.Nome, m.tipo) as Cassa
from Movimenti m
left outer join Casse c on
	c.Nome = m.Tipo
where
	(('Saldo' = @tipo1) or (m.tipo = @tipo2)) and
	(m.descrizione like @descrizione) and
	(m.MacroArea like @MacroArea) and
	((false = @bSoldi) or (m.soldi between @SoldiDa and @SoldiA)) and
	((false = @bData) or (m.data between @DataDa and @DataA))
order by
	m.data desc