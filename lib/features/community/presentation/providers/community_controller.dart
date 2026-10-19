import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:rental_car/features/community/domain/entities/post_entity.dart';
import 'package:rental_car/features/community/domain/entities/reaction_type.dart';
import 'package:rental_car/features/community/presentation/providers/community_providers.dart';

class CommunityState {
  const CommunityState({
    this.posts = const [],
    this.tags = const [],
    this.isLoading = false,
    this.errorMessage,
    this.selectedTag = 'Tất cả',
    this.searchQuery = '',
    this.userReactions = const {},
  });

  final List<PostEntity> posts;
  final List<String> tags;
  final bool isLoading;
  final String? errorMessage;
  final String selectedTag;
  final String searchQuery;
  final Map<String, ReactionType> userReactions;

  Set<String> get likedPostIds => userReactions.keys.toSet();

  ReactionType? getPostReaction(String postId) => userReactions[postId];

  bool isPostLiked(String postId) => userReactions.containsKey(postId);

  List<PostEntity> get filteredPosts {
    return posts.where((post) {
      // Filter by Tag
      if (selectedTag != 'Tất cả') {
        final cleanSelected = selectedTag
            .replaceAll('#', '')
            .trim()
            .toLowerCase();
        final matchesTag = post.tags.any(
          (t) => t.replaceAll('#', '').trim().toLowerCase() == cleanSelected,
        );
        if (!matchesTag) return false;
      }

      // Filter by Search Query
      if (searchQuery.trim().isNotEmpty) {
        final query = searchQuery.trim().toLowerCase();
        final matchesTitle = post.title.toLowerCase().contains(query);
        final matchesContent = post.content.toLowerCase().contains(query);
        final matchesAuthor =
            post.authorName?.toLowerCase().contains(query) ?? false;
        final matchesTags = post.tags.any(
          (t) => t.toLowerCase().contains(query),
        );
        if (!matchesTitle &&
            !matchesContent &&
            !matchesAuthor &&
            !matchesTags) {
          return false;
        }
      }

      return true;
    }).toList();
  }

  CommunityState copyWith({
    List<PostEntity>? posts,
    List<String>? tags,
    bool? isLoading,
    String? errorMessage,
    String? selectedTag,
    String? searchQuery,
    Map<String, ReactionType>? userReactions,
    Set<String>? likedPostIds,
    bool clearError = false,
  }) {
    return CommunityState(
      posts: posts ?? this.posts,
      tags: tags ?? this.tags,
      isLoading: isLoading ?? this.isLoading,
      errorMessage: clearError ? null : (errorMessage ?? this.errorMessage),
      selectedTag: selectedTag ?? this.selectedTag,
      searchQuery: searchQuery ?? this.searchQuery,
      userReactions: userReactions ?? this.userReactions,
    );
  }
}

class CommunityController extends Notifier<CommunityState> {
  @override
  CommunityState build() {
    Future.microtask(() {
      loadPosts();
      loadTags();
    });
    return const CommunityState(isLoading: true);
  }

  Future<void> loadPosts() async {
    state = state.copyWith(isLoading: true, clearError: true);
    final result = await ref.read(getAllPostsUseCaseProvider).call();
    result.when(
      ok: (posts) {
        state = state.copyWith(posts: posts, isLoading: false);
      },
      err: (failure) {
        state = state.copyWith(errorMessage: failure.message, isLoading: false);
      },
    );
  }

  Future<void> loadTags() async {
    final result = await ref.read(getTagsUseCaseProvider).call();
    result.when(
      ok: (tags) {
        state = state.copyWith(tags: tags);
      },
      err: (_) {
        // Có lỗi mạng hoặc chưa có tag thì giữ nguyên
      },
    );
  }

  void selectTag(String tag) {
    state = state.copyWith(selectedTag: tag);
  }

  void setSearchQuery(String query) {
    state = state.copyWith(searchQuery: query);
  }

  void updateCommentCount(String postId, {int? explicitCount}) {
    final updatedPosts = state.posts.map((p) {
      if (p.id == postId) {
        final newCount = explicitCount ?? (p.commentCount + 1);
        return p.copyWith(commentCount: newCount);
      }
      return p;
    }).toList();
    state = state.copyWith(posts: updatedPosts);
  }

  Future<void> reactToPost(
    String postId, {
    ReactionType reactionType = ReactionType.like,
  }) async {
    final currentReaction = state.userReactions[postId];
    final isSameReaction = currentReaction == reactionType;

    final newUserReactions = Map<String, ReactionType>.from(
      state.userReactions,
    );

    if (isSameReaction) {
      newUserReactions.remove(postId);
    } else {
      newUserReactions[postId] = reactionType;
    }

    // Optimistic UI update
    final updatedPosts = state.posts.map((p) {
      if (p.id == postId) {
        final currentCount = p.reactionCount;
        int newCount = currentCount;
        if (isSameReaction) {
          newCount = currentCount > 0 ? currentCount - 1 : 0;
        } else if (currentReaction == null) {
          newCount = currentCount + 1;
        }
        return p.copyWith(reactionCount: newCount);
      }
      return p;
    }).toList();

    state = state.copyWith(
      userReactions: newUserReactions,
      posts: updatedPosts,
    );

    // Call Backend API
    final result = await ref
        .read(togglePostReactionUseCaseProvider)
        .call(postId, reactionType: reactionType);

    if (result.isErr) {
      // Revert if API fails
      final revertedUserReactions = Map<String, ReactionType>.from(
        state.userReactions,
      );
      if (currentReaction != null) {
        revertedUserReactions[postId] = currentReaction;
      } else {
        revertedUserReactions.remove(postId);
      }

      final revertedPosts = state.posts.map((p) {
        if (p.id == postId) {
          int originalCount = p.reactionCount;
          if (isSameReaction) {
            originalCount = originalCount + 1;
          } else if (currentReaction == null) {
            originalCount = originalCount > 0 ? originalCount - 1 : 0;
          }
          return p.copyWith(reactionCount: originalCount);
        }
        return p;
      }).toList();

      state = state.copyWith(
        userReactions: revertedUserReactions,
        posts: revertedPosts,
      );
    }
  }

  Future<void> toggleLike(String postId) async {
    final currentReaction = state.userReactions[postId];
    if (currentReaction != null) {
      await reactToPost(postId, reactionType: currentReaction);
    } else {
      await reactToPost(postId);
    }
  }

  Future<bool> createPost({
    required String title,
    required String content,
    List<String>? tags,
  }) async {
    final createUseCase = ref.read(createPostUseCaseProvider);
    final result = await createUseCase(
      title: title,
      content: content,
      tags: tags,
    );

    return result.when(
      ok: (newPost) {
        state = state.copyWith(posts: [newPost, ...state.posts]);
        // Tải lại tag để cập nhật nếu bài viết mới tạo ra tag mới
        loadTags();
        return true;
      },
      err: (failure) {
        state = state.copyWith(errorMessage: failure.message);
        return false;
      },
    );
  }
}
