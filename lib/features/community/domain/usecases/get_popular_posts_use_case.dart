import 'package:rental_car/core/utils/result.dart';
import 'package:rental_car/features/community/domain/entities/post_entity.dart';
import 'package:rental_car/features/community/domain/repositories/community_repository.dart';

class GetPopularPostsUseCase {
  const GetPopularPostsUseCase(this._repository);

  final CommunityRepository _repository;

  Future<Result<List<PostEntity>>> call({int limit = 3}) =>
      _repository.getPopularPosts(limit: limit);
}

