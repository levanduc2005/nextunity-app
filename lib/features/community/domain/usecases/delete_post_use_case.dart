import 'package:rental_car/core/utils/result.dart';
import 'package:rental_car/features/community/domain/repositories/community_repository.dart';

class DeletePostUseCase {
  const DeletePostUseCase(this._repository);

  final CommunityRepository _repository;

  Future<Result<void>> call(String id) => _repository.deletePost(id);
}
