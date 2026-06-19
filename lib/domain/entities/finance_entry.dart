/// Whether money came in or went out.
enum FinanceType {
  income,
  expense;

  String get storageKey => name;
  static FinanceType fromStorage(String key) =>
      FinanceType.values.firstWhere((t) => t.name == key);
}

/// Simple spending categories (spec §6.2.1). Kept as a small fixed set for the
/// MVP; can be made user-editable later.
enum FinanceCategory {
  food,
  rent,
  transport,
  giving,
  business,
  other;

  String get storageKey => name;
  static FinanceCategory fromStorage(String key) =>
      FinanceCategory.values.firstWhere((c) => c.name == key);

  String get label => switch (this) {
        FinanceCategory.food => 'Food',
        FinanceCategory.rent => 'Rent',
        FinanceCategory.transport => 'Transport',
        FinanceCategory.giving => 'Giving',
        FinanceCategory.business => 'Business',
        FinanceCategory.other => 'Other',
      };
}

/// A single money record — income or expense — logged by the user.
class FinanceEntry {
  const FinanceEntry({
    required this.id,
    required this.type,
    required this.amount,
    required this.category,
    required this.date,
    this.note,
  });

  final String id;
  final FinanceType type;

  /// Stored as a plain number. Fine for a personal tracker (not accounting-grade
  /// decimal precision).
  final double amount;
  final FinanceCategory category;
  final DateTime date;
  final String? note;
}
