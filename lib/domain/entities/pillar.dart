/// The five domains of growth the app is organised around.
///
/// Kept free of any Flutter/UI concerns — display metadata (icons, colours)
/// lives in the presentation layer so the domain stays portable.
enum PillarType {
  finance,
  learning,
  spiritual,
  focus,
  health;

  /// Stable string used for persistence. Using [name] keeps the stored value
  /// human-readable and decoupled from enum ordering.
  String get storageKey => name;

  static PillarType fromStorage(String key) =>
      PillarType.values.firstWhere((p) => p.name == key);
}
