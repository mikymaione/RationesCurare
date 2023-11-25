SELECT  	
	sum(m.soldi) as Soldini_TOT 
FROM movimenti m  
where  
	(m.descrizione like @descrizione) and 
	(m.MacroArea like @MacroArea) and
	(m.data between @dataDa and @dataA)