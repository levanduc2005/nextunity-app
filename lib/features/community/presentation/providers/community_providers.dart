import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:rental_car/core/providers/core_providers.dart';
import 'package:rental_car/features/community/data/datasources/community_remote_data_source.dart';
import 'package:rental_car/features/community/data/repositories/community_repository_impl.dart';
import 'package:rental_car/features/community/domain/repositories/community_repository.dart';
import 'package:rental_car/features/community/domain/usecases/create_comment_use_case.dart';
import 'package:rental_car/features/community/domain/usecases/create_post_use_case.dart';
import 'package:rental_car/features/community/domain/usecases/delete_comment_use_case.dart';
import 'package:rental_car/features/community/domain/usecases/delete_post_use_case.dart';
import 'package:rental_car/features/community/domain/usecases/get_all_posts_use_case.dart';
import 'package:rental_car/features/community/domain/usecases/get_comments_use_case.dart';
import 'package:rental_car/features/community/domain/usecases/get_post_detail_use_case.dart';
import 'package:rental_car/features/community/domain/usecases/get_tags_use_case.dart';
import 'package:rental_car/features/community/domain/usecases/toggle_reaction_use_case.dart';
import 'package:rental_car/features/community/presentation/providers/community_controller.dart';
import 'package:rental_car/features/community/presentation/providers/post_detail_controller.dart';

export 'community_controller.dart';
export 'post_detail_controller.dart';

// ============================================================================
// DEPENDENCY INJECTION PROVIDERS
// ============================================================================

final communityRemoteDataSourceProvider = Provider<CommunityRemoteDataSource>((
  ref,
) {
  return CommunityRemoteDataSourceImpl(ref.watch(dioProvider));
});

final communityRepositoryProvider = Provider<CommunityRepository>((ref) {
  return CommunityRepositoryImpl(ref.watch(communityRemoteDataSourceProvider));
});

final getAllPostsUseCaseProvider = Provider<GetAllPostsUseCase>((ref) {
  return GetAllPostsUseCase(ref.watch(communityRepositoryProvider));
});

final getPostDetailUseCaseProvider = Provider<GetPostDetailUseCase>((ref) {
  return GetPostDetailUseCase(ref.watch(communityRepositoryProvider));
});

final createPostUseCaseProvider = Provider<CreatePostUseCase>((ref) {
  return CreatePostUseCase(ref.watch(communityRepositoryProvider));
});

final getCommentsUseCaseProvider = Provider<GetCommentsUseCase>((ref) {
  return GetCommentsUseCase(ref.watch(communityRepositoryProvider));
});

final createCommentUseCaseProvider = Provider<CreateCommentUseCase>((ref) {
  return CreateCommentUseCase(ref.watch(communityRepositoryProvider));
});

final togglePostReactionUseCaseProvider = Provider<TogglePostReactionUseCase>((
  ref,
) {
  return TogglePostReactionUseCase(ref.watch(communityRepositoryProvider));
});

final toggleCommentReactionUseCaseProvider =
    Provider<ToggleCommentReactionUseCase>((ref) {
      return ToggleCommentReactionUseCase(
        ref.watch(communityRepositoryProvider),
      );
    });

final getTagsUseCaseProvider = Provider<GetTagsUseCase>((ref) {
  return GetTagsUseCase(ref.watch(communityRepositoryProvider));
});

final deletePostUseCaseProvider = Provider<DeletePostUseCase>((ref) {
  return DeletePostUseCase(ref.watch(communityRepositoryProvider));
});

final deleteCommentUseCaseProvider = Provider<DeleteCommentUseCase>((ref) {
  return DeleteCommentUseCase(ref.watch(communityRepositoryProvider));
});

// ============================================================================
// PRESENTATION CONTROLLER PROVIDERS
// ============================================================================

final communityControllerProvider =
    NotifierProvider<CommunityController, CommunityState>(
      CommunityController.new,
    );

final postDetailControllerProvider =
    NotifierProvider<PostDetailController, PostDetailState>(
      PostDetailController.new,
    );
