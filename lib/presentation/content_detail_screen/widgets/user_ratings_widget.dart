import 'package:flutter/material.dart';
import 'package:sizer/sizer.dart';

import '../../../core/app_export.dart';

class UserRatingsWidget extends StatelessWidget {
  final Map<String, dynamic> ratingsData;

  const UserRatingsWidget({
    super.key,
    required this.ratingsData,
  });

  @override
  Widget build(BuildContext context) {
    final double averageRating =
        (ratingsData['averageRating'] as num?)?.toDouble() ?? 8.5;
    final int totalReviews = ratingsData['totalReviews'] ?? 1250;
    final List<Map<String, dynamic>> ratingBreakdown =
        (ratingsData['breakdown'] as List?)?.cast<Map<String, dynamic>>() ?? [];

    return Container(
      width: double.infinity,
      padding: EdgeInsets.symmetric(horizontal: 4.w, vertical: 2.h),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          // Section title
          Text(
            'Avaliações dos Usuários',
            style: AppTheme.darkTheme.textTheme.titleLarge?.copyWith(
              color: AppTheme.contentWhite,
              fontWeight: FontWeight.w600,
            ),
          ),

          SizedBox(height: 2.h),

          // Rating summary
          Container(
            padding: EdgeInsets.all(4.w),
            decoration: BoxDecoration(
              color: AppTheme.secondaryDark,
              borderRadius: BorderRadius.circular(12),
              border: Border.all(
                color: AppTheme.borderColor.withValues(alpha: 0.3),
              ),
            ),
            child: Row(
              children: [
                // Average rating
                Column(
                  children: [
                    Text(
                      averageRating.toStringAsFixed(1),
                      style:
                          AppTheme.darkTheme.textTheme.headlineMedium?.copyWith(
                        color: AppTheme.warningColor,
                        fontWeight: FontWeight.bold,
                      ),
                    ),

                    SizedBox(height: 0.5.h),

                    // Stars
                    Row(
                      mainAxisSize: MainAxisSize.min,
                      children: List.generate(5, (index) {
                        return CustomIconWidget(
                          iconName: index < averageRating.floor()
                              ? 'star'
                              : 'star_border',
                          color: AppTheme.warningColor,
                          size: 16,
                        );
                      }),
                    ),

                    SizedBox(height: 0.5.h),

                    Text(
                      '$totalReviews avaliações',
                      style: AppTheme.darkTheme.textTheme.bodySmall?.copyWith(
                        color: AppTheme.mutedText,
                      ),
                    ),
                  ],
                ),

                SizedBox(width: 6.w),

                // Rating breakdown
                Expanded(
                  child: Column(
                    children: ratingBreakdown.map((rating) {
                      final int stars = rating['stars'] ?? 5;
                      final double percentage =
                          (rating['percentage'] as num?)?.toDouble() ?? 0.0;

                      return Padding(
                        padding: EdgeInsets.symmetric(vertical: 0.5.h),
                        child: Row(
                          children: [
                            Text(
                              '$stars',
                              style: AppTheme.darkTheme.textTheme.bodySmall
                                  ?.copyWith(
                                color: AppTheme.mutedText,
                              ),
                            ),
                            SizedBox(width: 2.w),
                            CustomIconWidget(
                              iconName: 'star',
                              color: AppTheme.warningColor,
                              size: 12,
                            ),
                            SizedBox(width: 2.w),
                            Expanded(
                              child: Container(
                                height: 0.5.h,
                                decoration: BoxDecoration(
                                  color: AppTheme.borderColor
                                      .withValues(alpha: 0.3),
                                  borderRadius: BorderRadius.circular(2),
                                ),
                                child: FractionallySizedBox(
                                  alignment: Alignment.centerLeft,
                                  widthFactor: percentage / 100,
                                  child: Container(
                                    decoration: BoxDecoration(
                                      color: AppTheme.warningColor,
                                      borderRadius: BorderRadius.circular(2),
                                    ),
                                  ),
                                ),
                              ),
                            ),
                            SizedBox(width: 2.w),
                            Text(
                              '${percentage.toInt()}%',
                              style: AppTheme.darkTheme.textTheme.bodySmall
                                  ?.copyWith(
                                color: AppTheme.mutedText,
                              ),
                            ),
                          ],
                        ),
                      );
                    }).toList(),
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
