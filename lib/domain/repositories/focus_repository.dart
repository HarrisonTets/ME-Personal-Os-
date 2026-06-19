import '../entities/focus_session.dart';

/// Storage promise for the Focus pillar.
abstract interface class FocusRepository {
  /// Records a finished session.
  Future<void> saveSession(FocusSession session);

  /// Live list of sessions started on or after [from], newest first.
  Stream<List<FocusSession>> watchSessionsSince(DateTime from);
}
