import 'package:rental_car/core/utils/result.dart';
import 'package:rental_car/features/community/domain/entities/post_entity.dart';
import 'package:rental_car/features/community/domain/repositories/community_repository.dart';

class GetPostDetailUseCase {
  const GetPostDetailUseCase(this._repository);

  final CommunityRepository _repository;

  Future<Result<PostEntity>> call(String id) => _repository.getPostById(id);
}
