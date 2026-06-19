import 'package:drift/drift.dart';
import 'package:uuid/uuid.dart';

import 'app_database.dart';

/// Seeds a built-in "Gospel of John" reading plan (21 days, one chapter each)
/// the first time the Bible feature runs. Idempotent: does nothing if a plan
/// already exists.
Future<void> seedBiblePlanIfEmpty(AppDatabase db) async {
  final existing = await db.select(db.biblePlans).get();
  if (existing.isNotEmpty) return;

  const uuid = Uuid();
  final planId = uuid.v4();
  const totalDays = 21;

  await db.into(db.biblePlans).insert(
        BiblePlansCompanion.insert(
          id: planId,
          name: 'Gospel of John',
          description: const Value('Read through John, one chapter a day.'),
          totalDays: totalDays,
        ),
      );

  await db.batch((batch) {
    for (var day = 1; day <= totalDays; day++) {
      batch.insert(
        db.readingAssignments,
        ReadingAssignmentsCompanion.insert(
          id: uuid.v4(),
          planId: planId,
          dayNumber: day,
          reference: 'John $day',
        ),
      );
    }
  });
}
