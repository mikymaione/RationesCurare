using Microsoft.EntityFrameworkCore;
using RationesCurare.Functions;

namespace RationesCurare.Data;

public partial class AppDbContext(DbContextOptions<AppDbContext> options, UserSession userSession) : DbContext(options)
{
    public virtual DbSet<Calendario> Calendarios { get; set; }

    public virtual DbSet<Casse> Casses { get; set; }

    public virtual DbSet<Dbinfo> Dbinfos { get; set; }

    public virtual DbSet<Movimenti> Movimentis { get; set; }

    public virtual DbSet<MovimentiEuByMese> MovimentiEuByMeses { get; set; }

    public virtual DbSet<MovimentiEuByMeseMerge> MovimentiEuByMeseMerges { get; set; }

    public virtual DbSet<MovimentiTempo> MovimentiTempos { get; set; }

    public virtual DbSet<Valute> Valutes { get; set; }

    protected override void OnConfiguring(DbContextOptionsBuilder optionsBuilder)
    {
        if (userSession.IsInitialized)
            optionsBuilder.UseSqlite($"Data Source={userSession.DatabasePath}");

        base.OnConfiguring(optionsBuilder);
    }

    protected override void OnModelCreating(ModelBuilder modelBuilder)
    {
        modelBuilder.Entity<Calendario>(entity =>
        {
            entity.ToTable("Calendario");

            entity.Property(e => e.Id).HasColumnName("ID");
            entity.Property(e => e.Descrizione)
                .UseCollation("NOCASE")
                .HasColumnType("VARCHAR(255)");
            entity.Property(e => e.Giorno)
                .UseCollation("NOCASE")
                .HasColumnType("VARCHAR(19)");
            entity.Property(e => e.Idgruppo)
                .UseCollation("NOCASE")
                .HasColumnType("VARCHAR(36)")
                .HasColumnName("IDGruppo");
            entity.Property(e => e.Inserimento)
                .UseCollation("NOCASE")
                .HasColumnType("VARCHAR(19)");
        });

        modelBuilder.Entity<Casse>(entity =>
        {
            entity.HasKey(e => e.Nome);

            entity.ToTable("Casse");

            entity.Property(e => e.Nome)
                .UseCollation("NOCASE")
                .HasColumnType("VARCHAR(20)");
            entity.Property(e => e.Nascondi).HasColumnType("boolean");
            /* non usata
            entity.Property(e => e.Valuta)
                .UseCollation("NOCASE")
                .HasColumnType("VARCHAR(3)");

            entity.HasOne(d => d.ValutaNavigation).WithMany(p => p.Casses).HasForeignKey(d => d.Valuta);
            */            
        });

        modelBuilder.Entity<Dbinfo>(entity =>
        {
            entity.HasKey(e => e.Email);

            entity.ToTable("DBInfo");

            entity.Property(e => e.Email)
                .UseCollation("NOCASE")
                .HasColumnType("VARCHAR(80)");
            entity.Property(e => e.Lingua).HasColumnType("varchar(15)");
            entity.Property(e => e.Nome)
                .UseCollation("NOCASE")
                .HasColumnType("VARCHAR(255)");
            entity.Property(e => e.Psw)
                .UseCollation("NOCASE")
                .HasColumnType("VARCHAR(80)");
            entity.Property(e => e.SincronizzaDb)
                .HasColumnType("boolean")
                .HasColumnName("SincronizzaDB");
            entity.Property(e => e.UltimaModifica)
                .UseCollation("NOCASE")
                .HasColumnType("VARCHAR(19)");
            entity.Property(e => e.UltimoAggiornamentoDb)
                .UseCollation("NOCASE")
                .HasColumnType("VARCHAR(19)")
                .HasColumnName("UltimoAggiornamentoDB");
            entity.Property(e => e.Valuta)
                .UseCollation("NOCASE")
                .HasColumnType("VARCHAR(3)");

            entity.HasOne(d => d.ValutaNavigation).WithMany(p => p.Dbinfos)
                .HasForeignKey(d => d.Valuta)
                .OnDelete(DeleteBehavior.ClientSetNull);
        });

        modelBuilder.Entity<Movimenti>(entity =>
        {
            entity.ToTable("Movimenti");

            entity.Property(e => e.Id).HasColumnName("ID");
            entity.Property(e => e.Data)
                .UseCollation("NOCASE")
                .HasColumnType("VARCHAR(19)");
            entity.Property(e => e.Descrizione).UseCollation("NOCASE");
            entity.Property(e => e.Idgiroconto).HasColumnName("IDGiroconto");
            entity.Property(e => e.IdmovimentoTempo).HasColumnName("IDMovimentoTempo");
            entity.Property(e => e.MacroArea)
                .UseCollation("NOCASE")
                .HasColumnType("VARCHAR(250)");
            entity.Property(e => e.Nome)
                .UseCollation("NOCASE")
                .HasColumnType("VARCHAR(255)");
            entity.Property(e => e.Soldi).HasColumnType("DOUBLE");
            entity.Property(e => e.Tipo)
                .UseCollation("NOCASE")
                .HasColumnType("VARCHAR(20)");

            entity.HasOne(d => d.IdgirocontoNavigation).WithMany(p => p.InverseIdgirocontoNavigation).HasForeignKey(d => d.Idgiroconto);

            entity.HasOne(d => d.IdmovimentoTempoNavigation).WithMany(p => p.Movimentis).HasForeignKey(d => d.IdmovimentoTempo);

            entity.HasOne(d => d.TipoNavigation).WithMany(p => p.Movimentis)
                .HasForeignKey(d => d.Tipo)
                .OnDelete(DeleteBehavior.ClientSetNull);
        });

        modelBuilder.Entity<MovimentiEuByMese>(entity =>
        {
            entity
                .HasNoKey()
                .ToView("Movimenti_EU_By_Mese");
        });

        modelBuilder.Entity<MovimentiEuByMeseMerge>(entity =>
        {
            entity
                .HasNoKey()
                .ToView("Movimenti_EU_By_Mese_Merge");
        });

        modelBuilder.Entity<MovimentiTempo>(entity =>
        {
            entity.ToTable("MovimentiTempo");

            entity.Property(e => e.Id).HasColumnName("ID");
            entity.Property(e => e.Descrizione)
                .UseCollation("NOCASE")
                .HasColumnType("VARCHAR(255)");
            entity.Property(e => e.GiornoDelMese)
                .UseCollation("NOCASE")
                .HasColumnType("VARCHAR(19)");
            entity.Property(e => e.MacroArea)
                .UseCollation("NOCASE")
                .HasColumnType("VARCHAR(250)");
            entity.Property(e => e.Nome)
                .UseCollation("NOCASE")
                .HasColumnType("VARCHAR(255)");
            entity.Property(e => e.PartendoDalGiorno)
                .UseCollation("NOCASE")
                .HasColumnType("VARCHAR(19)");
            entity.Property(e => e.Scadenza)
                .UseCollation("NOCASE")
                .HasColumnType("VARCHAR(19)");
            entity.Property(e => e.Soldi).HasColumnType("DOUBLE");
            entity.Property(e => e.Tipo)
                .UseCollation("NOCASE")
                .HasColumnType("VARCHAR(20)");
            entity.Property(e => e.TipoGiorniMese)
                .UseCollation("NOCASE")
                .HasColumnType("VARCHAR(1)");

            entity.HasOne(d => d.TipoNavigation).WithMany(p => p.MovimentiTempos)
                .HasForeignKey(d => d.Tipo)
                .OnDelete(DeleteBehavior.ClientSetNull);
        });

        modelBuilder.Entity<Valute>(entity =>
        {
            entity.HasKey(e => e.Valuta);

            entity.ToTable("Valute");

            entity.Property(e => e.Valuta)
                .UseCollation("NOCASE")
                .HasColumnType("VARCHAR(3)");
            entity.Property(e => e.Descrizione)
                .UseCollation("NOCASE")
                .HasColumnType("VARCHAR(800)");
        });

        OnModelCreatingPartial(modelBuilder);
    }

    partial void OnModelCreatingPartial(ModelBuilder modelBuilder);
}
