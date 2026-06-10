import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import 'package:together/core/error/result.dart';
import 'package:together/core/responsive/context_extensions.dart';
import 'package:together/core/router/routes.dart';
import 'package:together/core/widgets/app_error_view.dart';
import 'package:together/core/widgets/app_loader.dart';
import 'package:together/features/boards/domain/entities/board.dart';
import 'package:together/features/boards/presentation/controllers/board_posts_controller.dart';
import 'package:together/features/boards/presentation/controllers/boards_controller.dart';
import 'package:together/features/boards/presentation/widgets/collage_board.dart';

/// Signature screen #1: a board's posts as an organic pinboard collage, with a
/// "View moments" entry into the swipe viewer.
class BoardCollageScreen extends ConsumerWidget {
  const BoardCollageScreen({super.key, required this.boardId});

  final String boardId;

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final postsAsync = ref.watch(boardPostsControllerProvider(boardId));
    final board = _findBoard(ref);

    return Scaffold(
      backgroundColor: Theme.of(context).colorScheme.surfaceContainerLow,
      appBar: AppBar(
        title: Text(board?.name ?? 'Board'),
        backgroundColor: Theme.of(context).colorScheme.surfaceContainerLow,
      ),
      floatingActionButton: FloatingActionButton.extended(
        onPressed: () => context.push(Routes.boardViewerPath(boardId)),
        icon: const Icon(Icons.play_arrow_rounded),
        label: const Text('View moments'),
      ),
      body: postsAsync.when(
        loading: () => const AppLoader(),
        error: (error, _) => AppErrorView(
          message: error is Failure ? error.message : 'Could not load this board.',
          onRetry: () =>
              ref.read(boardPostsControllerProvider(boardId).notifier).refresh(),
        ),
        data: (posts) => Column(
          children: [
            if (board?.prompt != null) _PromptBanner(prompt: board!.prompt!),
            Expanded(
              child: CollageBoard(
                posts: posts,
                onTapPost: (_) => context.push(Routes.boardViewerPath(boardId)),
              ),
            ),
          ],
        ),
      ),
    );
  }

  /// The board (for its name + prompt) from the already-loaded home list, if
  /// present. Falls back to a generic title otherwise.
  Board? _findBoard(WidgetRef ref) {
    final boards = ref.watch(boardsControllerProvider).value;
    if (boards == null) return null;
    for (final board in boards) {
      if (board.id == boardId) return board;
    }
    return null;
  }
}

class _PromptBanner extends StatelessWidget {
  const _PromptBanner({required this.prompt});

  final String prompt;

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    return Padding(
      padding: EdgeInsets.fromLTRB(
        context.w(20),
        context.h(8),
        context.w(20),
        context.h(4),
      ),
      child: Row(
        children: [
          Icon(
            Icons.lightbulb_outline,
            size: context.sp(18),
            color: theme.colorScheme.primary,
          ),
          SizedBox(width: context.w(8)),
          Expanded(
            child: Text(
              prompt,
              style: theme.textTheme.titleSmall?.copyWith(
                color: theme.colorScheme.onSurfaceVariant,
              ),
            ),
          ),
        ],
      ),
    );
  }
}
