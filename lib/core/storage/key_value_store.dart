/// A minimal key–value persistence abstraction.
///
/// The domain/data layers depend on this interface rather than on
/// `SharedPreferences` directly, so the backing store can be swapped (secure
/// storage, an in-memory fake in tests, …) without touching callers.
abstract interface class KeyValueStore {
  String? getString(String key);
  Future<void> setString(String key, String value);

  bool? getBool(String key);
  Future<void> setBool(String key, bool value);

  int? getInt(String key);
  Future<void> setInt(String key, int value);

  bool containsKey(String key);
  Future<void> remove(String key);
  Future<void> clear();
}
