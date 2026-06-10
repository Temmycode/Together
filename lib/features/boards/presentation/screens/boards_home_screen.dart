import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import 'package:together/core/error/result.dart';
import 'package:together/core/responsive/context_extensions.dart';
import 'package:together/core/router/routes.dart';
import 'package:together/core/theme/theme_provider.dart';
import 'package:together/core/widgets/app_error_view.dart';
import 'package:together/core/widgets/app_loader.dart';
import 'package:together/features/boards/presentation/controllers/boards_controller.dart';
import 'package:together/features/boards/presentation/widgets/board_list_card.dart';

/// Home: the user's boards as a scrollable list, each previewed as a small
/// collage pile. Tapping a board opens its full collage overview.
class BoardsHomeScreen extends ConsumerWidget {
  const BoardsHomeScreen({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final boardsAsync = ref.watch(boardsControllerProvider);
    return Scaffold(
      appBar: AppBar(
        title: const Text('Together'),
        actions: [
          IconButton(
            tooltip: 'Toggle theme',
            icon: const Icon(Icons.brightness_6_outlined),
            onPressed: () =>
                ref.read(themeModeControllerProvider.notifier).toggle(),
          ),
        ],
      ),
      body: boardsAsync.when(
        loading: () => const AppLoader(),
        error: (error, _) => AppErrorView(
          message: error is Failure ? error.message : 'Could not load boards.',
          onRetry: () => ref.read(boardsControllerProvider.notifier).refresh(),
        ),
        data: (boards) => RefreshIndicator(
          onRefresh: () => ref.read(boardsControllerProvider.notifier).refresh(),
          child: boards.isEmpty
              ? _EmptyBoards()
              : ListView.separated(
                  padding: EdgeInsets.all(context.w(16)),
                  physics: const AlwaysScrollableScrollPhysics(),
                  itemCount: boards.length,
                  separatorBuilder: (_, _) => SizedBox(height: context.h(12)),
                  itemBuilder: (context, index) {
                    final board = boards[index];
                    return BoardListCard(
                      board: board,
                      onTap: () =>
                          context.push(Routes.boardCollagePath(board.id)),
                    );
                  },
                ),
        ),
      ),
    );
  }
}

class _EmptyBoards extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return ListView(
      physics: const AlwaysScrollableScrollPhysics(),
      children: [
        SizedBox(height: context.h(160)),
        Center(
          child: Text(
            'No boards yet',
            style: Theme.of(context).textTheme.bodyLarge,
          ),
        ),
      ],
    );
  }
}
