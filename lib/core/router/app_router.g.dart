// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'app_router.dart';

// **************************************************************************
// RiverpodGenerator
// **************************************************************************

// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint, type=warning
/// The app [GoRouter], exposed as a keep-alive provider so navigation state
/// survives provider rebuilds.
///
/// To add auth-gated routing later, bridge auth state → router *without*
/// rebuilding the GoRouter: pass a `ChangeNotifier` to `refreshListenable` that
/// fires when the auth provider changes, and read auth synchronously inside
/// `redirect` (see the commented sketch below). Do NOT `ref.watch` the auth
/// provider here — that would recreate the router and lose navigation state.

@ProviderFor(goRouter)
final goRouterProvider = GoRouterProvider._();

/// The app [GoRouter], exposed as a keep-alive provider so navigation state
/// survives provider rebuilds.
///
/// To add auth-gated routing later, bridge auth state → router *without*
/// rebuilding the GoRouter: pass a `ChangeNotifier` to `refreshListenable` that
/// fires when the auth provider changes, and read auth synchronously inside
/// `redirect` (see the commented sketch below). Do NOT `ref.watch` the auth
/// provider here — that would recreate the router and lose navigation state.

final class GoRouterProvider
    extends $FunctionalProvider<GoRouter, GoRouter, GoRouter>
    with $Provider<GoRouter> {
  /// The app [GoRouter], exposed as a keep-alive provider so navigation state
  /// survives provider rebuilds.
  ///
  /// To add auth-gated routing later, bridge auth state → router *without*
  /// rebuilding the GoRouter: pass a `ChangeNotifier` to `refreshListenable` that
  /// fires when the auth provider changes, and read auth synchronously inside
  /// `redirect` (see the commented sketch below). Do NOT `ref.watch` the auth
  /// provider here — that would recreate the router and lose navigation state.
  GoRouterProvider._()
    : super(
        from: null,
        argument: null,
        retry: null,
        name: r'goRouterProvider',
        isAutoDispose: false,
        dependencies: null,
        $allTransitiveDependencies: null,
      );

  @override
  String debugGetCreateSourceHash() => _$goRouterHash();

  @$internal
  @override
  $ProviderElement<GoRouter> $createElement($ProviderPointer pointer) =>
      $ProviderElement(pointer);

  @override
  GoRouter create(Ref ref) {
    return goRouter(ref);
  }

  /// {@macro riverpod.override_with_value}
  Override overrideWithValue(GoRouter value) {
    return $ProviderOverride(
      origin: this,
      providerOverride: $SyncValueProvider<GoRouter>(value),
    );
  }
}

String _$goRouterHash() => r'17b99c7461d221722390462497f38f0fa24b12de';
