import 'package:flutter_test/flutter_test.dart';
import 'package:personal_os/domain/entities/health_log.dart';
import 'package:personal_os/domain/usecases/summarize_health_day.dart';

void main() {
  final day = DateTime(2026, 6, 19);

  HealthLog log(HealthLogType type, double value) => HealthLog(
        id: '$type-$value',
        type: type,
        value: value,
        date: day,
      );

  test('empty list returns the empty summary (all zero)', () {
    final s = const SummarizeHealthDay()([]);
    expect(s.of(HealthLogType.water), 0);
    expect(s.of(HealthLogType.sleep), 0);
  });

  test('sums values per type independently', () {
    final s = const SummarizeHealthDay()([
      log(HealthLogType.water, 1),
      log(HealthLogType.water, 1),
      log(HealthLogType.water, 1), // 3 glasses
      log(HealthLogType.walk, 10),
      log(HealthLogType.walk, 20), // 30 min
      log(HealthLogType.sleep, 7.5),
    ]);

    expect(s.of(HealthLogType.water), 3);
    expect(s.of(HealthLogType.walk), 30);
    expect(s.of(HealthLogType.sleep), 7.5);
    expect(s.of(HealthLogType.workout), 0); // untouched type stays zero
  });
}
