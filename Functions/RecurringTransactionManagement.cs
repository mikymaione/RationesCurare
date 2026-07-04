using Microsoft.EntityFrameworkCore;
using RationesCurare.Data;

namespace RationesCurare.Functions;

public class RecurringTransactionManagement(AppDbContext dbContext)
{
    /// Controlla ed esegue i movimenti periodici scaduti, inserendoli in Movimenti.
    public async Task ProcessPendingTransactionsAsync()
    {
        var adesso = DateTime.Now;

        // 1. Estraiamo i periodici la cui scadenza complessiva non è passata 
        // ed il cui prossimo trigger (PartendoDalGiorno o GiornoDelMese) è nel passato o oggi.
        var scadenzeScadute = await dbContext.MovimentiTempos
            .Where(pi =>
                (!pi.Scadenza.HasValue || pi.Scadenza > adesso)
                && (
                    (pi.TipoGiorniMese == "G" && pi.PartendoDalGiorno < adesso)
                    || (pi.TipoGiorniMese != "G" && pi.GiornoDelMese < adesso)
                )
            )
            .ToListAsync();

        if (scadenzeScadute.Count == 0)
            return;

        // Apriamo la transazione per garantire l'atomicità (ACID) su SQLite
        using var transaction = await dbContext.Database.BeginTransactionAsync();

        try
        {
            foreach (var pi in scadenzeScadute)
            {
                // Identifichiamo il giorno esatto in cui il movimento DOVEVA originariamente essere registrato
                var dataMovimentoCorrente = (pi.TipoGiorniMese == "G" ? pi.PartendoDalGiorno : pi.GiornoDelMese) ?? adesso;

                // 2. Creazione del movimento storico effettivo
                var nuovoMovimento = new Movimenti
                {
                    Nome = pi.Nome,
                    Tipo = pi.Tipo,
                    Descrizione = pi.Descrizione,
                    Soldi = pi.Soldi,
                    Data = dataMovimentoCorrente,
                    MacroArea = pi.MacroArea,
                    IdmovimentoTempo = pi.Id // Chiave esterna verso MovimentiTempo(ID)
                };

                dbContext.Movimentis.Add(nuovoMovimento);

                // 3. Calcolo preciso della data successiva partendo dalla data di scadenza originale (non da DateTime.Now!)
                var prossimaScadenza = CalcolaProssimaScadenza(pi, dataMovimentoCorrente);

                // 4. Aggiornamento dello stato del record periodico per il prossimo ciclo
                if (pi.TipoGiorniMese == "G")
                {
                    pi.GiornoDelMese = null;
                    pi.PartendoDalGiorno = prossimaScadenza;
                }
                else
                {
                    pi.PartendoDalGiorno = null;
                    pi.GiornoDelMese = prossimaScadenza;
                }
            }

            // Invia i comandi INSERT e UPDATE al DB in un'unica soluzione
            await dbContext.SaveChangesAsync();

            // Se tutto è andato a buon fine, salviamo definitivamente
            await transaction.CommitAsync();
        }
        catch (Exception)
        {
            // In caso di errore, il rollback viene invocato automaticamente alla chiusura dello 'using'
            throw;
        }
    }

    /// Calcola la DateTime della prossima ricorrenza in base alla periodicità.
    private static DateTime CalcolaProssimaScadenza(MovimentiTempo pi, DateTime dataCorrente) =>
        pi.TipoGiorniMese switch
        {
            "G" => dataCorrente.AddDays(pi.NumeroGiorni > 0 ? pi.NumeroGiorni.Value : 1),
            "M" => dataCorrente.AddMonths(1),
            "B" => dataCorrente.AddMonths(2),
            "T" => dataCorrente.AddMonths(3),
            "Q" => dataCorrente.AddMonths(4),
            "S" => dataCorrente.AddMonths(6),
            "A" => dataCorrente.AddMonths(12),
            _ => dataCorrente.AddMonths(1) // Fallback standard
        };

}