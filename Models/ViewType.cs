using System.ComponentModel;

namespace RationesCurare.Models;

public enum ViewType
{
    [Description("All Transactions")]
    All,

    [Description("Monthly Cash Flow")]
    Monthly,

    [Description("Annual Cash Flow")]
    Annual,

    [Description("Account Balance Trend")]
    Trend,

    [Description("Expense breakdown")]
    Breakdown
}