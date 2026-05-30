using System;
using System.Collections.Generic;

namespace RationesCurare.Data;

public partial class Dbinfo
{
    public string Email { get; set; } = null!;

    public string Nome { get; set; } = null!;

    public string Psw { get; set; } = null!;

    public bool? SincronizzaDb { get; set; }

    public DateTime UltimaModifica { get; set; }

    public string? UltimoAggiornamentoDb { get; set; }

    public string Valuta { get; set; } = null!;

    public string? Lingua { get; set; }

    public virtual Valute ValutaNavigation { get; set; } = null!;
}
