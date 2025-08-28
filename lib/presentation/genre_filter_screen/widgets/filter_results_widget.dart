import 'package:flutter/material.dart';
import 'package:sizer/sizer.dart';

import '../../../core/app_export.dart';

class FilterResultsWidget extends StatelessWidget {
  final List<String> selectedGenres;
  final String selectedContentType;
  final double selectedRating;

  const FilterResultsWidget({
    super.key,
    required this.selectedGenres,
    required this.selectedContentType,
    required this.selectedRating,
  });

  @override
  Widget build(BuildContext context) {
    if (selectedGenres.isEmpty && selectedContentType == 'Todos' && selectedRating == 0.0) {
      return const SizedBox.shrink();
    }

    return Container(
      margin: EdgeInsets.symmetric(horizontal: 4.w, vertical: 2.h),
      padding: EdgeInsets.all(4.w),
      decoration: BoxDecoration(
        color: AppTheme.surfaceDark,
        borderRadius: BorderRadius.circular(12),
        border: Border.all(
          color: AppTheme.borderColor.withValues(alpha: 0.3),
        ),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          if (selectedGenres.isNotEmpty || selectedContentType != 'Todos' || selectedRating > 0.0) ...[
            Text(
              'Filtros Ativos:',
              style: AppTheme.darkTheme.textTheme.labelMedium?.copyWith(
                color: AppTheme.mutedText,
              ),
            ),
            SizedBox(height: 1.h),
            Wrap(
              spacing: 2.w,
              runSpacing: 1.h,
              children: [
                if (selectedContentType != 'Todos') _buildFilterChip(selectedContentType),
                if (selectedRating > 0.0) _buildFilterChip('★ ${selectedRating.toStringAsFixed(1)}+'),
                ...selectedGenres.map((genre) => _buildFilterChip(genre)),
              ],
            ),
          ],
        ],
      ),
    );
  }

  Widget _buildFilterChip(String label) {
    return Container(
      padding: EdgeInsets.symmetric(horizontal: 3.w, vertical: 1.h),
      decoration: BoxDecoration(
        color: AppTheme.accentColor.withValues(alpha: 0.2),
        borderRadius: BorderRadius.circular(16),
        border: Border.all(
          color: AppTheme.accentColor.withValues(alpha: 0.3),
        ),
      ),
      child: Text(
        label,
        style: AppTheme.darkTheme.textTheme.labelSmall?.copyWith(
          color: AppTheme.accentColor,
          fontWeight: FontWeight.w500,
        ),
      ),
    );
  }
}
