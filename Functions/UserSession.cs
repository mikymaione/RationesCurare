namespace RationesCurare.Functions;

public class UserSession(IWebHostEnvironment env)
{    
    public string? Email { get; private set; }
    public string? DatabasePath { get; private set; }
    
    public bool IsInitialized =>
        !string.IsNullOrEmpty(DatabasePath);

    public void Initialize(string email)
    {
        if (!string.IsNullOrWhiteSpace(email))
        {
            Email = email.Trim().ToLower();            
            DatabasePath = Path.Combine(env.ContentRootPath, "App_Data", $"{Email}.rqd8");
        }
    }
}