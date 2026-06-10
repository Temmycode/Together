// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'boards_controller.dart';

// **************************************************************************
// RiverpodGenerator
// **************************************************************************

// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint, type=warning
/// Loads the user's boards as an `AsyncValue`.
///
/// Unwraps the repository [Result] and re-throws the [Failure] so it surfaces as
/// `AsyncError` — the Result↔AsyncValue bridge the UI consumes via `.when(...)`.

@ProviderFor(BoardsController)
final boardsControllerProvider = BoardsControllerProvider._();

/// Loads the user's boards as an `AsyncValue`.
///
/// Unwraps the repository [Result] and re-throws the [Failure] so it surfaces as
/// `AsyncError` — the Result↔AsyncValue bridge the UI consumes via `.when(...)`.
final class BoardsControllerProvider
    extends $AsyncNotifierProvider<BoardsController, List<Board>> {
  /// Loads the user's boards as an `AsyncValue`.
  ///
  /// Unwraps the repository [Result] and re-throws the [Failure] so it surfaces as
  /// `AsyncError` — the Result↔AsyncValue bridge the UI consumes via `.when(...)`.
  BoardsControllerProvider._()
    : super(
        from: null,
        argument: null,
        retry: null,
        name: r'boardsControllerProvider',
        isAutoDispose: true,
        dependencies: null,
        $allTransitiveDependencies: null,
      );

  @override
  String debugGetCreateSourceHash() => _$boardsControllerHash();

  @$internal
  @override
  BoardsController create() => BoardsController();
}

String _$boardsControllerHash() => r'9838f50ffc2f0b9d67cc58c45408238af4cf0a31';

/// Loads the user's boards as an `AsyncValue`.
///
/// Unwraps the repository [Result] and re-throws the [Failure] so it surfaces as
/// `AsyncError` — the Result↔AsyncValue bridge the UI consumes via `.when(...)`.

abstract class _$BoardsController extends $AsyncNotifier<List<Board>> {
  FutureOr<List<Board>> build();
  @$mustCallSuper
  @override
  void runBuild() {
    final ref = this.ref as $Ref<AsyncValue<List<Board>>, List<Board>>;
    final element =
        ref.element
            as $ClassProviderElement<
              AnyNotifier<AsyncValue<List<Board>>, List<Board>>,
              AsyncValue<List<Board>>,
              Object?,
              Object?
            >;
    element.handleCreate(ref, build);
  }
}
