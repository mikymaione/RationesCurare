using Blazored.LocalStorage;

namespace RationesCurare.Functions;

public class LocalStorageManager(ILocalStorageService LocalStorage)
{

    private HashSet<string>? Keys;
    private string? ClassName;
    private bool IsInitialized;

    public bool IsReady(string className) =>
        IsInitialized && ClassName == className;

    public async Task InitializeKeysAsync(string className)
    {
        ClassName = className;
        Keys = [.. await LocalStorage.KeysAsync()];
        IsInitialized = true;
    }

    public async Task IfNotInitializeKeysAsync(string className)
    {
        if (!IsReady(className))
            await InitializeKeysAsync(className);
    }

    public async Task<X> GetItemAsync<X>(string keyName, X defaultValue)
    {
        var key = KeyName(keyName);

        if (Keys?.Contains(key) == true)
            try
            {
                var value = await LocalStorage.GetItemAsync<X>(key);

                return value is null ? defaultValue : value;
            }
            catch
            {
                // can not convert                
            }

        return defaultValue;
    }

    public async Task SetItemAsync<X>(string keyName, X value)
    {
        var key = KeyName(keyName);

        await LocalStorage.SetItemAsync(key, value);

        Keys?.Add(key);
    }

    private string KeyName(string key) =>
        $"{ClassName}.{key}";

}