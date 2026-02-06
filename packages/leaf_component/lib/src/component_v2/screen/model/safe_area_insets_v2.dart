/// Describes which edges of the [SafeArea] are enabled.
///
/// Immutable value object – use factory constructors for common presets.
class SafeAreaInsetsV2 {
  final bool left;
  final bool top;
  final bool right;
  final bool bottom;

  const SafeAreaInsetsV2({
    required this.left,
    required this.top,
    required this.right,
    required this.bottom,
  });

  /// All edges enabled (default).
  const SafeAreaInsetsV2.all()
      : left = true,
        top = true,
        right = true,
        bottom = true;

  /// No edges enabled.
  const SafeAreaInsetsV2.none()
      : left = false,
        top = false,
        right = false,
        bottom = false;

  /// Named constructor matching the LTRB convention.
  const SafeAreaInsetsV2.fromLTRB(
    this.left,
    this.top,
    this.right,
    this.bottom,
  );

  /// Selectively enable edges; unspecified edges default to `false`.
  const SafeAreaInsetsV2.only({
    this.left = false,
    this.top = false,
    this.right = false,
    this.bottom = false,
  });
}
