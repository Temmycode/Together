import 'package:flutter/material.dart';
import 'package:together/core/responsive/context_extensions.dart';
import 'package:together/features/boards/domain/entities/board_post.dart';
import 'package:together/features/boards/presentation/widgets/swipe_card.dart';

/// A dependency-free, Tinder-style card stack with view-once semantics.
///
/// Only the top card is interactive; the next one or two render as static,
/// scaled "peeks" behind it. Dragging past a threshold (or with enough
/// velocity) flings the top card off-screen, then reports [onSwiped] — never
/// before, so the parent's list doesn't reindex mid-animation. The parent marks
/// the post seen, the unseen list shrinks, and [didUpdateWidget] resets internal
/// state for the new top card. There is no rewind.
class SwipeCardStack extends StatefulWidget {
  const SwipeCardStack({super.key, required this.posts, required this.onSwiped});

  /// The current unseen posts; index 0 is the top card. Treated as a snapshot
  /// for the duration of a single swipe.
  final List<BoardPost> posts;
  final void Function(BoardPost post) onSwiped;

  @override
  State<SwipeCardStack> createState() => _SwipeCardStackState();
}

class _SwipeCardStackState extends State<SwipeCardStack>
    with SingleTickerProviderStateMixin {
  late final AnimationController _ctrl;
  Offset _drag = Offset.zero;
  Animation<Offset>? _fly;

  @override
  void initState() {
    super.initState();
    _ctrl = AnimationController(
      vsync: this,
      duration: const Duration(milliseconds: 280),
    );
  }

  @override
  void didUpdateWidget(covariant SwipeCardStack oldWidget) {
    super.didUpdateWidget(oldWidget);
    final oldTop = oldWidget.posts.isNotEmpty ? oldWidget.posts.first.id : null;
    final newTop = widget.posts.isNotEmpty ? widget.posts.first.id : null;
    if (oldTop != newTop) {
      _ctrl.reset();
      _fly = null;
      _drag = Offset.zero;
    }
  }

  @override
  void dispose() {
    _ctrl.dispose();
    super.dispose();
  }

  void _onPanUpdate(DragUpdateDetails details) {
    if (_ctrl.isAnimating) return;
    setState(() => _drag += details.delta);
  }

  void _onPanEnd(DragEndDetails details) {
    if (_ctrl.isAnimating || widget.posts.isEmpty) return;
    final width = context.size?.width ?? MediaQuery.sizeOf(context).width;
    final velocityX = details.velocity.pixelsPerSecond.dx;
    final passed = _drag.dx.abs() > width * 0.28 || velocityX.abs() > 800;

    if (passed) {
      final direction = (_drag.dx != 0 ? _drag.dx : velocityX).sign;
      final top = widget.posts.first;
      _fly = Tween<Offset>(
        begin: _drag,
        end: Offset(direction * width * 1.6, _drag.dy),
      ).animate(CurvedAnimation(parent: _ctrl, curve: Curves.easeOut));
      _ctrl.forward(from: 0).then((_) {
        if (!mounted) return;
        // Mark seen only now. The parent shrinks the list and didUpdateWidget
        // resets state for the next top card.
        widget.onSwiped(top);
      });
    } else {
      _fly = Tween<Offset>(begin: _drag, end: Offset.zero)
          .animate(CurvedAnimation(parent: _ctrl, curve: Curves.elasticOut));
      _ctrl.forward(from: 0).then((_) {
        if (!mounted) return;
        setState(() {
          _drag = Offset.zero;
          _fly = null;
        });
      });
    }
    setState(() {}); // switch the top card over to the _fly animation
  }

  @override
  Widget build(BuildContext context) {
    final posts = widget.posts;
    if (posts.isEmpty) return const SizedBox.shrink();
    final visible = posts.take(3).toList(growable: false);

    return Stack(
      alignment: Alignment.center,
      children: [
        // Deepest peek first so the top card paints last.
        for (var depth = visible.length - 1; depth >= 1; depth--)
          _peek(context, visible[depth], depth: depth),
        _topCard(context, visible.first),
      ],
    );
  }

  Widget _peek(BuildContext context, BoardPost post, {required int depth}) {
    return Transform.translate(
      offset: Offset(0, context.h(12.0 * depth)),
      child: Transform.scale(
        scale: 1.0 - depth * 0.05,
        child: IgnorePointer(child: _cardFrame(context, post)),
      ),
    );
  }

  Widget _topCard(BuildContext context, BoardPost post) {
    return AnimatedBuilder(
      animation: _ctrl,
      builder: (context, child) {
        final offset = _fly?.value ?? _drag;
        final angle = (offset.dx / MediaQuery.sizeOf(context).width) * 0.30;
        return Transform.translate(
          offset: offset,
          child: Transform.rotate(angle: angle, child: child),
        );
      },
      child: GestureDetector(
        onPanUpdate: _onPanUpdate,
        onPanEnd: _onPanEnd,
        child: _cardFrame(context, post, key: ValueKey(post.id)),
      ),
    );
  }

  Widget _cardFrame(BuildContext context, BoardPost post, {Key? key}) {
    return Padding(
      key: key,
      padding: EdgeInsets.symmetric(
        horizontal: context.w(16),
        vertical: context.h(12),
      ),
      child: SwipeCard(post: post),
    );
  }
}
