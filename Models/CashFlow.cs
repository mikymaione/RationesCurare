namespace RationesCurare.Models;

public record CashFlow
(
    int? Year,
    int? Month,
    double Balance
)
{
    public decimal BalanceDecimal =>
        Convert.ToDecimal(Balance);
};