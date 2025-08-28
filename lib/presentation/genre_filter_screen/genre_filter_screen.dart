import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:sizer/sizer.dart';

import '../../core/app_export.dart';
import './widgets/content_type_toggle_widget.dart';
import './widgets/filter_results_widget.dart';
import './widgets/genre_card_widget.dart';
import './widgets/rating_slider_widget.dart';

class GenreFilterScreen extends StatefulWidget {
  const GenreFilterScreen({super.key});

  @override
  State<GenreFilterScreen> createState() => _GenreFilterScreenState();
}

class _GenreFilterScreenState extends State<GenreFilterScreen> with TickerProviderStateMixin {
  late AnimationController _slideController;
  late Animation<Offset> _slideAnimation;

  List<String> selectedGenres = [];
  String selectedContentType = 'Todos';
  double selectedRating = 0.0;
  int resultsCount = 1247;

  final List<Map<String, dynamic>> genreList = [
    {'id': 1, 'name': 'Todos', 'count': 34, 'icon': 'apps'},
    {'id': 2, 'name': 'Ação', 'count': 8, 'icon': 'sports_martial_arts'},
    {'id': 3, 'name': 'Aventura', 'count': 5, 'icon': 'terrain'},
    {'id': 4, 'name': 'Comédia', 'count': 1, 'icon': 'sentiment_satisfied'},
    {'id': 5, 'name': 'Drama', 'count': 20, 'icon': 'theater_comedy'},
    {'id': 6, 'name': 'Ficção Científica', 'count': 8, 'icon': 'science'},
    {'id': 7, 'name': 'Terror', 'count': 1, 'icon': 'ghost'},
    {'id': 8, 'name': 'Romance', 'count': 1, 'icon': 'favorite'},
    {'id': 9, 'name': 'Thriller', 'count': 0, 'icon': 'psychology'},
    {'id': 10, 'name': 'Documentário', 'count': 0, 'icon': 'menu_book'},
    {'id': 11, 'name': 'Animação', 'count': 1, 'icon': 'animation'},
    {'id': 12, 'name': 'Crime', 'count': 8, 'icon': 'gavel'},
    {'id': 13, 'name': 'Fantasia', 'count': 4, 'icon': 'auto_awesome'},
    {'id': 14, 'name': 'Mistério', 'count': 3, 'icon': 'help_outline'},
    {'id': 15, 'name': 'Guerra', 'count': 0, 'icon': 'military_tech'},
    {'id': 16, 'name': 'Histórico', 'count': 1, 'icon': 'history_edu'},
    {'id': 17, 'name': 'Música', 'count': 1, 'icon': 'music_note'},
    {'id': 18, 'name': 'Família', 'count': 0, 'icon': 'family_restroom'},
    {'id': 19, 'name': 'Western', 'count': 0, 'icon': 'outdoor_grill'},
    {'id': 20, 'name': 'Biografia', 'count': 0, 'icon': 'person'},
    {'id': 21, 'name': 'Suspense', 'count': 6, 'icon': 'visibility'},
    {'id': 22, 'name': 'Cyberpunk', 'count': 1, 'icon': 'computer'},
    {'id': 23, 'name': 'Sobrevivência', 'count': 1, 'icon': 'terrain'},
    {'id': 24, 'name': 'Jovem Adulto', 'count': 1, 'icon': 'school'},
  ];

  @override
  void initState() {
    super.initState();
    _slideController = AnimationController(
      duration: const Duration(milliseconds: 300),
      vsync: this,
    );
    _slideAnimation = Tween<Offset>(
      begin: const Offset(0, 1),
      end: Offset.zero,
    ).animate(CurvedAnimation(
      parent: _slideController,
      curve: Curves.easeOutCubic,
    ));

    _slideController.forward();
    _updateResultsCount();
  }

  @override
  void dispose() {
    _slideController.dispose();
    super.dispose();
  }

  void _updateResultsCount() {
    int baseCount = 1247;
    int filteredCount = baseCount;

    // Simulate filtering logic
    if (selectedGenres.isNotEmpty) {
      filteredCount = (filteredCount * 0.6).round();
    }

    if (selectedContentType == 'Filmes') {
      filteredCount = (filteredCount * 0.7).round();
    } else if (selectedContentType == 'Séries') {
      filteredCount = (filteredCount * 0.3).round();
    }

    if (selectedRating > 0.0) {
      filteredCount = (filteredCount * (1 - selectedRating / 15)).round();
    }

    setState(() {
      resultsCount = filteredCount.clamp(0, baseCount);
    });
  }

  void _toggleGenre(String genreName) {
    HapticFeedback.lightImpact();
    setState(() {
      if (selectedGenres.contains(genreName)) {
        selectedGenres.remove(genreName);
      } else {
        selectedGenres.add(genreName);
      }
    });
    _updateResultsCount();
  }

  void _clearAllFilters() {
    HapticFeedback.mediumImpact();
    setState(() {
      selectedGenres.clear();
      selectedContentType = 'Todos';
      selectedRating = 0.0;
    });
    _updateResultsCount();
  }

  void _applyFilters() {
    HapticFeedback.lightImpact();
    Navigator.pop(context, {
      'selectedGenres': selectedGenres,
      'contentType': selectedContentType,
      'rating': selectedRating,
      'resultsCount': resultsCount,
    });
  }

  void _cancelFilters() {
    _slideController.reverse().then((_) {
      Navigator.pop(context);
    });
  }

  bool get hasActiveFilters => selectedGenres.isNotEmpty || selectedContentType != 'Todos' || selectedRating > 0.0;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppTheme.primaryDark,
      body: SlideTransition(
        position: _slideAnimation,
        child: SafeArea(
          child: Column(
            children: [
              _buildHeader(),
              Expanded(
                child: SingleChildScrollView(
                  physics: const BouncingScrollPhysics(),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      SizedBox(height: 2.h),
                      _buildClearFiltersButton(),
                      SizedBox(height: 2.h),
                      ContentTypeToggleWidget(
                        selectedType: selectedContentType,
                        onTypeChanged: (type) {
                          setState(() {
                            selectedContentType = type;
                          });
                          _updateResultsCount();
                        },
                      ),
                      RatingSliderWidget(
                        currentRating: selectedRating,
                        onRatingChanged: (rating) {
                          setState(() {
                            selectedRating = rating;
                          });
                          _updateResultsCount();
                        },
                      ),
                      _buildGenresSection(),
                      SizedBox(height: 2.h),
                      FilterResultsWidget(
                        resultsCount: resultsCount,
                        selectedGenres: selectedGenres,
                        selectedContentType: selectedContentType,
                        selectedRating: selectedRating,
                      ),
                      SizedBox(height: 10.h),
                    ],
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
      bottomSheet: _buildBottomActions(),
    );
  }

  Widget _buildHeader() {
    return Container(
      padding: EdgeInsets.symmetric(horizontal: 4.w, vertical: 2.h),
      decoration: BoxDecoration(
        color: AppTheme.primaryDark,
        border: Border(
          bottom: BorderSide(
            color: AppTheme.borderColor.withValues(alpha: 0.3),
            width: 1,
          ),
        ),
      ),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          GestureDetector(
            onTap: _cancelFilters,
            child: Text(
              'Cancelar',
              style: AppTheme.darkTheme.textTheme.titleSmall?.copyWith(
                color: AppTheme.mutedText,
              ),
            ),
          ),
          Text(
            'Filtros',
            style: AppTheme.darkTheme.textTheme.titleLarge?.copyWith(
              color: AppTheme.contentWhite,
              fontWeight: FontWeight.w600,
            ),
          ),
          GestureDetector(
            onTap: hasActiveFilters ? _applyFilters : null,
            child: Text(
              'Aplicar',
              style: AppTheme.darkTheme.textTheme.titleSmall?.copyWith(
                color: hasActiveFilters ? AppTheme.accentColor : AppTheme.mutedText,
                fontWeight: hasActiveFilters ? FontWeight.w600 : FontWeight.w400,
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildClearFiltersButton() {
    return Padding(
      padding: EdgeInsets.symmetric(horizontal: 4.w),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Text(
            'Gêneros',
            style: AppTheme.darkTheme.textTheme.titleMedium?.copyWith(
              color: AppTheme.contentWhite,
              fontWeight: FontWeight.w600,
            ),
          ),
          if (hasActiveFilters)
            GestureDetector(
              onTap: _clearAllFilters,
              child: Container(
                padding: EdgeInsets.symmetric(horizontal: 3.w, vertical: 1.h),
                decoration: BoxDecoration(
                  color: AppTheme.accentColor.withValues(alpha: 0.1),
                  borderRadius: BorderRadius.circular(8),
                  border: Border.all(
                    color: AppTheme.accentColor.withValues(alpha: 0.3),
                  ),
                ),
                child: Row(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    CustomIconWidget(
                      iconName: 'clear',
                      color: AppTheme.accentColor,
                      size: 4.w,
                    ),
                    SizedBox(width: 1.w),
                    Text(
                      'Limpar Filtros',
                      style: AppTheme.darkTheme.textTheme.labelMedium?.copyWith(
                        color: AppTheme.accentColor,
                        fontWeight: FontWeight.w500,
                      ),
                    ),
                  ],
                ),
              ),
            ),
        ],
      ),
    );
  }

  Widget _buildGenresSection() {
    return Padding(
      padding: EdgeInsets.symmetric(horizontal: 2.w),
      child: GridView.builder(
        shrinkWrap: true,
        physics: const NeverScrollableScrollPhysics(),
        gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
          crossAxisCount: 2,
          childAspectRatio: 1.1,
          crossAxisSpacing: 2.w,
          mainAxisSpacing: 2.w,
        ),
        itemCount: genreList.length,
        itemBuilder: (context, index) {
          final genre = genreList[index];
          final genreName = genre['name'] as String;
          final isSelected = selectedGenres.contains(genreName);

          return GenreCardWidget(
            genre: genre,
            isSelected: isSelected,
            onTap: () => _toggleGenre(genreName),
          );
        },
      ),
    );
  }

  Widget _buildBottomActions() {
    return Container(
      padding: EdgeInsets.all(4.w),
      decoration: BoxDecoration(
        color: AppTheme.surfaceDark,
        border: Border(
          top: BorderSide(
            color: AppTheme.borderColor.withValues(alpha: 0.3),
            width: 1,
          ),
        ),
      ),
      child: SafeArea(
        child: SizedBox(
          width: double.infinity,
          child: ElevatedButton(
            onPressed: hasActiveFilters ? _applyFilters : null,
            style: ElevatedButton.styleFrom(
              backgroundColor: hasActiveFilters ? AppTheme.accentColor : AppTheme.mutedText.withValues(alpha: 0.3),
              foregroundColor: AppTheme.contentWhite,
              padding: EdgeInsets.symmetric(vertical: 4.h),
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(12),
              ),
              elevation: hasActiveFilters ? 4 : 0,
            ),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                CustomIconWidget(
                  iconName: 'filter_list',
                  color: AppTheme.contentWhite,
                  size: 5.w,
                ),
                SizedBox(width: 2.w),
                Text(
                  hasActiveFilters ? 'Aplicar Filtros ($resultsCount resultados)' : 'Selecione os filtros',
                  style: AppTheme.darkTheme.textTheme.titleSmall?.copyWith(
                    color: AppTheme.contentWhite,
                    fontWeight: FontWeight.w600,
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
