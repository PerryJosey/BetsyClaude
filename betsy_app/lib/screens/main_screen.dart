import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../core/theme/app_theme.dart';
import '../features/home/home_screen.dart';
import '../features/profile/screens/profile_screen.dart';
import '../providers/main_tab_provider.dart';

class MainScreen extends ConsumerWidget {
  const MainScreen({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final currentIndex = ref.watch(mainTabIndexProvider);

    final tabs = <Widget>[
      const HomeScreen(),
      const ProfileScreen(),
    ];

    return Scaffold(
      body: IndexedStack(
        index: currentIndex,
        children: tabs,
      ),
      bottomNavigationBar: SafeArea(
        top: false,
        child: Container(
          decoration: BoxDecoration(
            color: AppTheme.cardBackground,
            boxShadow: [
              BoxShadow(
                color: AppTheme.slate.withValues(alpha: 0.08),
                blurRadius: 8,
                offset: const Offset(0, -2),
              ),
            ],
          ),
          child: SizedBox(
            height: 64,
            child: BottomNavigationBar(
              currentIndex: currentIndex,
              type: BottomNavigationBarType.fixed,
              backgroundColor: AppTheme.cardBackground,
              elevation: 0,
              selectedItemColor: AppTheme.slate,
              unselectedItemColor: AppTheme.textMuted,
              selectedLabelStyle: const TextStyle(fontSize: 12, fontWeight: FontWeight.w600),
              unselectedLabelStyle: const TextStyle(fontSize: 12),
              onTap: (index) {
                ref.read(mainTabIndexProvider.notifier).state = index;
              },
              items: const [
                BottomNavigationBarItem(
                  icon: Icon(Icons.home_rounded, size: 28),
                  label: 'Home',
                ),
                BottomNavigationBarItem(
                  icon: Icon(Icons.person_rounded, size: 28),
                  label: 'Profile',
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
