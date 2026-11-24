import 'package:personal_reviews/features/app_shell/components/main_appbar.dart';
import 'package:personal_reviews/shared/components/app_main_floating_buttons.dart';
import 'package:personal_reviews/style/design_system/app_radius.dart';
import 'package:personal_reviews/style/design_system/app_spacing.dart';
import 'package:personal_reviews/core/extensions/theme_context.dart';
import 'package:personal_reviews/style/design_system/app_size.dart';
import 'package:personal_reviews/core/types/page_config.dart';
import 'package:personal_reviews/features/home/app_home.dart';
import 'package:flutter/material.dart';

class AppShell extends StatefulWidget {
  const AppShell({super.key});

  @override
  State<AppShell> createState() => _AppShellState();
}

class _AppShellState extends State<AppShell> {
  int currentPageIndex = 1;

  late final List<PageConfig> pages = [
    PageConfig(
      title: 'Resumen',
      child: Center(child: Text('Resumen')),
    ),
    PageConfig(title: 'Reseñas', child: AppHomeGroups(), scrollable: false),
    PageConfig(
      title: 'Ajustes',
      child: Center(child: Text('Ajustes')),
    ),
  ];

  @override
  Widget build(BuildContext context) {
    final currentPage = pages[currentPageIndex];

    Widget body = SafeArea(
      child: Padding(padding: AppInsets.pageInsets, child: currentPage.child),
    );

    if (currentPage.scrollable) {
      body = SingleChildScrollView(child: body);
    }

    NavigationDestination buildNavigationDestination({
      required IconData icon,
      required String label,
    }) {
      return NavigationDestination(
        icon: Icon(icon, size: AppSizes.mainNavigationIconSize),
        selectedIcon: Icon(
          icon,
          size: AppSizes.mainNavigationIconSize,
          color: context.colors.primary,
        ),
        label: label,
      );
    }

    return Scaffold(
      extendBody: true,
      extendBodyBehindAppBar: true,

      floatingActionButton: AppMainFloatingButtons(),

      appBar: MainAppBar(title: currentPage.title),

      bottomNavigationBar: NavigationBar(
        // style
        indicatorColor: context.colors.primary.withValues(alpha: 0.24),
        indicatorShape: RoundedRectangleBorder(borderRadius: AppRadius.md),
        maintainBottomViewPadding: false,
        labelTextStyle: WidgetStateProperty.resolveWith((
          Set<WidgetState> states,
        ) {
          if (states.contains(WidgetState.selected)) {
            return context.textTheme.bodySmall?.copyWith(
              fontWeight: FontWeight.bold,
            );
          }
          return context.textTheme.bodySmall;
        }),

        // behavior
        onDestinationSelected: (int index) {
          setState(() {
            currentPageIndex = index;
          });
        },
        selectedIndex: currentPageIndex,
        destinations: <Widget>[
          buildNavigationDestination(icon: Icons.leaderboard, label: 'Resumen'),
          buildNavigationDestination(
            icon: Icons.star_rounded,
            label: 'Reseñas',
          ),
          buildNavigationDestination(icon: Icons.settings, label: 'Ajustes'),
        ],
      ),
      body: body,
    );
  }
}
