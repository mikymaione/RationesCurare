select	
	*
from Casse
where
	((@MostraTutte = true) or (Nascondi = 0))
order by
	Nome