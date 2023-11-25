SELECT
	m.*,
	iif(m.TipoGiorniMese = 'M', Datepart('d', m.GiornoDelMese), null) as GiornoDelMese_H,
	iif(m.TipoGiorniMese = 'G', 'giorni', 'mese') as Periodo_H
FROM MovimentiTempo m
order by
	m.tipo, 
	m.GiornoDelMese
