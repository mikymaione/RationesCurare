using System;
using System.Collections.Generic;

namespace RationesCurare.Data;

public partial class Valute
{
    public string Valuta { get; set; } = null!;

    public string Descrizione { get; set; } = null!;

    // public virtual ICollection<Casse> Casses { get; set; } = new List<Casse>(); // non usata

    public virtual ICollection<Dbinfo> Dbinfos { get; set; } = new List<Dbinfo>();
}
