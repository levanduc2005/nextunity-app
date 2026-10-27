import 'package:flutter/material.dart';
import 'package:rental_car/core/theme/app_colors.dart';
import 'package:rental_car/core/widgets/widgets.dart';
import 'package:rental_car/features/community/presentation/widgets/feed/community_filter_chips.dart';

/// Thanh tìm kiếm và nút bộ lọc bài viết cho Bảng tin cộng đồng
class CommunitySearchBar extends StatelessWidget {
  const CommunitySearchBar({
    super.key,
    required this.searchController,
    required this.onSearchChanged,
    required this.onSearchCleared,
    required this.selectedTag,
    required this.tags,
    required this.onTagSelected,
  });

  final TextEditingController searchController;
  final ValueChanged<String> onSearchChanged;
  final VoidCallback onSearchCleared;
  final String selectedTag;
  final List<String> tags;
  final ValueChanged<String> onTagSelected;

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        Expanded(
          child: Container(
            height: 40,
            padding: const EdgeInsets.symmetric(horizontal: 12),
            decoration: BoxDecoration(
              color: Colors.white,
              borderRadius: BorderRadius.circular(14),
              border: Border.all(color: const Color(0xFFE2E8F0)),
              boxShadow: [
                BoxShadow(
                  color: const Color(0xFF1E3A8A).withValues(alpha: 0.04),
                  blurRadius: 8,
                  offset: const Offset(0, 2),
                ),
              ],
            ),
            child: Row(
              children: [
                const Icon(
                  Icons.search_rounded,
                  color: Color(0xFF94A3B8),
                  size: 19,
                ),
                const SizedBox(width: 8),
                Expanded(
                  child: TextField(
                    controller: searchController,
                    decoration: const InputDecoration(
                      hintText: 'Tìm bài viết, hashtag (#SWP391)...',
                      hintStyle: TextStyle(
                        fontSize: 12.5,
                        color: Color(0xFF94A3B8),
                      ),
                      border: InputBorder.none,
                      isDense: true,
                      contentPadding: EdgeInsets.zero,
                    ),
                    style: const TextStyle(fontSize: 13),
                    onChanged: onSearchChanged,
                  ),
                ),
                if (searchController.text.isNotEmpty)
                  GestureDetector(
                    onTap: onSearchCleared,
                    child: const Icon(
                      Icons.close_rounded,
                      size: 16,
                      color: Color(0xFF94A3B8),
                    ),
                  ),
              ],
            ),
          ),
        ),
        const SizedBox(width: 8),
        _buildFilterButton(context),
      ],
    );
  }

  Widget _buildFilterButton(BuildContext context) {
    final isFiltered = selectedTag != 'Tất cả';

    if (isFiltered) {
      return InkWell(
        onTap: () => CommunityFilterModal.show(
          context: context,
          selectedTag: selectedTag,
          tags: tags,
          onTagSelected: onTagSelected,
        ),
        borderRadius: BorderRadius.circular(12),
        child: Container(
          height: 40,
          padding: const EdgeInsets.symmetric(horizontal: 10),
          decoration: BoxDecoration(
            color: AppColors.primary.withAlpha(20),
            borderRadius: BorderRadius.circular(12),
            border: Border.all(color: AppColors.primary),
          ),
          child: Row(
            mainAxisSize: MainAxisSize.min,
            children: [
              const Icon(
                Icons.filter_alt_rounded,
                size: 15,
                color: AppColors.primary,
              ),
              const Gap.h(4),
              Text(
                selectedTag,
                style: const TextStyle(
                  fontSize: 12,
                  fontWeight: FontWeight.w700,
                  color: AppColors.primary,
                ),
              ),
            ],
          ),
        ),
      );
    }

    return InkWell(
      onTap: () => CommunityFilterModal.show(
        context: context,
        selectedTag: selectedTag,
        tags: tags,
        onTagSelected: onTagSelected,
      ),
      borderRadius: BorderRadius.circular(12),
      child: Container(
        width: 40,
        height: 40,
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.circular(12),
          border: Border.all(color: const Color(0xFFE2E8F0)),
          boxShadow: [
            BoxShadow(
              color: const Color(0xFF1E3A8A).withValues(alpha: 0.04),
              blurRadius: 8,
              offset: const Offset(0, 2),
            ),
          ],
        ),
        child: const Icon(
          Icons.tune_rounded,
          color: Color(0xFF475569),
          size: 20,
        ),
      ),
    );
  }
}
