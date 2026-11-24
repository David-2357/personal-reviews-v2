import 'package:flutter/material.dart';
import 'package:personal_reviews/core/types/menu_action.dart';
import 'package:personal_reviews/core/extensions/theme_context.dart';
import 'package:personal_reviews/shared/widgets/menu_anchor/menu_anchor.dart';
import 'package:personal_reviews/style/design_system/app_spacing.dart';

class SecondaryLayout extends StatelessWidget {
  final Widget child;
  final String? title;
  final bool scrollable;
  final List<MenuAction> actions;
  final Widget? floatingActionButton;
  final FloatingActionButtonLocation? floatingActionButtonLocation;

  const SecondaryLayout({
    super.key,
    required this.child,
    this.title,
    this.scrollable = true,
    this.actions = const [],
    this.floatingActionButton,
    this.floatingActionButtonLocation,
  });

  @override
  Widget build(BuildContext context) {
    final Color onSurfaceColor = context.colors.onSurface;
    final SafeArea body = SafeArea(
      child: Padding(padding: AppInsets.pageInsets, child: child),
    );

    return Scaffold(
      floatingActionButton: floatingActionButton,
      floatingActionButtonLocation: floatingActionButtonLocation,
      appBar: AppBar(
        toolbarHeight: 40,
        title: Text(
          title ?? 'Secondary Layout',
          style: context.textTheme.bodyMedium,
        ),
        centerTitle: true,
        backgroundColor: context.colors.surface,
        foregroundColor: onSurfaceColor,
        leading: IconButton(
          icon: const Icon(Icons.arrow_back),
          onPressed: () {
            final navigator = Navigator.of(context);
            if (navigator.canPop()) {
              navigator.pop();
            } else {
              navigator.pushReplacementNamed('/');
            }
          },
        ),
        actions: actions.isNotEmpty ? [AppMenuAnchor(actions: actions)] : [],
        bottom: PreferredSize(
          preferredSize: const Size.fromHeight(1),
          child: Container(
            height: 1,
            color: onSurfaceColor.withValues(alpha: 0.3),
          ),
        ),
      ),
      body: scrollable ? SingleChildScrollView(child: body) : body,
    );
  }
}
