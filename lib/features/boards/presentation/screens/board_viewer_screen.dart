import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import 'package:together/core/error/result.dart';
import 'package:together/core/responsive/context_extensions.dart';
import 'package:together/core/widgets/app_error_view.dart';
import 'package:together/core/widgets/app_loader.dart';
import 'package:together/features/boards/presentation/controllers/board_posts_controller.dart';
import 'package:together/features/boards/presentation/controllers/boards_controller.dart';
import 'package:together/features/boards/presentation/controllers/seen_board_posts.dart';
import 'package:together/features/boards/presentation/widgets/swipe_card_stack.dart';

/// Signature screen #2: full-screen, view-once swipe viewer. Shows only the
/// posts the user hasn't already swiped past this session; swiping a card marks
/// it seen so it never returns. Minimal, dark chrome to keep focus on content.
class BoardViewerScreen extends ConsumerWidget {
  const BoardViewerScreen({super.key, required this.boardId});

  final String boardId;

  // A soft vertical gradient gives the dark canvas depth without adding chrome.
  static const Color _bgTop = Color(0xFF17171F);
  static const Color _bgBottom = Color(0xFF0B0B0F);

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final postsAsync = ref.watch(boardPostsControllerProvider(boardId));

    return Scaffold(
      backgroundColor: _bgBottom,
      body: DecoratedBox(
        decoration: const BoxDecoration(
          gradient: LinearGradient(
            begin: Alignment.topCenter,
            end: Alignment.bottomCenter,
            colors: [_bgTop, _bgBottom],
          ),
        ),
        child: SafeArea(
          child: postsAsync.when(
            loading: () => const AppLoader(),
            error: (error, _) => AppErrorView(
              message: error is Failure
                  ? error.message
                  : 'Could not load this board.',
              onRetry: () => ref
                  .read(boardPostsControllerProvider(boardId).notifier)
                  .refresh(),
            ),
            data: (allPosts) {
              final unseen = ref.watch(unseenBoardPostsProvider(boardId));
              final total = allPosts.length;
              final viewed = total - unseen.length;
              return Column(
                children: [
                  _ViewerHeader(
                    title: _boardName(ref),
                    total: total,
                    viewed: viewed,
                  ),
                  Expanded(
                    child: unseen.isEmpty
                        ? const _AllCaughtUp()
                        : Stack(
                            children: [
                              Positioned.fill(
                                child: SwipeCardStack(
                                  posts: unseen,
                                  onSwiped: (post) => ref
                                      .read(seenBoardPostsProvider.notifier)
                                      .markSeen(post.id),
                                ),
                              ),
                              // A one-time nudge that also teaches the rule.
                              if (viewed == 0)
                                Positioned(
                                  left: 0,
                                  right: 0,
                                  bottom: context.h(14),
                                  child: const _SwipeHint(),
                                ),
                            ],
                          ),
                  ),
                ],
              );
            },
          ),
        ),
      ),
    );
  }

  /// The board's name from the already-loaded home list, if available.
  String? _boardName(WidgetRef ref) {
    final boards = ref.watch(boardsControllerProvider).value;
    if (boards == null) return null;
    for (final board in boards) {
      if (board.id == boardId) return board.name;
    }
    return null;
  }
}

/// Close control, board name, and a story-style segmented progress bar showing
/// how far through the session's unseen posts the user is.
class _ViewerHeader extends StatelessWidget {
  const _ViewerHeader({
    required this.title,
    required this.total,
    required this.viewed,
  });

  final String? title;
  final int total;
  final int viewed;

  @override
  Widget build(BuildContext context) {
    final buttonSlot = context.w(40);
    return Padding(
      padding: EdgeInsets.fromLTRB(
        context.w(12),
        context.h(10),
        context.w(12),
        context.h(6),
      ),
      child: Column(
        children: [
          Row(
            children: [
              _CircleButton(icon: Icons.close, onTap: () => context.pop()),
              Expanded(
                child: Text(
                  title ?? 'Board',
                  textAlign: TextAlign.center,
                  maxLines: 1,
                  overflow: TextOverflow.ellipsis,
                  style: TextStyle(
                    color: Colors.white,
                    fontSize: context.sp(16),
                    fontWeight: FontWeight.w600,
                  ),
                ),
              ),
              // Balances the close button so the title stays centered.
              SizedBox(width: buttonSlot),
            ],
          ),
          if (total > 0) ...[
            SizedBox(height: context.h(12)),
            _SessionProgress(total: total, viewed: viewed),
          ],
        ],
      ),
    );
  }
}

class _SessionProgress extends StatelessWidget {
  const _SessionProgress({required this.total, required this.viewed});

  final int total;
  final int viewed;

  @override
  Widget build(BuildContext context) {
    final radius = BorderRadius.circular(context.w(2));
    return Row(
      children: [
        for (var i = 0; i < total; i++)
          Expanded(
            child: AnimatedContainer(
              duration: const Duration(milliseconds: 240),
              curve: Curves.easeOut,
              height: context.h(4),
              margin: EdgeInsets.symmetric(horizontal: context.w(2)),
              decoration: BoxDecoration(
                borderRadius: radius,
                color: i < viewed ? Colors.white : Colors.white24,
              ),
            ),
          ),
      ],
    );
  }
}

class _CircleButton extends StatelessWidget {
  const _CircleButton({required this.icon, required this.onTap});

  final IconData icon;
  final VoidCallback onTap;

  @override
  Widget build(BuildContext context) {
    return Material(
      color: Colors.white.withValues(alpha: 0.12),
      shape: const CircleBorder(),
      clipBehavior: Clip.antiAlias,
      child: InkWell(
        onTap: onTap,
        child: Padding(
          padding: EdgeInsets.all(context.w(8)),
          child: Icon(icon, color: Colors.white, size: context.sp(20)),
        ),
      ),
    );
  }
}

/// A subtle, non-interactive hint shown before the first swipe.
class _SwipeHint extends StatelessWidget {
  const _SwipeHint();

  @override
  Widget build(BuildContext context) {
    return IgnorePointer(
      child: TweenAnimationBuilder<double>(
        tween: Tween(begin: 0, end: 1),
        duration: const Duration(milliseconds: 500),
        curve: Curves.easeOut,
        builder: (context, t, child) => Opacity(opacity: t, child: child),
        child: Center(
          child: Container(
            padding: EdgeInsets.symmetric(
              horizontal: context.w(14),
              vertical: context.h(8),
            ),
            decoration: BoxDecoration(
              color: Colors.black.withValues(alpha: 0.35),
              borderRadius: BorderRadius.circular(context.w(20)),
            ),
            child: Row(
              mainAxisSize: MainAxisSize.min,
              children: [
                Icon(
                  Icons.swipe_outlined,
                  color: Colors.white70,
                  size: context.sp(18),
                ),
                SizedBox(width: context.w(8)),
                Flexible(
                  child: Text(
                    'Swipe to view — once only',
                    maxLines: 1,
                    overflow: TextOverflow.ellipsis,
                    style: TextStyle(
                      color: Colors.white70,
                      fontSize: context.sp(13),
                    ),
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}

class _AllCaughtUp extends StatelessWidget {
  const _AllCaughtUp();

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Padding(
        padding: EdgeInsets.symmetric(horizontal: context.w(32)),
        child: TweenAnimationBuilder<double>(
          tween: Tween(begin: 0, end: 1),
          duration: const Duration(milliseconds: 450),
          curve: Curves.easeOutCubic,
          builder: (context, t, child) => Opacity(
            opacity: t,
            child: Transform.translate(
              offset: Offset(0, (1 - t) * context.h(16)),
              child: child,
            ),
          ),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              const _SpentCards(),
              SizedBox(height: context.h(28)),
              Text(
                "You're all caught up",
                style: TextStyle(
                  color: Colors.white,
                  fontSize: context.sp(18),
                  fontWeight: FontWeight.w600,
                ),
              ),
              SizedBox(height: context.h(8)),
              Text(
                'These moments are gone for this session.',
                textAlign: TextAlign.center,
                style: TextStyle(
                  color: Colors.white60,
                  fontSize: context.sp(14),
                ),
              ),
              SizedBox(height: context.h(28)),
              FilledButton.tonal(
                onPressed: () => context.pop(),
                child: const Text('Back to board'),
              ),
            ],
          ),
        ),
      ),
    );
  }
}

/// A fanned trio of empty card outlines — the "spent" cards — with a check badge,
/// echoing the swipe cards the user just cleared.
class _SpentCards extends StatelessWidget {
  const _SpentCards();

  @override
  Widget build(BuildContext context) {
    final cardW = context.w(74);
    final cardH = context.w(98);
    final fan = context.w(20);

    Widget ghost(double angle, double dx) => Transform.translate(
          offset: Offset(dx, 0),
          child: Transform.rotate(
            angle: angle,
            child: Container(
              width: cardW,
              height: cardH,
              decoration: BoxDecoration(
                color: Colors.white.withValues(alpha: 0.04),
                borderRadius: BorderRadius.circular(context.w(16)),
                border: Border.all(color: Colors.white24),
              ),
            ),
          ),
        );

    return SizedBox(
      width: cardW + fan * 2 + context.w(24),
      height: cardH + context.h(20),
      child: Stack(
        alignment: Alignment.center,
        children: [
          ghost(-0.16, -fan),
          ghost(0.16, fan),
          ghost(0, 0),
          Container(
            width: context.w(46),
            height: context.w(46),
            decoration: const BoxDecoration(
              color: Colors.white,
              shape: BoxShape.circle,
            ),
            child: Icon(
              Icons.check_rounded,
              color: const Color(0xFF0E0E12),
              size: context.sp(26),
            ),
          ),
        ],
      ),
    );
  }
}
