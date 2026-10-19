import 'package:rental_car/core/utils/result.dart';
import 'package:rental_car/features/community/domain/entities/comment_entity.dart';
import 'package:rental_car/features/community/domain/repositories/community_repository.dart';

class GetCommentsUseCase {
  const GetCommentsUseCase(this._repository);

  final CommunityRepository _repository;

  Future<Result<List<CommentEntity>>> call(String postId) =>
      _repository.getCommentsByPostId(postId);
}
