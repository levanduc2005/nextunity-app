import 'package:rental_car/core/utils/result.dart';
import 'package:rental_car/features/community/domain/entities/comment_entity.dart';
import 'package:rental_car/features/community/domain/repositories/community_repository.dart';

class CreateCommentUseCase {
  const CreateCommentUseCase(this._repository);

  final CommunityRepository _repository;

  Future<Result<CommentEntity>> call({
    required String postId,
    required String content,
    String? parentId,
  }) => _repository.createComment(
    postId: postId,
    content: content,
    parentId: parentId,
  );
}
