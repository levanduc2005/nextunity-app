import 'package:flutter_test/flutter_test.dart';
import 'package:mocktail/mocktail.dart';
import 'package:rental_car/core/error/failure.dart';
import 'package:rental_car/core/utils/result.dart';
import 'package:rental_car/features/community/domain/entities/comment_entity.dart';
import 'package:rental_car/features/community/domain/entities/post_entity.dart';
import 'package:rental_car/features/community/domain/entities/reaction_type.dart';
import 'package:rental_car/features/community/domain/repositories/community_repository.dart';
import 'package:rental_car/features/community/domain/usecases/create_comment_use_case.dart';
import 'package:rental_car/features/community/domain/usecases/create_post_use_case.dart';
import 'package:rental_car/features/community/domain/usecases/get_all_posts_use_case.dart';
import 'package:rental_car/features/community/domain/usecases/get_comments_use_case.dart';
import 'package:rental_car/features/community/domain/usecases/get_post_detail_use_case.dart';
import 'package:rental_car/features/community/domain/usecases/get_tags_use_case.dart';
import 'package:rental_car/features/community/domain/usecases/toggle_reaction_use_case.dart';
import 'package:rental_car/features/community/presentation/widgets/post_reaction_button.dart';

class MockCommunityRepository extends Mock implements CommunityRepository {}

void main() {
  late MockCommunityRepository repository;
  late GetAllPostsUseCase getAllPostsUseCase;
  late GetPostDetailUseCase getPostDetailUseCase;
  late GetCommentsUseCase getCommentsUseCase;
  late CreateCommentUseCase createCommentUseCase;
  late CreatePostUseCase createPostUseCase;
  late GetTagsUseCase getTagsUseCase;
  late TogglePostReactionUseCase togglePostReactionUseCase;

  setUp(() {
    repository = MockCommunityRepository();
    getAllPostsUseCase = GetAllPostsUseCase(repository);
    getPostDetailUseCase = GetPostDetailUseCase(repository);
    getCommentsUseCase = GetCommentsUseCase(repository);
    createCommentUseCase = CreateCommentUseCase(repository);
    createPostUseCase = CreatePostUseCase(repository);
    getTagsUseCase = GetTagsUseCase(repository);
    togglePostReactionUseCase = TogglePostReactionUseCase(repository);
  });

  const testPost = PostEntity(
    id: 'p-1',
    title: 'Kinh nghiệm ôn thi PE PRN211',
    content: 'Nội dung chia sẻ kinh nghiệm ôn thi...',
    authorName: 'Tran Minh Khoa',
    authorUniversity: 'FPT HCM',
    tags: ['PRN211', 'PE'],
    reactionCount: 15,
    commentCount: 4,
  );

  const testComment = CommentEntity(
    id: 'c-1',
    postId: 'p-1',
    authorName: 'Nguyen Van A',
    content: 'Bình luận thử nghiệm',
  );

  group('Community UseCases Tests', () {
    test('GetAllPostsUseCase returns list of posts on success', () async {
      when(
        () => repository.getAllPosts(),
      ).thenAnswer((_) async => const Result.ok([testPost]));

      final result = await getAllPostsUseCase();

      expect(result.isOk, isTrue);
      result.when(
        ok: (posts) {
          expect(posts.length, 1);
          expect(posts.first.title, 'Kinh nghiệm ôn thi PE PRN211');
          expect(posts.first.tags, contains('PRN211'));
        },
        err: (_) => fail('Should not fail'),
      );
      verify(() => repository.getAllPosts()).called(1);
    });

    test('GetAllPostsUseCase returns Failure on error', () async {
      when(() => repository.getAllPosts()).thenAnswer(
        (_) async => const Result.err(
          ServerFailure(message: 'Không thể tải danh sách bài viết'),
        ),
      );

      final result = await getAllPostsUseCase();

      expect(result.isErr, isTrue);
      result.when(
        ok: (_) => fail('Should fail'),
        err: (failure) {
          expect(failure, isA<ServerFailure>());
          expect(failure.message, 'Không thể tải danh sách bài viết');
        },
      );
      verify(() => repository.getAllPosts()).called(1);
    });

    test('GetPostDetailUseCase returns PostEntity on success', () async {
      when(
        () => repository.getPostById('p-1'),
      ).thenAnswer((_) async => const Result.ok(testPost));

      final result = await getPostDetailUseCase('p-1');

      expect(result.isOk, isTrue);
      verify(() => repository.getPostById('p-1')).called(1);
    });

    test('GetCommentsUseCase returns list of comments on success', () async {
      when(
        () => repository.getCommentsByPostId('p-1'),
      ).thenAnswer((_) async => const Result.ok([testComment]));

      final result = await getCommentsUseCase('p-1');

      expect(result.isOk, isTrue);
      verify(() => repository.getCommentsByPostId('p-1')).called(1);
    });

    test('CreateCommentUseCase creates comment successfully', () async {
      when(
        () => repository.createComment(postId: 'p-1', content: 'Hay quá!'),
      ).thenAnswer((_) async => const Result.ok(testComment));

      final result = await createCommentUseCase(
        postId: 'p-1',
        content: 'Hay quá!',
      );

      expect(result.isOk, isTrue);
      verify(
        () => repository.createComment(postId: 'p-1', content: 'Hay quá!'),
      ).called(1);
    });

    test(
      'TogglePostReactionUseCase toggles post reaction successfully',
      () async {
        when(
          () => repository.togglePostReaction('p-1'),
        ).thenAnswer((_) async => const Result.ok(null));

        final result = await togglePostReactionUseCase('p-1');

        expect(result.isOk, isTrue);
        verify(() => repository.togglePostReaction('p-1')).called(1);
      },
    );

    test(
      'CreatePostUseCase creates post successfully without communityId',
      () async {
        when(
          () => repository.createPost(
            title: 'Tiêu đề mới',
            content: 'Nội dung mới',
            tags: ['SWP391'],
          ),
        ).thenAnswer((_) async => const Result.ok(testPost));

        final result = await createPostUseCase(
          title: 'Tiêu đề mới',
          content: 'Nội dung mới',
          tags: ['SWP391'],
        );

        expect(result.isOk, isTrue);
        verify(
          () => repository.createPost(
            title: 'Tiêu đề mới',
            content: 'Nội dung mới',
            tags: ['SWP391'],
          ),
        ).called(1);
      },
    );

    test('GetTagsUseCase returns list of tags from repository', () async {
      when(
        () => repository.getTags(),
      ).thenAnswer((_) async => const Result.ok(['PRN211', 'SWP391', 'PE']));

      final result = await getTagsUseCase();

      expect(result.isOk, isTrue);
      result.when(
        ok: (tags) {
          expect(tags, contains('PRN211'));
          expect(tags.length, 3);
        },
        err: (_) => fail('Should not fail'),
      );
      verify(() => repository.getTags()).called(1);
    });
  });

  group('PostEntity Getters Tests', () {
    test('initials returns uppercase 2 letters correctly', () {
      expect(testPost.initials, 'MK');
      const singleName = PostEntity(
        id: '2',
        title: 'T',
        content: 'C',
        authorName: 'Alex',
      );
      expect(singleName.initials, 'AL');
    });

    test('primaryTag prepends # if missing', () {
      expect(testPost.primaryTag, '#PRN211');
      const noTag = PostEntity(id: '3', title: 'T', content: 'C');
      expect(noTag.primaryTag, '#FPTU');
    });
  });

  group('CommentEntity Tests', () {
    test('CommentEntity initials and formattedTime calculation', () {
      final comment = CommentEntity(
        id: 'c-1',
        postId: 'p-1',
        authorName: 'Nguyen Van A',
        content: 'Bình luận hay',
        createdAt: DateTime.now().subtract(const Duration(minutes: 5)),
      );

      expect(comment.initials, 'VA');
      expect(comment.formattedTime, '5 phút');
      expect(comment.isLiked, isFalse);

      final liked = comment.copyWith(isLiked: true, reactionCount: 1);
      expect(liked.isLiked, isTrue);
      expect(liked.reactionCount, 1);
    });
  });

  group('ReactionType Tests', () {
    test('ReactionType enum values, emojis, and labels match specifications', () {
      expect(ReactionType.like.apiValue, 'LIKE');
      expect(ReactionType.like.emoji, '👍');
      expect(ReactionType.like.label, 'Thích');

      expect(ReactionType.love.apiValue, 'LOVE');
      expect(ReactionType.love.emoji, '❤️');
      expect(ReactionType.love.label, 'Yêu thích');

      expect(ReactionType.haha.apiValue, 'HAHA');
      expect(ReactionType.haha.emoji, '😆');

      expect(ReactionType.wow.apiValue, 'WOW');
      expect(ReactionType.wow.emoji, '😮');

      expect(ReactionType.sad.apiValue, 'SAD');
      expect(ReactionType.sad.emoji, '😢');

      expect(ReactionType.angry.apiValue, 'ANGRY');
      expect(ReactionType.angry.emoji, '😡');
    });

    test('ReactionType fromString parses uppercase and lowercase strings correctly', () {
      expect(ReactionType.fromString('like'), ReactionType.like);
      expect(ReactionType.fromString('LOVE'), ReactionType.love);
      expect(ReactionType.fromString('Haha'), ReactionType.haha);
      expect(ReactionType.fromString('invalid'), isNull);
      expect(ReactionType.fromString(null), isNull);
    });

    test('TogglePostReactionUseCase sends specified ReactionType', () async {
      when(
        () => repository.togglePostReaction('p-1', reactionType: ReactionType.love),
      ).thenAnswer((_) async => const Result.ok(null));

      final result = await togglePostReactionUseCase(
        'p-1',
        reactionType: ReactionType.love,
      );

      expect(result.isOk, isTrue);
      verify(
        () => repository.togglePostReaction('p-1', reactionType: ReactionType.love),
      ).called(1);
    });
  });
}
