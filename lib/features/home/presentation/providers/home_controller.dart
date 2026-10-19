import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:rental_car/core/providers/core_providers.dart';
import 'package:rental_car/features/community/presentation/providers/community_providers.dart';
import 'package:rental_car/features/course/presentation/providers/course_providers.dart';
import 'package:rental_car/features/profile/presentation/providers/profile_providers.dart';

class HomeState {
  const HomeState({
    this.isLoading = false,
    this.isRefreshing = false,
    this.errorMessage,
    this.todayStreak = 0,
    this.rewardPoints = 0,
    this.aiSetsCreatedCount = 0,
  });

  final bool isLoading;
  final bool isRefreshing;
  final String? errorMessage;
  final int todayStreak;
  final int rewardPoints;
  final int aiSetsCreatedCount;

  HomeState copyWith({
    bool? isLoading,
    bool? isRefreshing,
    String? errorMessage,
    int? todayStreak,
    int? rewardPoints,
    int? aiSetsCreatedCount,
    bool clearError = false,
  }) {
    return HomeState(
      isLoading: isLoading ?? this.isLoading,
      isRefreshing: isRefreshing ?? this.isRefreshing,
      errorMessage: clearError ? null : (errorMessage ?? this.errorMessage),
      todayStreak: todayStreak ?? this.todayStreak,
      rewardPoints: rewardPoints ?? this.rewardPoints,
      aiSetsCreatedCount: aiSetsCreatedCount ?? this.aiSetsCreatedCount,
    );
  }
}

class HomeController extends Notifier<HomeState> {
  @override
  HomeState build() {
    final user = ref.watch(currentUserProvider);

    return HomeState(
      todayStreak: user?.streak ?? 0,
      rewardPoints: user?.points ?? 0,
    );
  }

  Future<void> refresh() async {
    state = state.copyWith(isRefreshing: true, clearError: true);
    await Future.wait([
      ref.read(profileControllerProvider.notifier).refreshProfile(),
      ref.read(coursesControllerProvider.notifier).refresh(),
      ref.read(communityControllerProvider.notifier).loadPosts(),
    ]);
    final profile = ref.read(currentUserProvider);
    state = state.copyWith(
      isRefreshing: false,
      todayStreak: profile?.streak ?? 0,
      rewardPoints: profile?.points ?? 0,
    );
  }
}
