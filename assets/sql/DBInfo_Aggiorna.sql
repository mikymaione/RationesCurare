update DBInfo set	
	Nome = @Nome,
	Psw = @Psw,	
	SincronizzaDB = @SincronizzaDB,
	UltimaModifica = @UltimaModifica,
	UltimoAggiornamentoDB = @UltimoAggiornamentoDB,
	Valuta = @Valuta
where
	Email = @Email