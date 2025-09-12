import 'package:flutter/material.dart';
import 'package:movies__series_app/core/app_export.dart';
import 'package:sizer/sizer.dart';

class FavoriteMoviesScreen extends StatelessWidget {
  const FavoriteMoviesScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Container(
            width: 40.w,
            height: 40.w,
            decoration: BoxDecoration(
              color: AppTheme.mutedText.withValues(alpha: 0.1),
              shape: BoxShape.circle,
            ),
            child: Center(
              child: Icon(
                Icons.construction,
                color: AppTheme.mutedText,
                size: 64,
              ),
            ),
          ),
          SizedBox(height: 4.h),
          Text(
            'Página em construção',
            style: AppTheme.darkTheme.textTheme.titleLarge?.copyWith(
              color: AppTheme.contentWhite,
              fontWeight: FontWeight.w600,
            ),
            textAlign: TextAlign.center,
          ),
          SizedBox(height: 2.h),
          Text(
            'Aqui estará disponível a sua lista de favoritos',
            style: AppTheme.darkTheme.textTheme.bodyMedium?.copyWith(
              color: AppTheme.mutedText,
            ),
            textAlign: TextAlign.center,
          ),
        ],
      ),
    );
  }
}
