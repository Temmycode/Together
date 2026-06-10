import 'package:shared_preferences/shared_preferences.dart';
import 'package:together/core/storage/key_value_store.dart';

/// [KeyValueStore] backed by `SharedPreferences`.
///
/// The [SharedPreferences] instance is resolved once in `bootstrap()` and
/// injected, so every getter here is synchronous.
class SharedPrefsStore implements KeyValueStore {
  const SharedPrefsStore(this._prefs);

  final SharedPreferences _prefs;

  @override
  String? getString(String key) => _prefs.getString(key);

  @override
  Future<void> setString(String key, String value) =>
      _prefs.setString(key, value);

  @override
  bool? getBool(String key) => _prefs.getBool(key);

  @override
  Future<void> setBool(String key, bool value) => _prefs.setBool(key, value);

  @override
  int? getInt(String key) => _prefs.getInt(key);

  @override
  Future<void> setInt(String key, int value) => _prefs.setInt(key, value);

  @override
  bool containsKey(String key) => _prefs.containsKey(key);

  @override
  Future<void> remove(String key) => _prefs.remove(key);

  @override
  Future<void> clear() => _prefs.clear();
}
