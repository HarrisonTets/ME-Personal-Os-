import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import 'data/local/app_database.dart';
import 'data/local/bible_seed.dart';
import 'data/local/seed.dart';
import 'presentation/onboarding/onboarding_screen.dart';
import 'presentation/providers/app_providers.dart';
import 'presentation/settings/settings_controller.dart';
import 'presentation/shell/home_shell.dart';
import 'presentation/theme/app_theme.dart';

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();

  // Open the database once and seed first-run defaults before the UI builds, so
  // the Today screen has habits to work with immediately.
  final database = AppDatabase();
  await seedDefaultHabitsIfEmpty(database);
  await seedBiblePlanIfEmpty(database);

  runApp(
    ProviderScope(
      // Inject the concrete database; everything else resolves through it.
      overrides: [appDatabaseProvider.overrideWithValue(database)],
      child: const PersonalOsApp(),
    ),
  );
}

class PersonalOsApp extends StatelessWidget {
  const PersonalOsApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'ME · Personal OS',
      debugShowCheckedModeBanner: false,
      theme: AppTheme.light(),
      darkTheme: AppTheme.dark(),
      home: const _RootGate(),
    );
  }
}

/// Decides the first screen once settings load: onboarding for new users,
/// otherwise the main app. Shows a brief spinner while settings are read.
class _RootGate extends ConsumerWidget {
  const _RootGate();

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final settings = ref.watch(settingsControllerProvider);
    return settings.when(
      loading: () =>
          const Scaffold(body: Center(child: CircularProgressIndicator())),
      error: (e, _) => Scaffold(body: Center(child: Text('$e'))),
      data: (s) =>
          s.onboardingComplete ? const HomeShell() : const OnboardingScreen(),
    );
  }
}
