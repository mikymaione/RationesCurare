using System;
using System.Collections.Generic;

namespace RationesCurare.Data;

public partial class Casse
{
    public string Nome { get; set; } = null!;

    public byte[]? ImgName { get; set; }

    // public string? Valuta { get; set; } non usata

    public bool? Nascondi { get; set; }

    public virtual ICollection<MovimentiTempo> MovimentiTempos { get; set; } = new List<MovimentiTempo>();

    public virtual ICollection<Movimenti> Movimentis { get; set; } = new List<Movimenti>();
}
