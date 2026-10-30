import 'package:rental_car/core/error/exceptions.dart';
import 'package:rental_car/core/error/failure.dart';
import 'package:rental_car/core/utils/result.dart';
import 'package:rental_car/features/community/data/datasources/community_remote_data_source.dart';
import 'package:rental_car/features/community/domain/entities/comment_entity.dart';
import 'package:rental_car/features/community/domain/entities/comment_reaction_result.dart';
import 'package:rental_car/features/community/domain/entities/post_entity.dart';
import 'package:rental_car/features/community/domain/entities/post_reaction_result.dart';
import 'package:rental_car/features/community/domain/entities/reaction_type.dart';
import 'package:rental_car/features/community/domain/repositories/community_repository.dart';

class CommunityRepositoryImpl implements CommunityRepository {
  const CommunityRepositoryImpl(this._remoteDataSource);

  final CommunityRemoteDataSource _remoteDataSource;

  @override
  Future<Result<List<PostEntity>>> getAllPosts() async {
    try {
      final models = await _remoteDataSource.getAllPosts();
      return Result.ok(models.map((m) => m.toEntity()).toList());
    } on ServerException catch (e) {
      return Result.err(ServerFailure(message: e.message));
    } catch (e) {
      return Result.err(ServerFailure(message: e.toString()));
    }
  }

  @override
  Future<Result<List<PostEntity>>> getPopularPosts({int limit = 3}) async {
    try {
      final models = await _remoteDataSource.getPopularPosts(limit: limit);
      return Result.ok(models.map((m) => m.toEntity()).toList());
    } on ServerException catch (e) {
      return Result.err(ServerFailure(message: e.message));
    } catch (e) {
      return Result.err(ServerFailure(message: e.toString()));
    }
  }

  @override
  Future<Result<PostEntity>> getPostById(String id) async {
    try {
      final model = await _remoteDataSource.getPostById(id);
      return Result.ok(model.toEntity());
    } on ServerException catch (e) {
      return Result.err(ServerFailure(message: e.message));
    } catch (e) {
      return Result.err(ServerFailure(message: e.toString()));
    }
  }

  @override
  Future<Result<PostEntity>> createPost({
    required String title,
    required String content,
    List<String>? tags,
  }) async {
    try {
      final model = await _remoteDataSource.createPost(
        title: title,
        content: content,
        tags: tags,
      );
      return Result.ok(model.toEntity());
    } on ServerException catch (e) {
      return Result.err(ServerFailure(message: e.message));
    } catch (e) {
      return Result.err(ServerFailure(message: e.toString()));
    }
  }

  @override
  Future<Result<List<CommentEntity>>> getCommentsByPostId(String postId) async {
    try {
      final models = await _remoteDataSource.getCommentsByPostId(postId);
      return Result.ok(models.map((m) => m.toEntity()).toList());
    } on ServerException catch (e) {
      return Result.err(ServerFailure(message: e.message));
    } catch (e) {
      return Result.err(ServerFailure(message: e.toString()));
    }
  }

  @override
  Future<Result<CommentEntity>> createComment({
    required String postId,
    required String content,
    String? parentId,
  }) async {
    try {
      final model = await _remoteDataSource.createComment(
        postId: postId,
        content: content,
        parentId: parentId,
      );
      return Result.ok(model.toEntity());
    } on ServerException catch (e) {
      return Result.err(ServerFailure(message: e.message));
    } catch (e) {
      return Result.err(ServerFailure(message: e.toString()));
    }
  }

  @override
  Future<Result<PostReactionResult>> togglePostReaction(
    String postId, {
    ReactionType reactionType = ReactionType.like,
  }) async {
    try {
      final result = await _remoteDataSource.togglePostReaction(
        postId,
        reactionType: reactionType,
      );
      return Result.ok(result);
    } on ServerException catch (e) {
      return Result.err(ServerFailure(message: e.message));
    } catch (e) {
      return Result.err(ServerFailure(message: e.toString()));
    }
  }

  @override
  Future<Result<CommentReactionResult>> toggleCommentReaction(
    String commentId, {
    ReactionType reactionType = ReactionType.like,
  }) async {
    try {
      final result = await _remoteDataSource.toggleCommentReaction(
        commentId,
        reactionType: reactionType,
      );
      return Result.ok(result);
    } on ServerException catch (e) {
      return Result.err(ServerFailure(message: e.message));
    } catch (e) {
      return Result.err(ServerFailure(message: e.toString()));
    }
  }

  @override
  Future<Result<List<String>>> getTags() async {
    try {
      final tags = await _remoteDataSource.getTags();
      return Result.ok(tags);
    } on ServerException catch (e) {
      return Result.err(ServerFailure(message: e.message));
    } catch (e) {
      return Result.err(ServerFailure(message: e.toString()));
    }
  }

  @override
  Future<Result<void>> deletePost(String id) async {
    try {
      await _remoteDataSource.deletePost(id);
      return const Result.ok(null);
    } on ServerException catch (e) {
      return Result.err(ServerFailure(message: e.message));
    } catch (e) {
      return Result.err(ServerFailure(message: e.toString()));
    }
  }

  @override
  Future<Result<void>> deleteComment(String id) async {
    try {
      await _remoteDataSource.deleteComment(id);
      return const Result.ok(null);
    } on ServerException catch (e) {
      return Result.err(ServerFailure(message: e.message));
    } catch (e) {
      return Result.err(ServerFailure(message: e.toString()));
    }
  }
}
