import 'package:riverpod_annotation/riverpod_annotation.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:together/core/storage/key_value_store.dart';
import 'package:together/core/storage/shared_prefs_store.dart';

part 'storage_provider.g.dart';

/// The resolved [SharedPreferences] instance.
///
/// Overridden in `bootstrap()` after `SharedPreferences.getInstance()`; reading
/// it without that override is a programming error, so it fails loud.
@Riverpod(keepAlive: true)
SharedPreferences sharedPreferences(Ref ref) => throw UnimplementedError(
      'sharedPreferencesProvider must be overridden in bootstrap().',
    );

/// App-wide key–value store. Inject this (not [sharedPreferences]) so callers
/// depend on the [KeyValueStore] abstraction.
@Riverpod(keepAlive: true)
KeyValueStore keyValueStore(Ref ref) =>
    SharedPrefsStore(ref.watch(sharedPreferencesProvider));
