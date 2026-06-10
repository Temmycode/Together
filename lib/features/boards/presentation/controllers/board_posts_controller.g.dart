// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'board_posts_controller.dart';

// **************************************************************************
// RiverpodGenerator
// **************************************************************************

// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint, type=warning
/// Loads the posts for a single board (family, keyed by [boardId]).
///
/// Same Result↔AsyncValue bridge as [BoardsController]. The view-once filtering
/// lives in `unseenBoardPostsProvider`, not here — this controller always
/// exposes the full board.

@ProviderFor(BoardPostsController)
final boardPostsControllerProvider = BoardPostsControllerFamily._();

/// Loads the posts for a single board (family, keyed by [boardId]).
///
/// Same Result↔AsyncValue bridge as [BoardsController]. The view-once filtering
/// lives in `unseenBoardPostsProvider`, not here — this controller always
/// exposes the full board.
final class BoardPostsControllerProvider
    extends $AsyncNotifierProvider<BoardPostsController, List<BoardPost>> {
  /// Loads the posts for a single board (family, keyed by [boardId]).
  ///
  /// Same Result↔AsyncValue bridge as [BoardsController]. The view-once filtering
  /// lives in `unseenBoardPostsProvider`, not here — this controller always
  /// exposes the full board.
  BoardPostsControllerProvider._({
    required BoardPostsControllerFamily super.from,
    required String super.argument,
  }) : super(
         retry: null,
         name: r'boardPostsControllerProvider',
         isAutoDispose: true,
         dependencies: null,
         $allTransitiveDependencies: null,
       );

  @override
  String debugGetCreateSourceHash() => _$boardPostsControllerHash();

  @override
  String toString() {
    return r'boardPostsControllerProvider'
        ''
        '($argument)';
  }

  @$internal
  @override
  BoardPostsController create() => BoardPostsController();

  @override
  bool operator ==(Object other) {
    return other is BoardPostsControllerProvider && other.argument == argument;
  }

  @override
  int get hashCode {
    return argument.hashCode;
  }
}

String _$boardPostsControllerHash() =>
    r'543642f69656f4957861fb0d3fa2c5d6eece1f22';

/// Loads the posts for a single board (family, keyed by [boardId]).
///
/// Same Result↔AsyncValue bridge as [BoardsController]. The view-once filtering
/// lives in `unseenBoardPostsProvider`, not here — this controller always
/// exposes the full board.

final class BoardPostsControllerFamily extends $Family
    with
        $ClassFamilyOverride<
          BoardPostsController,
          AsyncValue<List<BoardPost>>,
          List<BoardPost>,
          FutureOr<List<BoardPost>>,
          String
        > {
  BoardPostsControllerFamily._()
    : super(
        retry: null,
        name: r'boardPostsControllerProvider',
        dependencies: null,
        $allTransitiveDependencies: null,
        isAutoDispose: true,
      );

  /// Loads the posts for a single board (family, keyed by [boardId]).
  ///
  /// Same Result↔AsyncValue bridge as [BoardsController]. The view-once filtering
  /// lives in `unseenBoardPostsProvider`, not here — this controller always
  /// exposes the full board.

  BoardPostsControllerProvider call(String boardId) =>
      BoardPostsControllerProvider._(argument: boardId, from: this);

  @override
  String toString() => r'boardPostsControllerProvider';
}

/// Loads the posts for a single board (family, keyed by [boardId]).
///
/// Same Result↔AsyncValue bridge as [BoardsController]. The view-once filtering
/// lives in `unseenBoardPostsProvider`, not here — this controller always
/// exposes the full board.

abstract class _$BoardPostsController extends $AsyncNotifier<List<BoardPost>> {
  late final _$args = ref.$arg as String;
  String get boardId => _$args;

  FutureOr<List<BoardPost>> build(String boardId);
  @$mustCallSuper
  @override
  void runBuild() {
    final ref = this.ref as $Ref<AsyncValue<List<BoardPost>>, List<BoardPost>>;
    final element =
        ref.element
            as $ClassProviderElement<
              AnyNotifier<AsyncValue<List<BoardPost>>, List<BoardPost>>,
              AsyncValue<List<BoardPost>>,
              Object?,
              Object?
            >;
    element.handleCreate(ref, () => build(_$args));
  }
}
