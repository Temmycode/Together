import 'package:go_router/go_router.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';
import 'package:together/core/router/routes.dart';
import 'package:together/features/boards/presentation/screens/board_collage_screen.dart';
import 'package:together/features/boards/presentation/screens/board_viewer_screen.dart';
import 'package:together/features/boards/presentation/screens/boards_home_screen.dart';

part 'app_router.g.dart';

/// The app [GoRouter], exposed as a keep-alive provider so navigation state
/// survives provider rebuilds.
///
/// To add auth-gated routing later, bridge auth state → router *without*
/// rebuilding the GoRouter: pass a `ChangeNotifier` to `refreshListenable` that
/// fires when the auth provider changes, and read auth synchronously inside
/// `redirect` (see the commented sketch below). Do NOT `ref.watch` the auth
/// provider here — that would recreate the router and lose navigation state.
@Riverpod(keepAlive: true)
GoRouter goRouter(Ref ref) {
  return GoRouter(
    initialLocation: Routes.boardsHome,
    routes: [
      GoRoute(
        path: Routes.boardsHome,
        builder: (context, state) => const BoardsHomeScreen(),
      ),
      GoRoute(
        path: Routes.boardCollage,
        builder: (context, state) => BoardCollageScreen(
          boardId: state.pathParameters['id'] ?? '',
        ),
      ),
      GoRoute(
        path: Routes.boardViewer,
        builder: (context, state) => BoardViewerScreen(
          boardId: state.pathParameters['id'] ?? '',
        ),
      ),
    ],
    // --- Auth redirect scaffold (enable when an auth feature exists) ---
    //
    //   final refresh = _RouterRefresh(ref, authControllerProvider);
    //   ref.onDispose(refresh.dispose);
    //   return GoRouter(
    //     refreshListenable: refresh,
    //     redirect: (context, state) {
    //       final loggedIn = ref.read(authControllerProvider).isLoggedIn;
    //       final loggingIn = state.matchedLocation == Routes.login;
    //       if (!loggedIn && !loggingIn) return Routes.login;
    //       if (loggedIn && loggingIn) return Routes.posts;
    //       return null;
    //     },
    //     routes: [...],
    //   );
    //
    // // Bridges a Riverpod provider to GoRouter's Listenable-based refresh.
    // class _RouterRefresh extends ChangeNotifier {
    //   _RouterRefresh(Ref ref, ProviderListenable<Object?> provider) {
    //     _sub = ref.listen(provider, (_, _) => notifyListeners());
    //   }
    //   late final ProviderSubscription<Object?> _sub;
    //   @override
    //   void dispose() { _sub.close(); super.dispose(); }
    // }
  );
}
