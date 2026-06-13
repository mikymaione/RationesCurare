namespace RationesCurare.Functions;

public class DbSessionState
{
    public string? CurrentDbPath { get; private set; }
    public string? CurrentPassword { get; private set; }

    public bool IsAuthenticated =>
        !string.IsNullOrEmpty(CurrentDbPath);

    // Evento per notificare i componenti in caso di login/logout
    public event Action? OnStateChanged;

    private void NotifyStateChanged() =>
        OnStateChanged?.Invoke();
        
    public void Login(string dbPath, string password)
    {
        CurrentDbPath = dbPath;
        CurrentPassword = password;
        NotifyStateChanged();
    }

    public void Logout()
    {
        CurrentDbPath = null;
        CurrentPassword = null;
        NotifyStateChanged();
    }

    // Genera la stringa di connessione dinamica per SQLite (es. usando Microsoft.Data.Sqlite)
    public string GetConnectionString()
    {
        if (!IsAuthenticated) 
            throw new InvalidOperationException("Nessun database caricato.");

        // Esempio con SQLCipher (Password)
        return $"Data Source={CurrentDbPath};";
        // return $"Data Source={CurrentDbPath};Password={CurrentPassword};"; //TODO
    }
    
}