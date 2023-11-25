SELECT 
	m.*,	
	case
		when m.TipoGiorniMese = 'G' then 'Giornaliero'
		when m.TipoGiorniMese = 'M' then 'Mensile'
		when m.TipoGiorniMese = 'B' then 'Bimestrale'
		when m.TipoGiorniMese = 'T' then 'Trimestrale'
		when m.TipoGiorniMese = 'Q' then 'Quadrimestrale'
		when m.TipoGiorniMese = 'S' then 'Semestrale'
		when m.TipoGiorniMese = 'A' then 'Annuale'
		else 'NaN'
	end as Periodo_H
FROM MovimentiTempo m
order by
	m.tipo, m.GiornoDelMese