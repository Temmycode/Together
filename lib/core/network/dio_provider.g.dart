// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'dio_provider.dart';

// **************************************************************************
// RiverpodGenerator
// **************************************************************************

// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint, type=warning
/// The app's single, configured [Dio] client.
///
/// Built from the active [appConfigProvider] (base URL + timeouts) and kept
/// alive for the app's lifetime. Feature data sources depend on this directly
/// — there is no extra wrapper layer over Dio.

@ProviderFor(dio)
final dioProvider = DioProvider._();

/// The app's single, configured [Dio] client.
///
/// Built from the active [appConfigProvider] (base URL + timeouts) and kept
/// alive for the app's lifetime. Feature data sources depend on this directly
/// — there is no extra wrapper layer over Dio.

final class DioProvider extends $FunctionalProvider<Dio, Dio, Dio>
    with $Provider<Dio> {
  /// The app's single, configured [Dio] client.
  ///
  /// Built from the active [appConfigProvider] (base URL + timeouts) and kept
  /// alive for the app's lifetime. Feature data sources depend on this directly
  /// — there is no extra wrapper layer over Dio.
  DioProvider._()
    : super(
        from: null,
        argument: null,
        retry: null,
        name: r'dioProvider',
        isAutoDispose: false,
        dependencies: null,
        $allTransitiveDependencies: null,
      );

  @override
  String debugGetCreateSourceHash() => _$dioHash();

  @$internal
  @override
  $ProviderElement<Dio> $createElement($ProviderPointer pointer) =>
      $ProviderElement(pointer);

  @override
  Dio create(Ref ref) {
    return dio(ref);
  }

  /// {@macro riverpod.override_with_value}
  Override overrideWithValue(Dio value) {
    return $ProviderOverride(
      origin: this,
      providerOverride: $SyncValueProvider<Dio>(value),
    );
  }
}

String _$dioHash() => r'e65726d3b4cb56a843ee2e35a8b5c1d844c1eb9e';
