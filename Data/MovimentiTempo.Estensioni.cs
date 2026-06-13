namespace RationesCurare.Data;

public partial class MovimentiTempo
{    
    public bool IsGiornaliero =>
        TipoGiorniMese == "G";
        
    public string Periodo_H =>
        TipoGiorniMese switch
        { 
            "G" => "Daily",
            "M" => "Monthly",
            "B" => "Bimonthly",
            "T" => "Quarterly",
            "Q" => "Four-monthly",
            "S" => "Semi-annual",
            "A" => "Annual",
            _ => "NaN"
        };
}