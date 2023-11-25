update utenti set
	nome = @nome,	
	Psw = @Psw,
	path = @path,
	Email = @Email,	
	TipoDB = @TipoDB
where
	ID = @ID