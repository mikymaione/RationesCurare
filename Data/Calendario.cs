using System;
using System.Collections.Generic;

namespace RationesCurare.Data;

public partial class Calendario
{
    public int Id { get; set; }

    public DateTime Giorno { get; set; }

    public string Descrizione { get; set; } = null!;

    public string? Idgruppo { get; set; }

    public DateTime Inserimento { get; set; }
}
