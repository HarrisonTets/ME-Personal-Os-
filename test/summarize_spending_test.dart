import 'package:flutter_test/flutter_test.dart';
import 'package:personal_os/domain/entities/finance_entry.dart';
import 'package:personal_os/domain/usecases/summarize_spending.dart';

void main() {
  final date = DateTime(2026, 6, 19);

  FinanceEntry entry(
    FinanceType type,
    double amount,
    FinanceCategory category,
  ) =>
      FinanceEntry(
        id: '$type-$amount-$category',
        type: type,
        amount: amount,
        category: category,
        date: date,
      );

  test('empty list returns the empty summary', () {
    final s = const SummarizeSpending()([]);
    expect(s.totalExpense, 0);
    expect(s.totalIncome, 0);
    expect(s.entryCount, 0);
    expect(s.topCategories, isEmpty);
  });

  test('sums income and expense separately and counts entries', () {
    final s = const SummarizeSpending()([
      entry(FinanceType.expense, 100, FinanceCategory.food),
      entry(FinanceType.expense, 50, FinanceCategory.transport),
      entry(FinanceType.income, 1000, FinanceCategory.business),
    ]);

    expect(s.totalExpense, 150);
    expect(s.totalIncome, 1000);
    expect(s.entryCount, 3);
    expect(s.net, 850);
  });

  test('top categories are expense-only, aggregated and sorted desc', () {
    final s = const SummarizeSpending()([
      entry(FinanceType.expense, 30, FinanceCategory.food),
      entry(FinanceType.expense, 70, FinanceCategory.food), // food total 100
      entry(FinanceType.expense, 200, FinanceCategory.rent),
      entry(FinanceType.income, 999, FinanceCategory.business), // excluded
    ]);

    expect(s.topCategories.first.category, FinanceCategory.rent);
    expect(s.topCategories.first.total, 200);
    expect(s.topCategories[1].category, FinanceCategory.food);
    expect(s.topCategories[1].total, 100);
    // income category must not appear among spending categories
    expect(
      s.topCategories.any((c) => c.category == FinanceCategory.business),
      isFalse,
    );
  });

  test('respects topN limit', () {
    final s = const SummarizeSpending(topN: 2)([
      entry(FinanceType.expense, 10, FinanceCategory.food),
      entry(FinanceType.expense, 20, FinanceCategory.rent),
      entry(FinanceType.expense, 30, FinanceCategory.transport),
    ]);

    expect(s.topCategories.length, 2);
    expect(s.topCategories.first.category, FinanceCategory.transport);
  });
}
