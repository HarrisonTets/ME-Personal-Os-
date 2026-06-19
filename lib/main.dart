import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import 'data/local/app_database.dart';
import 'data/local/bible_seed.dart';
import 'data/local/seed.dart';
import 'presentation/providers/app_providers.dart';
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
      home: const HomeShell(),
    );
  }
}
