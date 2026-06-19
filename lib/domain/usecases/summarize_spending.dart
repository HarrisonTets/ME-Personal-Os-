import '../entities/finance_entry.dart';

/// Total spent in one category, used for the "top categories" breakdown.
class CategoryTotal {
  const CategoryTotal(this.category, this.total);
  final FinanceCategory category;
  final double total;
}

/// A roll-up of a set of finance entries (already filtered to a period by the
/// caller — e.g. "this week").
class SpendingSummary {
  const SpendingSummary({
    required this.totalIncome,
    required this.totalExpense,
    required this.entryCount,
    required this.topCategories,
  });

  final double totalIncome;
  final double totalExpense;
  final int entryCount;

  /// Highest-spending expense categories, descending.
  final List<CategoryTotal> topCategories;

  double get net => totalIncome - totalExpense;

  static const empty = SpendingSummary(
    totalIncome: 0,
    totalExpense: 0,
    entryCount: 0,
    topCategories: [],
  );
}

/// Pure function that rolls up entries into a [SpendingSummary]. No I/O, so it's
/// trivially unit-testable (mirrors the suggestion engine's approach).
class SummarizeSpending {
  const SummarizeSpending({this.topN = 3});

  /// How many top categories to surface.
  final int topN;

  SpendingSummary call(List<FinanceEntry> entries) {
    if (entries.isEmpty) return SpendingSummary.empty;

    var income = 0.0;
    var expense = 0.0;
    final byCategory = <FinanceCategory, double>{};

    for (final e in entries) {
      if (e.type == FinanceType.income) {
        income += e.amount;
      } else {
        expense += e.amount;
        byCategory[e.category] = (byCategory[e.category] ?? 0) + e.amount;
      }
    }

    final top = byCategory.entries
        .map((e) => CategoryTotal(e.key, e.value))
        .toList()
      ..sort((a, b) => b.total.compareTo(a.total));

    return SpendingSummary(
      totalIncome: income,
      totalExpense: expense,
      entryCount: entries.length,
      topCategories: top.take(topN).toList(),
    );
  }
}
