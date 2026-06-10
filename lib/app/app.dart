import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:together/core/config/app_config_provider.dart';
import 'package:together/core/router/app_router.dart';
import 'package:together/core/theme/app_theme.dart';
import 'package:together/core/theme/theme_provider.dart';

/// Root widget: wires the router and theme, and applies a global clamp on user
/// text scaling so accessibility font settings never break layouts.
class TogetherApp extends ConsumerWidget {
  const TogetherApp({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final router = ref.watch(goRouterProvider);
    final themeMode = ref.watch(themeModeControllerProvider);
    final appName = ref.watch(appConfigProvider).appName;

    return MaterialApp.router(
      title: appName,
      debugShowCheckedModeBanner: false,
      theme: AppTheme.light,
      darkTheme: AppTheme.dark,
      themeMode: themeMode,
      routerConfig: router,
      builder: (context, child) => MediaQuery.withClampedTextScaling(
        minScaleFactor: 0.85,
        maxScaleFactor: 1.3,
        child: child ?? const SizedBox.shrink(),
      ),
    );
  }
}
