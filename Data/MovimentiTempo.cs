using System;
using System.Collections.Generic;

namespace RationesCurare.Data;

public partial class MovimentiTempo
{
    public int Id { get; set; }

    public string Nome { get; set; } = null!;

    public string Tipo { get; set; } = null!;

    public string Descrizione { get; set; } = null!;

    public string MacroArea { get; set; } = null!;

    public double Soldi { get; set; }

    public int? NumeroGiorni { get; set; }

    public DateTime? GiornoDelMese { get; set; }

    public string? TipoGiorniMese { get; set; }

    public string? PartendoDalGiorno { get; set; }

    public string? Scadenza { get; set; }

    public virtual ICollection<Movimenti> Movimentis { get; set; } = new List<Movimenti>();

    public virtual Casse TipoNavigation { get; set; } = null!;
}
