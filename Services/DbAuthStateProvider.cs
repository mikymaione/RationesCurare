using System.Security.Claims;
using Microsoft.AspNetCore.Components.Authorization;
using RationesCurare.Functions;

namespace RationesCurare.Services;

public class DbAuthStateProvider : AuthenticationStateProvider
{
    private readonly DbSessionState _sessionState;

    public DbAuthStateProvider(DbSessionState sessionState)
    {
        _sessionState = sessionState;
        _sessionState.OnStateChanged += NotificaCambiamentoAutenticazione;
    }

    public override Task<AuthenticationState> GetAuthenticationStateAsync()
    {
        ClaimsIdentity identity = _sessionState.IsAuthenticated
            ? new([new Claim(ClaimTypes.Name, _sessionState.CurrentDbPath!)], "SQLiteAuth")
            : new();
        
        var user = new ClaimsPrincipal(identity);

        return Task.FromResult(new AuthenticationState(user));
    }

    public void NotifyUserAuthentication(string email)
    {        
        var identity = new ClaimsIdentity([new Claim(ClaimTypes.Name, email)], "DbAuthType");
        var user = new ClaimsPrincipal(identity);

        NotifyAuthenticationStateChanged(Task.FromResult(new AuthenticationState(user)));
    }

    private void NotificaCambiamentoAutenticazione()
    {        
        ClaimsIdentity identity = _sessionState.IsAuthenticated
            ? new([new Claim(ClaimTypes.Name, _sessionState.CurrentDbPath!)], "SQLiteAuth")
            : new();
        
        var user = new ClaimsPrincipal(identity);
        var state = new AuthenticationState(user);
        
        NotifyAuthenticationStateChanged(Task.FromResult(state));
    }

}