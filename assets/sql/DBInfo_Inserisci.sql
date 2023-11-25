insert into DBInfo (
	Nome,
	Psw,
	SincronizzaDB,
	UltimaModifica,
	UltimoAggiornamentoDB,
	Valuta,
	Email,
) values (
	@Nome,
	@Psw,	
	@SincronizzaDB,
	@UltimaModifica,
	@UltimoAggiornamentoDB,
	@Email
)