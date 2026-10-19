import 'package:rental_car/core/utils/result.dart';
import 'package:rental_car/features/community/domain/repositories/community_repository.dart';

class GetTagsUseCase {
  const GetTagsUseCase(this._repository);

  final CommunityRepository _repository;

  Future<Result<List<String>>> call() => _repository.getTags();
}
