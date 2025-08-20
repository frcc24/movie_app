import 'package:flutter/material.dart';
import 'package:sizer/sizer.dart';

import '../../../core/app_export.dart';
import '../../../theme/app_theme.dart';

class GenreChipsWidget extends StatefulWidget {
  final List<String> genres;
  final String? selectedGenre;
  final Function(String)? onGenreSelected;

  const GenreChipsWidget({
    super.key,
    required this.genres,
    this.selectedGenre,
    this.onGenreSelected,
  });

  @override
  State<GenreChipsWidget> createState() => _GenreChipsWidgetState();
}

class _GenreChipsWidgetState extends State<GenreChipsWidget> {
  String? _selectedGenre;

  @override
  void initState() {
    super.initState();
    _selectedGenre = widget.selectedGenre;
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
            final isSelected = _selectedGenre == genre;
            return Padding(
              padding: EdgeInsets.only(right: 2.w),
              child: GestureDetector(
                onTap: () {
                  setState(() {
                    _selectedGenre = isSelected ? null : genre;
                  });
                  widget.onGenreSelected?.call(genre);

                  // Navigate to genre filter screen
                  Navigator.pushNamed(context, '/genre-filter-screen');
                },
                child: AnimatedContainer(
                  duration: const Duration(milliseconds: 200),
                  padding: EdgeInsets.symmetric(horizontal: 4.w, vertical: 1.h),
                  decoration: BoxDecoration(
                    color: isSelected
                        ? AppTheme.successColor.withValues(alpha: 0.2)
                        : AppTheme.secondaryDark.withValues(alpha: 0.6),
                    borderRadius: BorderRadius.circular(20),
                    border: Border.all(
                      color: isSelected
                          ? AppTheme.successColor
                          : AppTheme.borderColor.withValues(alpha: 0.3),
                      width: 1,
                    ),
                  ),
                  child: Text(
                    genre,
                    style: AppTheme.darkTheme.textTheme.bodyMedium?.copyWith(
                      color: isSelected
                          ? AppTheme.successColor
                          : AppTheme.mutedText,
                      fontWeight:
                          isSelected ? FontWeight.w600 : FontWeight.w400,
                    ),
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
