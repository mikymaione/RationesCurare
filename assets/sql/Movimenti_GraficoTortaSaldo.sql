SELECT  	
	sum(m.soldi) as Soldini_TOT 
FROM movimenti m  
where
	((0 = @sPos) or (((1 = @sPos) or (m.soldi < 0)) and ((-1 = @sPos) or (m.soldi > 0)))) and
	(m.data between @dataDa and @dataA)