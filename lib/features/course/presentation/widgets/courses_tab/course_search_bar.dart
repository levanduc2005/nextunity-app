import 'package:flutter/material.dart';
import 'package:rental_car/core/theme/app_colors.dart';

class CourseSearchBar extends StatefulWidget {
  const CourseSearchBar({
    super.key,
    required this.onSearch,
    required this.onOpenFilter,
    this.initialValue = '',
    this.hasActiveFilter = false,
  });

  final ValueChanged<String> onSearch;
  final VoidCallback onOpenFilter;
  final String initialValue;
  final bool hasActiveFilter;

  @override
  State<CourseSearchBar> createState() => _CourseSearchBarState();
}

class _CourseSearchBarState extends State<CourseSearchBar> {
  late final TextEditingController _controller;

  @override
  void initState() {
    super.initState();
    _controller = TextEditingController(text: widget.initialValue);
  }

  @override
  void didUpdateWidget(covariant CourseSearchBar oldWidget) {
    super.didUpdateWidget(oldWidget);
    if (oldWidget.initialValue != widget.initialValue &&
        widget.initialValue != _controller.text) {
      _controller.text = widget.initialValue;
    }
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  void _submitSearch() {
    widget.onSearch(_controller.text.trim());
  }

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        // Search Input Field
        Expanded(
          child: Container(
            height: 44,
            decoration: BoxDecoration(
              color: const Color(0xFFF1F5F9),
              borderRadius: BorderRadius.circular(16),
              border: Border.all(color: const Color(0xFFE2E8F0)),
            ),
            child: TextField(
              controller: _controller,
              textInputAction: TextInputAction.search,
              onSubmitted: (_) => _submitSearch(),
              onChanged: (_) => setState(() {}),
              style: const TextStyle(
                fontSize: 12.5,
                fontWeight: FontWeight.w600,
                color: Color(0xFF0F172A),
              ),
              decoration: InputDecoration(
                hintText: 'Tìm mã môn (EXE201, SWP391), từ khóa...',
                hintStyle: const TextStyle(
                  fontSize: 12,
                  color: Color(0xFF94A3B8),
                  fontWeight: FontWeight.w500,
                ),
                prefixIcon: IconButton(
                  onPressed: _submitSearch,
                  icon: const Icon(
                    Icons.search_rounded,
                    color: AppColors.primary,
                    size: 20,
                  ),
                  tooltip: 'Tìm kiếm',
                  padding: EdgeInsets.zero,
                  splashRadius: 20,
                ),
                suffixIcon: _controller.text.isNotEmpty
                    ? IconButton(
                        onPressed: () {
                          _controller.clear();
                          setState(() {});
                          widget.onSearch('');
                        },
                        icon: const Icon(
                          Icons.cancel_rounded,
                          color: Color(0xFF94A3B8),
                          size: 18,
                        ),
                        tooltip: 'Xóa tìm kiếm',
                        padding: EdgeInsets.zero,
                        splashRadius: 18,
                      )
                    : null,
                border: InputBorder.none,
                contentPadding: const EdgeInsets.symmetric(
                  vertical: 11,
                  horizontal: 4,
                ),
              ),
            ),
          ),
        ),
        const SizedBox(width: 8),

        // Filter Trigger Button
        InkWell(
          onTap: widget.onOpenFilter,
          borderRadius: BorderRadius.circular(14),
          child: AnimatedContainer(
            duration: const Duration(milliseconds: 150),
            width: 44,
            height: 44,
            decoration: BoxDecoration(
              color: widget.hasActiveFilter
                  ? AppColors.primary.withValues(alpha: 0.1)
                  : Colors.white,
              borderRadius: BorderRadius.circular(14),
              border: Border.all(
                color: widget.hasActiveFilter
                    ? AppColors.primary
                    : const Color(0xFFE2E8F0),
                width: widget.hasActiveFilter ? 1.5 : 1,
              ),
              boxShadow: [
                BoxShadow(
                  color: Colors.black.withValues(alpha: 0.03),
                  blurRadius: 4,
                  offset: const Offset(0, 1),
                ),
              ],
            ),
            child: Stack(
              alignment: Alignment.center,
              children: [
                Icon(
                  Icons.tune_rounded,
                  size: 20,
                  color: widget.hasActiveFilter
                      ? AppColors.primary
                      : const Color(0xFF475569),
                ),
                if (widget.hasActiveFilter)
                  Positioned(
                    top: 8,
                    right: 8,
                    child: Container(
                      width: 7,
                      height: 7,
                      decoration: const BoxDecoration(
                        color: Color(0xFFEF4444),
                        shape: BoxShape.circle,
                      ),
                    ),
                  ),
              ],
            ),
          ),
        ),
      ],
    );
  }
}
