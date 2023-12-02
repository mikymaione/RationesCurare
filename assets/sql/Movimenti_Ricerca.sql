select
	*
from Movimenti
where
	(('Saldo' = @tipo1) or (tipo = @tipo2)) and
	(descrizione like @descrizione) and
	(MacroArea like @MacroArea) and	
	((false = @bSoldi) or (soldi between @SoldiDa and @SoldiA)) and
	((false = @bData) or (data between @DataDa and @DataA))
order by
	data desc