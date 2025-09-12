import 'package:flutter/material.dart';
import 'package:sizer/sizer.dart';

import '../../../../core/app_export.dart';

class GenreFilterWidget extends StatelessWidget {
  final String selectedGenre;
  final List<String> genres;
  final ValueChanged<String> onGenreSelected;

  const GenreFilterWidget({
    super.key,
    required this.selectedGenre,
    required this.genres,
    required this.onGenreSelected,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.symmetric(horizontal: 4.w, vertical: 1.h),
      child: GestureDetector(
        onTap: () => _showGenreBottomSheet(context),
        child: Container(
          padding: EdgeInsets.symmetric(horizontal: 4.w, vertical: 1.5.h),
          decoration: BoxDecoration(
            color: AppTheme.darkTheme.colorScheme.surface,
            borderRadius: BorderRadius.circular(12),
            border: Border.all(
              color: AppTheme.borderColor.withValues(alpha: 0.3),
            ),
          ),
          child: Row(
            mainAxisSize: MainAxisSize.min,
            children: [
              Icon(
                Icons.filter_list,
                color: AppTheme.accentColor,
                size: 20,
              ),
              SizedBox(width: 2.w),
              Text(
                selectedGenre == 'Todos' ? 'Filtrar por Gênero' : selectedGenre,
                style: AppTheme.darkTheme.textTheme.bodyMedium?.copyWith(
                  color: selectedGenre == 'Todos' ? AppTheme.mutedText : AppTheme.contentWhite,
                  fontWeight: FontWeight.w500,
                ),
              ),
              SizedBox(width: 2.w),
              Icon(
                Icons.keyboard_arrow_down,
                color: AppTheme.mutedText,
                size: 20,
              ),
            ],
          ),
        ),
      ),
    );
  }

  void _showGenreBottomSheet(BuildContext context) {
    showModalBottomSheet(
      context: context,
      backgroundColor: AppTheme.darkTheme.colorScheme.surface,
      shape: const RoundedRectangleBorder(
        borderRadius: BorderRadius.vertical(top: Radius.circular(20)),
      ),
      isScrollControlled: true,
      builder: (context) => DraggableScrollableSheet(
        initialChildSize: 0.6,
        maxChildSize: 0.8,
        minChildSize: 0.4,
        expand: false,
        builder: (context, scrollController) => Container(
          padding: EdgeInsets.all(6.w),
          child: Column(
            children: [
              Container(
                width: 12.w,
                height: 0.5.h,
                decoration: BoxDecoration(
                  color: AppTheme.borderColor,
                  borderRadius: BorderRadius.circular(2),
                ),
              ),
              SizedBox(height: 3.h),
              Text(
                'Filtrar por Gênero',
                style: AppTheme.darkTheme.textTheme.titleLarge?.copyWith(
                  fontWeight: FontWeight.w600,
                ),
              ),
              SizedBox(height: 3.h),
              Expanded(
                child: ListView.builder(
                  controller: scrollController,
                  itemCount: genres.length,
                  itemBuilder: (context, index) {
                    final genre = genres[index];
                    final isSelected = genre == selectedGenre;

                    return ListTile(
                      contentPadding: EdgeInsets.symmetric(horizontal: 2.w),
                      leading: Icon(
                        isSelected ? Icons.radio_button_checked : Icons.radio_button_unchecked,
                        color: isSelected ? AppTheme.accentColor : AppTheme.mutedText,
                        size: 24,
                      ),
                      title: Text(
                        genre,
                        style: AppTheme.darkTheme.textTheme.bodyMedium?.copyWith(
                          color: isSelected ? AppTheme.accentColor : AppTheme.contentWhite,
                          fontWeight: isSelected ? FontWeight.w600 : FontWeight.w400,
                        ),
                      ),
                      onTap: () {
                        onGenreSelected(genre);
                        Navigator.pop(context);
                      },
                    );
                  },
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
