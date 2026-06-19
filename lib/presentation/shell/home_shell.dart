import 'package:flutter/material.dart';

import '../bible/bible_home_screen.dart';
import '../finance/finance_home_screen.dart';
import '../focus/focus_home_screen.dart';
import '../health/health_home_screen.dart';
import '../today/today_screen.dart';

/// The app's top-level frame: a bottom navigation bar that switches between the
/// main sections. Each tab keeps its own state because we use an [IndexedStack]
/// (all tabs stay alive; we just show one at a time).
///
/// New pillars get added here as we build them.
class HomeShell extends StatefulWidget {
  const HomeShell({super.key});

  @override
  State<HomeShell> createState() => _HomeShellState();
}

class _HomeShellState extends State<HomeShell> {
  int _index = 0;

  static const _tabs = <Widget>[
    TodayScreen(),
    BibleHomeScreen(),
    FinanceHomeScreen(),
    FocusHomeScreen(),
    HealthHomeScreen(),
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: IndexedStack(index: _index, children: _tabs),
      bottomNavigationBar: NavigationBar(
        selectedIndex: _index,
        onDestinationSelected: (i) => setState(() => _index = i),
        destinations: const [
          NavigationDestination(
            icon: Icon(Icons.today_outlined),
            selectedIcon: Icon(Icons.today),
            label: 'Today',
          ),
          NavigationDestination(
            icon: Icon(Icons.auto_stories_outlined),
            selectedIcon: Icon(Icons.auto_stories),
            label: 'Bible',
          ),
          NavigationDestination(
            icon: Icon(Icons.account_balance_wallet_outlined),
            selectedIcon: Icon(Icons.account_balance_wallet),
            label: 'Finance',
          ),
          NavigationDestination(
            icon: Icon(Icons.center_focus_strong_outlined),
            selectedIcon: Icon(Icons.center_focus_strong),
            label: 'Focus',
          ),
          NavigationDestination(
            icon: Icon(Icons.favorite_outline),
            selectedIcon: Icon(Icons.favorite),
            label: 'Health',
          ),
        ],
      ),
    );
  }
}
