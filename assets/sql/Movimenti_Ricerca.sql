select
	*
from Movimenti
where
	(('Saldo' = @tipo) or (tipo = @tipo)) and
	(descrizione like @descrizione) and
	(MacroArea like @MacroArea) and	
	((0 = @bSoldi) or (soldi between @SoldiDa and @SoldiA)) and
	((0 = @bData) or (data between @DataDa and @DataA))
order by
	data desc