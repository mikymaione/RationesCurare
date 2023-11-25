SELECT  
	Format(m.data, 'yyyy') as Mese, 
	sum(m.soldi) as Soldini_TOT
FROM movimenti m
group by  
	Format(m.data, 'yyyy') 
order by
	1