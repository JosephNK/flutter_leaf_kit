/// Describes which edges of the [SafeArea] are enabled.
///
/// Immutable value object – use factory constructors for common presets.
class SafeAreaInsets {
  final bool left;
  final bool top;
  final bool right;
  final bool bottom;

  const SafeAreaInsets({
    required this.left,
    required this.top,
    required this.right,
    required this.bottom,
  });

  /// All edges enabled (default).
  const SafeAreaInsets.all()
    : left = true,
      top = true,
      right = true,
      bottom = true;

  /// No edges enabled.
  const SafeAreaInsets.none()
    : left = false,
      top = false,
      right = false,
      bottom = false;

  /// Named constructor matching the LTRB convention.
  const SafeAreaInsets.fromLTRB(this.left, this.top, this.right, this.bottom);

  /// Selectively enable edges; unspecified edges default to `false`.
  const SafeAreaInsets.only({
    this.left = false,
    this.top = false,
    this.right = false,
    this.bottom = false,
  });
}
