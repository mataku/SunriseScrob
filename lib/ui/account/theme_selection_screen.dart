import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:sunrisescrob/ui/common/theme_notifier.dart';
import 'package:sunrisescrob/ui/theme/app_theme.dart';

class ThemeSelectionScreen extends ConsumerWidget {
  const ThemeSelectionScreen({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final themeNotifier = ref.watch(themeNotifierProvider);
    final currentTheme = themeNotifier.appTheme ?? AppTheme.dark;

    return SafeArea(
      child: Scaffold(
        appBar: AppBar(
          title: const Text('Theme'),
        ),
        body: _ThemeSelectionContent(
          currentTheme: currentTheme,
          onTap: (theme) {
            themeNotifier.setCurrentTheme(theme);
          },
        ),
      ),
    );
  }
}

class _ThemeSelectionContent extends StatelessWidget {
  final AppTheme currentTheme;
  final void Function(AppTheme) onTap;

  const _ThemeSelectionContent({
    required this.currentTheme,
    required this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    return Column(
      children: AppTheme.values
          .map(
            (theme) => _ThemeSelection(
              appTheme: theme,
              selected: currentTheme == theme,
              onTap: () {
                if (currentTheme == theme) {
                  return;
                }
                onTap(theme);
              },
            ),
          )
          .toList(),
    );
  }
}

class _ThemeSelection extends StatelessWidget {
  final AppTheme appTheme;
  final bool selected;
  final VoidCallback onTap;

  const _ThemeSelection({
    required this.appTheme,
    required this.selected,
    required this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    return GestureDetector(
      behavior: HitTestBehavior.opaque,
      onTap: onTap,
      child: Padding(
        padding: const EdgeInsets.only(
          left: 16,
          right: 16,
          top: 16,
          bottom: 16,
        ),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            Text(
              appTheme.label,
              style: TextStyle(
                fontWeight: FontWeight.bold,
              ),
            ),
            if (selected)
              Icon(
                Icons.check,
                size: 20,
                color: theme.colorScheme.onSurface,
              ),
          ],
        ),
      ),
    );
  }
}
