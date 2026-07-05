window.deferredPrompt = null;
let blazorComponentReference = null;

// Registra il riferimento del componente Blazor per notificarlo quando il prompt è pronto
window.pwaRegistration = {
    init: (dotNetRef) => {
        blazorComponentReference = dotNetRef;
        // Se l'evento si è già scatenato prima dell'inizializzazione del componente, lo notifichiamo subito
        if (window.deferredPrompt && blazorComponentReference) {
            blazorComponentReference.invokeMethodAsync('ShowInstallButton');
        }
    },
    showPrompt: async () => {
        const promptEvent = window.deferredPrompt;
        if (!promptEvent) return false;

        promptEvent.prompt();
        const result = await promptEvent.userChoice;
        console.log('👍', 'userChoice', result);

        window.deferredPrompt = null;
        return true;
    }
};

window.addEventListener('beforeinstallprompt', (event) => {
    event.preventDefault();
    console.log('👍', 'beforeinstallprompt', event);
    window.deferredPrompt = event;

    // Notifica Blazor se il componente è già attivo e in ascolto
    if (blazorComponentReference) {
        blazorComponentReference.invokeMethodAsync('ShowInstallButton');
    }
});

window.addEventListener('appinstalled', (event) => {
    console.log('👍', 'appinstalled', event);
    window.deferredPrompt = null;
});