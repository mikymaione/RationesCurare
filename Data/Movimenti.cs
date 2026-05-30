using System;
using System.Collections.Generic;

namespace RationesCurare.Data;

public partial class Movimenti
{
    public int Id { get; set; }

    public string Nome { get; set; } = null!;

    public DateTime Data { get; set; }

    public string Tipo { get; set; } = null!;

    public string Descrizione { get; set; } = null!;

    public string MacroArea { get; set; } = null!;

    public double Soldi { get; set; }

    public int? Idgiroconto { get; set; }

    public int? IdmovimentoTempo { get; set; }

    public virtual Movimenti? IdgirocontoNavigation { get; set; }

    public virtual MovimentiTempo? IdmovimentoTempoNavigation { get; set; }

    public virtual ICollection<Movimenti> InverseIdgirocontoNavigation { get; set; } = new List<Movimenti>();

    public virtual Casse TipoNavigation { get; set; } = null!;
}
