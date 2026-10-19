class CourseFilterOptionsEntity {
  const CourseFilterOptionsEntity({
    this.categories = const {},
    this.difficulties = const {},
  });

  final Map<String, String> categories;
  final Map<String, String> difficulties;
}
