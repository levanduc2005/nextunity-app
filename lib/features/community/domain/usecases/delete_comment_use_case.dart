import 'package:rental_car/core/utils/result.dart';
import 'package:rental_car/features/community/domain/repositories/community_repository.dart';

class DeleteCommentUseCase {
  const DeleteCommentUseCase(this._repository);

  final CommunityRepository _repository;

  Future<Result<void>> call(String id) => _repository.deleteComment(id);
}
