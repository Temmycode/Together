// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'storage_provider.dart';

// **************************************************************************
// RiverpodGenerator
// **************************************************************************

// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint, type=warning
/// The resolved [SharedPreferences] instance.
///
/// Overridden in `bootstrap()` after `SharedPreferences.getInstance()`; reading
/// it without that override is a programming error, so it fails loud.

@ProviderFor(sharedPreferences)
final sharedPreferencesProvider = SharedPreferencesProvider._();

/// The resolved [SharedPreferences] instance.
///
/// Overridden in `bootstrap()` after `SharedPreferences.getInstance()`; reading
/// it without that override is a programming error, so it fails loud.

final class SharedPreferencesProvider
    extends
        $FunctionalProvider<
          SharedPreferences,
          SharedPreferences,
          SharedPreferences
        >
    with $Provider<SharedPreferences> {
  /// The resolved [SharedPreferences] instance.
  ///
  /// Overridden in `bootstrap()` after `SharedPreferences.getInstance()`; reading
  /// it without that override is a programming error, so it fails loud.
  SharedPreferencesProvider._()
    : super(
        from: null,
        argument: null,
        retry: null,
        name: r'sharedPreferencesProvider',
        isAutoDispose: false,
        dependencies: null,
        $allTransitiveDependencies: null,
      );

  @override
  String debugGetCreateSourceHash() => _$sharedPreferencesHash();

  @$internal
  @override
  $ProviderElement<SharedPreferences> $createElement(
    $ProviderPointer pointer,
  ) => $ProviderElement(pointer);

  @override
  SharedPreferences create(Ref ref) {
    return sharedPreferences(ref);
  }

  /// {@macro riverpod.override_with_value}
  Override overrideWithValue(SharedPreferences value) {
    return $ProviderOverride(
      origin: this,
      providerOverride: $SyncValueProvider<SharedPreferences>(value),
    );
  }
}

String _$sharedPreferencesHash() => r'd89abbdc375d4a4f7b611a732857425457cbb5c3';

/// App-wide key–value store. Inject this (not [sharedPreferences]) so callers
/// depend on the [KeyValueStore] abstraction.

@ProviderFor(keyValueStore)
final keyValueStoreProvider = KeyValueStoreProvider._();

/// App-wide key–value store. Inject this (not [sharedPreferences]) so callers
/// depend on the [KeyValueStore] abstraction.

final class KeyValueStoreProvider
    extends $FunctionalProvider<KeyValueStore, KeyValueStore, KeyValueStore>
    with $Provider<KeyValueStore> {
  /// App-wide key–value store. Inject this (not [sharedPreferences]) so callers
  /// depend on the [KeyValueStore] abstraction.
  KeyValueStoreProvider._()
    : super(
        from: null,
        argument: null,
        retry: null,
        name: r'keyValueStoreProvider',
        isAutoDispose: false,
        dependencies: null,
        $allTransitiveDependencies: null,
      );

  @override
  String debugGetCreateSourceHash() => _$keyValueStoreHash();

  @$internal
  @override
  $ProviderElement<KeyValueStore> $createElement($ProviderPointer pointer) =>
      $ProviderElement(pointer);

  @override
  KeyValueStore create(Ref ref) {
    return keyValueStore(ref);
  }

  /// {@macro riverpod.override_with_value}
  Override overrideWithValue(KeyValueStore value) {
    return $ProviderOverride(
      origin: this,
      providerOverride: $SyncValueProvider<KeyValueStore>(value),
    );
  }
}

String _$keyValueStoreHash() => r'd03cb158120caf2a6b1bb0509e8b795239701c11';
