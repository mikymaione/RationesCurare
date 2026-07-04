namespace RationesCurare.Models;

public record CategoryBreakdown
(
    string Category,
    double Balance
)
{
    private static readonly string In = "Income";
    private static readonly string Out = "Expense";

    public decimal BalanceDecimal =>
        Convert.ToDecimal(Balance);

    public IEnumerable<CategoryItem> ToCategoryItem() =>
        BalanceDecimal < 0
            ? [new(In, 0), new(Out, Math.Abs(BalanceDecimal))]
            : [new(In, BalanceDecimal), new(Out, 0)];
}

public record CategoryItem
(
    string TipoFlusso,
    decimal Valore
);