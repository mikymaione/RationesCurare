namespace RationesCurare.Models;

public class LanguageCodeDescription(string code, string description) : IComparable<LanguageCodeDescription>, IEquatable<LanguageCodeDescription>
{
    public string Code { get; set; } = code;
    public string Description { get; set; } = description;

    public int CompareTo(LanguageCodeDescription? other) =>
        other == null
            ? 1
            : string.Compare(Description, other.Description, StringComparison.Ordinal);

    public bool Equals(LanguageCodeDescription? other) =>
        other != null && Code == other.Code;

    public override bool Equals(object? obj) =>
        Equals(obj as LanguageCodeDescription);

    public override int GetHashCode() =>
        Code.GetHashCode();
}