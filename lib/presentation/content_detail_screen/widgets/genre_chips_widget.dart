import 'package:flutter/material.dart';
import 'package:sizer/sizer.dart';

import '../../../core/app_export.dart';
import '../../../theme/app_theme.dart';

class GenreChipsWidget extends StatefulWidget {
  final List<String> genres;

  const GenreChipsWidget({
    super.key,
    required this.genres,
  });

  @override
  State<GenreChipsWidget> createState() => _GenreChipsWidgetState();
}

class _GenreChipsWidgetState extends State<GenreChipsWidget> {
  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      width: double.infinity,
      padding: EdgeInsets.symmetric(vertical: 2.h),
      child: SingleChildScrollView(
        scrollDirection: Axis.horizontal,
        padding: EdgeInsets.symmetric(horizontal: 4.w),
        child: Row(
          children: widget.genres.map((genre) {
            return Padding(
              padding: EdgeInsets.only(right: 2.w),
              child: Container(
                padding: EdgeInsets.symmetric(horizontal: 4.w, vertical: 1.h),
                decoration: BoxDecoration(
                  color: AppTheme.successColor.withValues(alpha: 0.2),
                  borderRadius: BorderRadius.circular(20),
                  border: Border.all(
                    color: AppTheme.successColor,
                    width: 1,
                  ),
                ),
                child: Text(
                  genre,
                  style: AppTheme.darkTheme.textTheme.bodyMedium?.copyWith(
                    color: AppTheme.successColor,
                    fontWeight: FontWeight.w600,
                  ),
                ),
              ),
            );
          }).toList(),
        ),
      ),
    );
  }
}
