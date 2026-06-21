import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../bible/bible_home_screen.dart';
import '../finance/finance_home_screen.dart';
import '../focus/focus_home_screen.dart';
import '../health/health_home_screen.dart';
import '../today/today_screen.dart';

/// The currently selected bottom-nav tab. Exposed as a provider so screens
/// (e.g. the Today pillar strip) can switch tabs programmatically.
class HomeTabController extends Notifier<int> {
  @override
  int build() => 0;
  void select(int index) => state = index;
}

final homeTabProvider =
    NotifierProvider<HomeTabController, int>(HomeTabController.new);

/// Tab index for each pillar's section (or null for pillars without a tab, like
/// Learning). Index order matches [_HomeShellState] destinations.
const Map<String, int> pillarTabIndex = {
  'spiritual': 1,
  'finance': 2,
  'focus': 3,
  'health': 4,
};

/// The app's top-level frame: a bottom navigation bar that switches between the
/// main sections. Each tab keeps its own state via an [IndexedStack].
class HomeShell extends ConsumerWidget {
  const HomeShell({super.key});

  static const _tabs = <Widget>[
    TodayScreen(),
    BibleHomeScreen(),
    FinanceHomeScreen(),
    FocusHomeScreen(),
    HealthHomeScreen(),
  ];

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final index = ref.watch(homeTabProvider);

    return Scaffold(
      body: IndexedStack(index: index, children: _tabs),
      bottomNavigationBar: NavigationBar(
        selectedIndex: index,
        onDestinationSelected: ref.read(homeTabProvider.notifier).select,
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
