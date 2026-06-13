using Microsoft.JSInterop;
using System.Text.Json;

namespace RationesCurare.Functions;

public class CookieHelper(IJSRuntime JS)
{
    private const string CookieName = "RCWEB";

    public async Task<bool> SetCookieAsync(string[] keys, string[] values)
    {
        // 1. Creiamo un dizionario chiave-valore per simulare il vecchio sub-cookie
        var cookieData = new Dictionary<string, string>();

        for (var i = 0; i < keys.Length; i++)
            cookieData[keys[i]] = values[i];

        // 2. Serializziamo in JSON e codifichiamo per sicurezza (evita problemi con caratteri speciali)
        var jsonValue = JsonSerializer.Serialize(cookieData);
        var encodedValue = Uri.EscapeDataString(jsonValue);

        // 3. Impostiamo la scadenza a 7 giorni (espressa in secondi per il Max-Age)
        long maxAgeSeconds = 7 * 24 * 60 * 60; 

        // 4. Scriviamo il cookie tramite JavaScript (aggiungendo SameSite e Secure per sicurezza)
        var cookieString = $"{CookieName}={encodedValue}; max-age={maxAgeSeconds}; path=/; SameSite=Lax; Secure"; 
        await JS.InvokeVoidAsync("eval", $"document.cookie = '{cookieString}'");

        return true;
    }

    public async Task<string> GetCookieAsync(string key)
    {
        // 1. Leggiamo tutti i cookie del browser
        var allCookies = await JS.InvokeAsync<string>("eval", "document.cookie");

        if (string.IsNullOrEmpty(allCookies))
            return string.Empty;

        // 2. Cerchiamo il nostro cookie "RCWEB"
        var cookieDataString = allCookies
            .Split("; ")
            .FirstOrDefault(c => c.StartsWith($"{CookieName}="))
            ?.Substring($"{CookieName}=".Length);

        if (string.IsNullOrEmpty(cookieDataString))
            return string.Empty;

        // 3. Decodifichiamo e deserializziamo il JSON
        var decodedJson = Uri.UnescapeDataString(cookieDataString);
        var cookieData = JsonSerializer.Deserialize<Dictionary<string, string>>(decodedJson);

        // 4. Estraiamo la sotto-chiave richiesta
        if (cookieData != null && cookieData.TryGetValue(key, out var value))
            return value;

        return string.Empty;
    }

}