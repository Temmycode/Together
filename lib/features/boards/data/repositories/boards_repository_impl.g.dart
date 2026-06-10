// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'boards_repository_impl.dart';

// **************************************************************************
// RiverpodGenerator
// **************************************************************************

// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint, type=warning
/// Binds the [BoardsRepository] interface to its implementation. Controllers
/// watch this and receive the interface type.

@ProviderFor(boardsRepository)
final boardsRepositoryProvider = BoardsRepositoryProvider._();

/// Binds the [BoardsRepository] interface to its implementation. Controllers
/// watch this and receive the interface type.

final class BoardsRepositoryProvider
    extends
        $FunctionalProvider<
          BoardsRepository,
          BoardsRepository,
          BoardsRepository
        >
    with $Provider<BoardsRepository> {
  /// Binds the [BoardsRepository] interface to its implementation. Controllers
  /// watch this and receive the interface type.
  BoardsRepositoryProvider._()
    : super(
        from: null,
        argument: null,
        retry: null,
        name: r'boardsRepositoryProvider',
        isAutoDispose: true,
        dependencies: null,
        $allTransitiveDependencies: null,
      );

  @override
  String debugGetCreateSourceHash() => _$boardsRepositoryHash();

  @$internal
  @override
  $ProviderElement<BoardsRepository> $createElement($ProviderPointer pointer) =>
      $ProviderElement(pointer);

  @override
  BoardsRepository create(Ref ref) {
    return boardsRepository(ref);
  }

  /// {@macro riverpod.override_with_value}
  Override overrideWithValue(BoardsRepository value) {
    return $ProviderOverride(
      origin: this,
      providerOverride: $SyncValueProvider<BoardsRepository>(value),
    );
  }
}

String _$boardsRepositoryHash() => r'eee5f87a9079361ba0f6433fef5bead7e59769e6';
