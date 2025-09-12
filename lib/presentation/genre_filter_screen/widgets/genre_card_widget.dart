import 'package:flutter/material.dart';
import 'package:sizer/sizer.dart';

import '../../../core/app_export.dart';

class GenreCardWidget extends StatelessWidget {
  final Map<String, dynamic> genre;
  final bool isSelected;
  final VoidCallback onTap;

  const GenreCardWidget({
    super.key,
    required this.genre,
    required this.isSelected,
    required this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: AnimatedContainer(
        duration: const Duration(milliseconds: 200),
        margin: EdgeInsets.all(1.w),
        decoration: BoxDecoration(
          color: isSelected ? AppTheme.accentColor.withValues(alpha: 0.1) : AppTheme.secondaryDark,
          borderRadius: BorderRadius.circular(12),
          border: Border.all(
            color: isSelected ? AppTheme.accentColor : AppTheme.borderColor.withValues(alpha: 0.3),
            width: isSelected ? 2 : 1,
          ),
          boxShadow: isSelected
              ? [
                  BoxShadow(
                    color: AppTheme.accentColor.withValues(alpha: 0.2),
                    blurRadius: 8,
                    offset: const Offset(0, 2),
                  ),
                ]
              : null,
        ),
        child: Stack(
          children: [
            Padding(
              padding: EdgeInsets.all(4.w),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                crossAxisAlignment: CrossAxisAlignment.stretch,
                children: [
                  Icon(
                    genre['icon'] as IconData,
                    color: isSelected ? AppTheme.accentColor : AppTheme.mutedText,
                    size: 8.w,
                  ),
                  SizedBox(height: 2.h),
                  Text(
                    genre['name'] as String,
                    style: AppTheme.darkTheme.textTheme.titleSmall?.copyWith(
                      color: isSelected ? AppTheme.accentColor : AppTheme.contentWhite,
                      fontWeight: isSelected ? FontWeight.w600 : FontWeight.w500,
                    ),
                    textAlign: TextAlign.center,
                    maxLines: 2,
                    overflow: TextOverflow.ellipsis,
                  ),
                  SizedBox(height: 1.h),
                ],
              ),
            ),
            if (isSelected)
              Positioned(
                top: 2.w,
                right: 2.w,
                child: Container(
                  padding: EdgeInsets.all(1.w),
                  decoration: BoxDecoration(
                    color: AppTheme.accentColor,
                    shape: BoxShape.circle,
                  ),
                  child: Icon(
                    Icons.check,
                    color: AppTheme.contentWhite,
                    size: 4.w,
                  ),
                ),
              ),
          ],
        ),
      ),
    );
  }
}
