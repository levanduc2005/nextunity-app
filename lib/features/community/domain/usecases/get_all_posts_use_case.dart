import 'package:rental_car/core/utils/result.dart';
import 'package:rental_car/features/community/domain/entities/post_entity.dart';
import 'package:rental_car/features/community/domain/repositories/community_repository.dart';

class GetAllPostsUseCase {
  const GetAllPostsUseCase(this._repository);

  final CommunityRepository _repository;

  Future<Result<List<PostEntity>>> call() => _repository.getAllPosts();
}
