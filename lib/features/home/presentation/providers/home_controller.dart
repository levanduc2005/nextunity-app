import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:rental_car/features/community/presentation/providers/community_providers.dart';
import 'package:rental_car/features/course/presentation/providers/course_providers.dart';
import 'package:rental_car/features/profile/presentation/providers/profile_providers.dart';

class HomeState {
  const HomeState({
    this.isLoading = false,
    this.isRefreshing = false,
    this.errorMessage,
    this.aiSetsCreatedCount = 0,
  });

  final bool isLoading;
  final bool isRefreshing;
  final String? errorMessage;
  final int aiSetsCreatedCount;

  HomeState copyWith({
    bool? isLoading,
    bool? isRefreshing,
    String? errorMessage,
    int? aiSetsCreatedCount,
    bool clearError = false,
  }) {
    return HomeState(
      isLoading: isLoading ?? this.isLoading,
      isRefreshing: isRefreshing ?? this.isRefreshing,
      errorMessage: clearError ? null : (errorMessage ?? this.errorMessage),
      aiSetsCreatedCount: aiSetsCreatedCount ?? this.aiSetsCreatedCount,
    );
  }
}

class HomeController extends Notifier<HomeState> {
  @override
  HomeState build() {
    return const HomeState();
  }

  Future<void> refresh() async {
    state = state.copyWith(isRefreshing: true, clearError: true);
    await Future.wait([
      ref.read(profileControllerProvider.notifier).refreshProfile(),
      ref.read(coursesControllerProvider.notifier).refresh(),
      ref.read(communityControllerProvider.notifier).loadPosts(),
    ]);
    state = state.copyWith(isRefreshing: false);
  }
}
