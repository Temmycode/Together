import 'package:flutter/material.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';
import 'package:together/core/storage/storage_provider.dart';

part 'theme_provider.g.dart';

/// Holds the user's [ThemeMode], persisted across launches via the
/// [keyValueStore]. Defaults to [ThemeMode.system].
@riverpod
class ThemeModeController extends _$ThemeModeController {
  static const String _key = 'theme_mode';

  @override
  ThemeMode build() =>
      _decode(ref.watch(keyValueStoreProvider).getString(_key));

  Future<void> setMode(ThemeMode mode) async {
    state = mode;
    await ref.read(keyValueStoreProvider).setString(_key, mode.name);
  }

  Future<void> toggle() =>
      setMode(state == ThemeMode.dark ? ThemeMode.light : ThemeMode.dark);

  ThemeMode _decode(String? value) => switch (value) {
        'light' => ThemeMode.light,
        'dark' => ThemeMode.dark,
        _ => ThemeMode.system,
      };
}
