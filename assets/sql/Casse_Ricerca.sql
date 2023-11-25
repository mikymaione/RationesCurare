select	
	*
from Casse
where
	((@MostraTutte = 1) or (Nascondi = 0))
order by
	Nome