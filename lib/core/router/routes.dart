/// Centralised route paths — the single source of truth for navigation
/// strings, so screens never hard-code them.
abstract final class Routes {
  const Routes._();

  /// Boards list (home).
  static const String boardsHome = '/';

  /// A board's collage overview, parameterised by id.
  static const String boardCollage = '/board/:id';

  /// A board's full-screen swipe viewer, parameterised by id.
  static const String boardViewer = '/board/:id/view';

  static String boardCollagePath(String id) => '/board/$id';
  static String boardViewerPath(String id) => '/board/$id/view';

  // --- Sample posts feature (kept for reference; not registered in the router).
  static const String postDetail = '/posts/:id';
  static String postDetailPath(int id) => '/posts/$id';
}
