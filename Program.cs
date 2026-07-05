using Microsoft.EntityFrameworkCore;
using Microsoft.AspNetCore.Authentication.Cookies;
using Microsoft.AspNetCore.Authentication;
using System.Security.Claims;
using RationesCurare.Components;
using RationesCurare.Data;
using RationesCurare.Functions;
using ApexCharts;

var builder = WebApplication.CreateBuilder(args);

// 1. REGISTRA I SERVIZI FONDAMENTALI DELLA DI
builder.Services.AddScoped<UserSession>();

// Serve per consentire alla configurazione del DbContext di leggere i cookie della richiesta corrente
builder.Services.AddHttpContextAccessor();

// 2. REGISTRAZIONE DINAMICA DI APPDBCONTEXT CON PROVIDER SQLITE
builder.Services.AddDbContext<AppDbContext>((serviceProvider, options) =>
{
    var env = serviceProvider.GetRequiredService<IWebHostEnvironment>();
    var httpContextAccessor = serviceProvider.GetRequiredService<IHttpContextAccessor>();

    // Recuperiamo l'email dell'utente autenticato direttamente dal Cookie nativo crittografato
    var email = httpContextAccessor.HttpContext?.User?.Identity?.Name;

    if (!string.IsNullOrWhiteSpace(email))
    {
        // Se l'utente è loggato, agganciamo dinamicamente il suo database SQLite specifico
        var dbPath = Path.Combine(env.ContentRootPath, "App_Data", $"{email.Trim().ToLower()}.rqd8");
        options.UseSqlite($"Data Source={dbPath}");
    }
    else
    {
        // Fallback di sicurezza per le rotte anonime (es. Home pubblica o pagina di SignIn) serve a evitare che la DI fallisca prima del Login
        var fallbackPath = Path.Combine(env.ContentRootPath, "App_Data", "standard.rqd8");
        options.UseSqlite($"Data Source={fallbackPath}");
    }
});

builder.Services.AddScoped<RecurringTransactionManagement>();

// 3. AUTENTICAZIONE TRAMITE COOKIE NATIVI
builder.Services.AddAuthentication(CookieAuthenticationDefaults.AuthenticationScheme)
    .AddCookie(options =>
    {
        options.LoginPath = "/signin";
        options.ExpireTimeSpan = TimeSpan.FromDays(30);
    });

builder.Services.AddAuthorization();
builder.Services.AddCascadingAuthenticationState();

builder.Services.AddRazorComponents()
    .AddInteractiveServerComponents();

builder.Services.AddApexCharts();

var app = builder.Build();

if (!app.Environment.IsDevelopment())
{
    app.UseExceptionHandler("/Error", createScopeForErrors: true);
    app.UseHsts();
}
app.UseStatusCodePagesWithReExecute("/not-found", createScopeForStatusCodePages: true);
app.UseHttpsRedirection();

// Middleware nell'ordine corretto
app.UseAuthentication();
app.UseAuthorization();
app.UseAntiforgery();

app.MapStaticAssets();

// 4. ENDPOINT DI LOGIN
app.MapGet("/login-cookie", async (string email, bool rememberMe, HttpContext httpContext) =>
{
    var identity = new ClaimsIdentity([new(ClaimTypes.Name, email)], CookieAuthenticationDefaults.AuthenticationScheme);
    var principal = new ClaimsPrincipal(identity);

    var authProperties = new AuthenticationProperties
    {
        IsPersistent = rememberMe,
        ExpiresUtc = rememberMe ? DateTimeOffset.UtcNow.AddDays(30) : null
    };

    // Scrive il cookie cifrato nel browser
    await httpContext.SignInAsync(CookieAuthenticationDefaults.AuthenticationScheme, principal, authProperties);
    
    return Results.Redirect("/balance");
});

// Endpoint HTTP minimale per distruggere il cookie di sessione
app.MapGet("/logout-cookie", async (HttpContext httpContext) =>
{
    await httpContext.SignOutAsync(CookieAuthenticationDefaults.AuthenticationScheme);
    return Results.Redirect("/signin");
});

app.MapRazorComponents<App>()
    .AddInteractiveServerRenderMode();

app.Run();