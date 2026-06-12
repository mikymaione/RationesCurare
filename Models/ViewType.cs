using System.ComponentModel;

namespace RationesCurare.Models;

public enum ViewType
{
    [Description("All Transactions")]
    AllTransactions,

    [Description("Monthly Cash Flow")]
    MonthlyCashFlow,

    [Description("Annual Cash Flow")]
    AnnualCashFlow,

    [Description("Monthly Account Balance Trend")]
    MonthlyAccountBalanceTrend,
    
    [Description("Annual Account Balance Trend")]
    AnnualAccountBalanceTrend,

    [Description("Expense Breakdown")]
    ExpenseBreakdown
}