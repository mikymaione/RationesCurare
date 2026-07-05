using System.Globalization;

namespace RationesCurare.Models;

public static class GestioneValute
{
    // Modificato da CultureInfo a List<CultureInfo> usando .ToList() nel raggruppamento
    private static readonly Dictionary<RegionInfo, List<CultureInfo>> RegionInfos =
        CultureInfo
            .GetCultures(CultureTypes.SpecificCultures)
            .GroupBy(culture => new RegionInfo(culture.Name))
            .ToDictionary(
                group => group.Key,
                group => group.ToList()
            );

    public static readonly List<LanguageCodeDescription> Currencies =
        RegionInfos
            .Select(pair => pair.Key) // Prendiamo direttamente le chiavi (RegionInfo)
            .GroupBy(region => region.ISOCurrencySymbol)
            .Select(g => g.First())
            .Select(region =>
                new LanguageCodeDescription(region.ISOCurrencySymbol, region.CurrencyEnglishName)
            )
            .OrderBy(e => e.Description)
            .ToList();

    public static readonly List<LanguageCodeDescription> LanguageCurrencies =
        RegionInfos
            .SelectMany(pair => pair.Value.Select(culture => new { Region = pair.Key, Culture = culture }))
            .Select(x =>
                new LanguageCodeDescription(x.Culture.Name, $"{x.Culture.EnglishName} - {x.Region.CurrencyEnglishName}")
            )
            .OrderBy(e => e.Description)
            .ToList();

    public static List<RegionInfo> GetRegionInfoByLingua(string language) =>
        RegionInfos
            .Where(pair => pair.Value.Any(c => c.Name.Equals(language, StringComparison.InvariantCultureIgnoreCase)))
            .Select(pair => pair.Key)
            .ToList();

    public static List<CultureInfo> GetCultureByValuta(string valuta) =>
        RegionInfos
            .Where(pair => pair.Key.ISOCurrencySymbol.Equals(valuta, StringComparison.InvariantCultureIgnoreCase))
            .SelectMany(pair => pair.Value) // Usiamo SelectMany per appiattire la lista di liste
            .ToList();

    public static List<LanguageCodeDescription> GetLanguageCurrenciesByValuta(string valuta) =>
        GetCultureByValuta(valuta)
            .Select(c =>
                new LanguageCodeDescription(c.Name, c.EnglishName)
            )
            .OrderBy(e => e.Description)
            .ToList();

    public static List<CultureInfo> GetCultureByLanguage(string language) =>
        CultureInfo
            .GetCultures(CultureTypes.SpecificCultures)
            .Where(c => c.Name.Equals(language, StringComparison.InvariantCultureIgnoreCase))
            .ToList();
}