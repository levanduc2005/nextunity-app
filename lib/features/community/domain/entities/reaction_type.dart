/// Pure Domain Entity biểu diễn loại cảm xúc tương tác bài viết (khớp với Backend API)
enum ReactionType {
  like,
  love,
  haha,
  wow,
  sad,
  angry;

  String get apiValue => name.toUpperCase();

  static ReactionType? fromString(String? val) {
    if (val == null) return null;
    final upper = val.toUpperCase();
    for (final r in ReactionType.values) {
      if (r.name.toUpperCase() == upper) return r;
    }
    return null;
  }
}
