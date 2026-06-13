namespace RationesCurare.Data;

public partial class MovimentiTempo
{    
    public string Periodo_H =>
        TipoGiorniMese switch
        { 
            "G" => "Giornaliero",
            "M" => "Mensile",
            "B" => "Bimestrale",
            "T" => "Trimestrale",
            "Q" => "Quadrimestrale",
            "S" => "Semestrale",
            "A" => "Annuale",
            _ => "NaN"
        };
}