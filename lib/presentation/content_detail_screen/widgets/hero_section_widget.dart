import 'package:flutter/material.dart';
import 'package:sizer/sizer.dart';

import '../../../core/app_export.dart';

class HeroSectionWidget extends StatelessWidget {
  final Map<String, dynamic> contentData;

  const HeroSectionWidget({
    super.key,
    required this.contentData,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      width: double.infinity,
      height: 50.h,
      child: Stack(
        children: [
          // Background poster image
          CustomImageWidget(
            imageUrl: contentData['posterUrl'] ??
                'https://images.unsplash.com/photo-1489599735734-79b4169c4388?fm=jpg&q=60&w=3000&ixlib=rb-4.0.3',
            width: double.infinity,
            height: 50.h,
            fit: BoxFit.cover,
          ),

          // Gradient overlay
          Container(
            width: double.infinity,
            height: 50.h,
            decoration: BoxDecoration(
              gradient: LinearGradient(
                begin: Alignment.topCenter,
                end: Alignment.bottomCenter,
                colors: [
                  Colors.transparent,
                  AppTheme.primaryDark.withValues(alpha: 0.3),
                  AppTheme.primaryDark.withValues(alpha: 0.8),
                  AppTheme.primaryDark,
                ],
                stops: const [0.0, 0.4, 0.7, 1.0],
              ),
            ),
          ),

          // Content overlay
          Positioned(
            bottom: 0,
            left: 0,
            right: 0,
            child: Container(
              padding: EdgeInsets.symmetric(horizontal: 4.w, vertical: 3.h),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                mainAxisSize: MainAxisSize.min,
                children: [
                  // Title
                  Text(
                    contentData['title'] ?? 'Título não disponível',
                    style:
                        AppTheme.darkTheme.textTheme.headlineMedium?.copyWith(
                      fontWeight: FontWeight.bold,
                      color: AppTheme.contentWhite,
                      height: 1.2,
                    ),
                    maxLines: 2,
                    overflow: TextOverflow.ellipsis,
                  ),

                  SizedBox(height: 1.h),

                  // Release year and rating row
                  Row(
                    children: [
                      // Release year
                      Container(
                        padding: EdgeInsets.symmetric(
                            horizontal: 2.w, vertical: 0.5.h),
                        decoration: BoxDecoration(
                          color: AppTheme.secondaryDark.withValues(alpha: 0.8),
                          borderRadius: BorderRadius.circular(4),
                        ),
                        child: Text(
                          contentData['releaseYear']?.toString() ?? '2024',
                          style:
                              AppTheme.darkTheme.textTheme.bodySmall?.copyWith(
                            color: AppTheme.contentWhite,
                            fontWeight: FontWeight.w500,
                          ),
                        ),
                      ),

                      SizedBox(width: 3.w),

                      // Rating
                      Row(
                        children: [
                          CustomIconWidget(
                            iconName: 'star',
                            color: AppTheme.warningColor,
                            size: 16,
                          ),
                          SizedBox(width: 1.w),
                          Text(
                            '${contentData['rating']?.toStringAsFixed(1) ?? '8.5'}/10',
                            style: AppTheme.darkTheme.textTheme.bodyMedium
                                ?.copyWith(
                              color: AppTheme.contentWhite,
                              fontWeight: FontWeight.w600,
                            ),
                          ),
                        ],
                      ),

                      const Spacer(),

                      // Duration
                      if (contentData['duration'] != null)
                        Container(
                          padding: EdgeInsets.symmetric(
                              horizontal: 2.w, vertical: 0.5.h),
                          decoration: BoxDecoration(
                            color: AppTheme.accentColor.withValues(alpha: 0.2),
                            borderRadius: BorderRadius.circular(4),
                            border: Border.all(
                              color:
                                  AppTheme.accentColor.withValues(alpha: 0.3),
                            ),
                          ),
                          child: Text(
                            contentData['duration'] ?? '120 min',
                            style: AppTheme.darkTheme.textTheme.bodySmall
                                ?.copyWith(
                              color: AppTheme.accentColor,
                              fontWeight: FontWeight.w500,
                            ),
                          ),
                        ),
                    ],
                  ),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}
