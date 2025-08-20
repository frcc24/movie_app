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

class _GenreFilterScreenState extends State<GenreFilterScreen>
    with TickerProviderStateMixin {
  late AnimationController _slideController;
  late Animation<Offset> _slideAnimation;

  List<String> selectedGenres = [];
  String selectedContentType = 'Todos';
  double selectedRating = 0.0;
  int resultsCount = 1247;

  final List<Map<String, dynamic>> genreList = [
    {
      "id": 1,
      "name": "Ação",
      "icon": "local_fire_department",
      "count": 156,
    },
    {
      "id": 2,
      "name": "Comédia",
      "icon": "sentiment_very_satisfied",
      "count": 203,
    },
    {
      "id": 3,
      "name": "Drama",
      "icon": "theater_comedy",
      "count": 189,
    },
    {
      "id": 4,
      "name": "Terror",
      "icon": "psychology",
      "count": 87,
    },
    {
      "id": 5,
      "name": "Romance",
      "icon": "favorite",
      "count": 134,
    },
    {
      "id": 6,
      "name": "Ficção Científica",
      "icon": "rocket_launch",
      "count": 98,
    },
    {
      "id": 7,
      "name": "Thriller",
      "icon": "flash_on",
      "count": 112,
    },
    {
      "id": 8,
      "name": "Aventura",
      "icon": "explore",
      "count": 145,
    },
    {
      "id": 9,
      "name": "Animação",
      "icon": "animation",
      "count": 76,
    },
    {
      "id": 10,
      "name": "Documentário",
      "icon": "movie_filter",
      "count": 89,
    },
    {
      "id": 11,
      "name": "Fantasia",
      "icon": "auto_fix_high",
      "count": 67,
    },
    {
      "id": 12,
      "name": "Crime",
      "icon": "gavel",
      "count": 91,
    },
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

  bool get hasActiveFilters =>
      selectedGenres.isNotEmpty ||
      selectedContentType != 'Todos' ||
      selectedRating > 0.0;

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
                color: hasActiveFilters
                    ? AppTheme.accentColor
                    : AppTheme.mutedText,
                fontWeight:
                    hasActiveFilters ? FontWeight.w600 : FontWeight.w400,
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
              backgroundColor: hasActiveFilters
                  ? AppTheme.accentColor
                  : AppTheme.mutedText.withValues(alpha: 0.3),
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
                  hasActiveFilters
                      ? 'Aplicar Filtros ($resultsCount resultados)'
                      : 'Selecione os filtros',
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
