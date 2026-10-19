import 'package:dio/dio.dart';
import 'package:rental_car/core/error/exceptions.dart';
import 'package:rental_car/features/community/data/models/comment_model.dart';
import 'package:rental_car/features/community/data/models/post_model.dart';
import 'package:rental_car/features/community/domain/entities/reaction_type.dart';

abstract interface class CommunityRemoteDataSource {
  Future<List<PostModel>> getAllPosts();
  Future<PostModel> getPostById(String id);
  Future<PostModel> createPost({
    required String title,
    required String content,
    List<String>? tags,
  });
  Future<List<CommentModel>> getCommentsByPostId(String postId);
  Future<CommentModel> createComment({
    required String postId,
    required String content,
    String? parentId,
  });
  Future<void> togglePostReaction(
    String postId, {
    ReactionType reactionType = ReactionType.like,
  });
  Future<void> toggleCommentReaction(
    String commentId, {
    ReactionType reactionType = ReactionType.like,
  });
  Future<List<String>> getTags();
}

class CommunityRemoteDataSourceImpl implements CommunityRemoteDataSource {
  const CommunityRemoteDataSourceImpl(this._dio);

  final Dio _dio;

  @override
  Future<List<PostModel>> getAllPosts() async {
    try {
      final response = await _dio.get<Map<String, dynamic>>('/posts');
      final data = response.data;
      if (data == null) return [];

      final list = data['data'] as List<dynamic>? ?? [];
      return list
          .map((e) => PostModel.fromJson(e as Map<String, dynamic>))
          .toList();
    } on DioException catch (e) {
      throw _handleDioError(e, 'Không thể tải danh sách bài viết cộng đồng');
    } catch (e) {
      throw ServerException(message: e.toString());
    }
  }

  @override
  Future<PostModel> getPostById(String id) async {
    try {
      final response = await _dio.get<Map<String, dynamic>>('/posts/$id');
      final data = response.data;
      if (data == null || data['data'] == null) {
        throw const ServerException(message: 'Không tìm thấy bài viết');
      }
      return PostModel.fromJson(data['data'] as Map<String, dynamic>);
    } on DioException catch (e) {
      throw _handleDioError(e, 'Không thể tải chi tiết bài viết');
    } catch (e) {
      throw ServerException(message: e.toString());
    }
  }

  @override
  Future<PostModel> createPost({
    required String title,
    required String content,
    List<String>? tags,
  }) async {
    try {
      final response = await _dio.post<Map<String, dynamic>>(
        '/posts',
        data: {'title': title, 'content': content, 'tagNames': tags ?? []},
      );
      final data = response.data;
      if (data == null || data['data'] == null) {
        throw const ServerException(
          message: 'Không nhận được dữ liệu phản hồi',
        );
      }
      return PostModel.fromJson(data['data'] as Map<String, dynamic>);
    } on DioException catch (e) {
      throw _handleDioError(e, 'Đăng bài viết không thành công');
    } catch (e) {
      throw ServerException(message: e.toString());
    }
  }

  @override
  Future<List<CommentModel>> getCommentsByPostId(String postId) async {
    try {
      final response = await _dio.get<Map<String, dynamic>>(
        '/comments/post/$postId',
      );
      final data = response.data;
      if (data == null) return [];

      final list = data['data'] as List<dynamic>? ?? [];
      return list
          .map((e) => CommentModel.fromJson(e as Map<String, dynamic>))
          .toList();
    } on DioException catch (e) {
      throw _handleDioError(e, 'Không thể tải danh sách bình luận');
    } catch (e) {
      throw ServerException(message: e.toString());
    }
  }

  @override
  Future<CommentModel> createComment({
    required String postId,
    required String content,
    String? parentId,
  }) async {
    try {
      final body = <String, dynamic>{'postId': postId, 'content': content};
      if (parentId != null && parentId.isNotEmpty) {
        body['parentId'] = parentId;
      }

      final response = await _dio.post<Map<String, dynamic>>(
        '/comments',
        data: body,
      );
      final data = response.data;
      if (data == null || data['data'] == null) {
        throw const ServerException(
          message: 'Không nhận được dữ liệu bình luận phản hồi',
        );
      }
      return CommentModel.fromJson(data['data'] as Map<String, dynamic>);
    } on DioException catch (e) {
      throw _handleDioError(e, 'Gửi bình luận không thành công');
    } catch (e) {
      throw ServerException(message: e.toString());
    }
  }

  @override
  Future<void> togglePostReaction(
    String postId, {
    ReactionType reactionType = ReactionType.like,
  }) async {
    try {
      await _dio.post<Map<String, dynamic>>(
        '/reactions/post/$postId',
        data: {'reactionType': reactionType.apiValue},
      );
    } on DioException catch (e) {
      throw _handleDioError(e, 'Không thể tương tác bài viết');
    } catch (e) {
      throw ServerException(message: e.toString());
    }
  }

  @override
  Future<void> toggleCommentReaction(
    String commentId, {
    ReactionType reactionType = ReactionType.like,
  }) async {
    try {
      await _dio.post<Map<String, dynamic>>(
        '/reactions/comment/$commentId',
        data: {'reactionType': reactionType.apiValue},
      );
    } on DioException catch (e) {
      throw _handleDioError(e, 'Không thể tương tác bình luận');
    } catch (e) {
      throw ServerException(message: e.toString());
    }
  }

  @override
  Future<List<String>> getTags() async {
    try {
      final response = await _dio.get<Map<String, dynamic>>('/tags');
      final data = response.data;
      if (data == null) return [];
      final list = data['data'] as List<dynamic>? ?? [];
      return list
          .map((e) {
            if (e is Map<String, dynamic>) {
              return (e['name'] as String?)?.trim() ?? '';
            }
            return e.toString().trim();
          })
          .where((name) => name.isNotEmpty)
          .toList();
    } on DioException catch (e) {
      throw _handleDioError(e, 'Không thể tải danh sách hashtag');
    } catch (e) {
      throw ServerException(message: e.toString());
    }
  }

  ServerException _handleDioError(DioException e, String defaultMessage) {
    final resData = e.response?.data;
    final msg = resData is Map<String, dynamic>
        ? resData['message']?.toString()
        : null;
    return ServerException(
      statusCode: e.response?.statusCode,
      message: msg ?? e.message ?? defaultMessage,
    );
  }
}
