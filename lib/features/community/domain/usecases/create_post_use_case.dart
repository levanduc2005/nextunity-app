import 'package:rental_car/core/utils/result.dart';
import 'package:rental_car/features/community/domain/entities/post_entity.dart';
import 'package:rental_car/features/community/domain/repositories/community_repository.dart';

class CreatePostUseCase {
  const CreatePostUseCase(this._repository);

  final CommunityRepository _repository;

  Future<Result<PostEntity>> call({
    required String title,
    required String content,
    List<String>? tags,
  }) => _repository.createPost(title: title, content: content, tags: tags);
}
