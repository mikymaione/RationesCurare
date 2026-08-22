using System.Globalization;

namespace RationesCurare.Functions;

public static class GB
{

    public static string? ToDate(DateTime? d) =>
        d?.ToString("d");

    public static string? ToDateTime(DateTime? d) =>
        d?.ToString("g");

    public static string? ToMoney(double? d) =>
        d?.ToString("C2");

    public static string? MoneyDirection(double d, bool isTransfer) =>
        d < 0
            ? "from"
            : isTransfer ? "to" : "in";

    public static string ClassColoreImporto(double? d) =>
        d == null
        || Math.Round(d.GetValueOrDefault(), 2) == 0
            ? "moneyNeutro"
            : d > 0
                ? "moneyGood"
                : "moneyBad";

    public static string ToProperCase(this string input) =>
        string.IsNullOrWhiteSpace(input)
            ? input
            : CultureInfo.CurrentCulture.TextInfo.ToTitleCase(input.ToLower());

}