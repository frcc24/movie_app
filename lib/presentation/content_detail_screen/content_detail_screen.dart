import 'package:flutter/material.dart';
import 'package:sizer/sizer.dart';

import '../../core/app_export.dart';
import './widgets/action_buttons_widget.dart';
import './widgets/cast_section_widget.dart';
import './widgets/genre_chips_widget.dart';
import './widgets/hero_section_widget.dart';
import './widgets/streaming_platforms_widget.dart';
import './widgets/synopsis_section_widget.dart';
import './widgets/user_ratings_widget.dart';

class ContentDetailScreen extends StatefulWidget {
  const ContentDetailScreen({super.key});

  @override
  State<ContentDetailScreen> createState() => _ContentDetailScreenState();
}

class _ContentDetailScreenState extends State<ContentDetailScreen> {
  bool _isLoading = true;
  Map<String, dynamic>? _contentData;
  String? _selectedGenre;

  // Mock data for the content detail
  final Map<String, dynamic> _mockContentData = {
    "id": 1,
    "title": "Stranger Things",
    "releaseYear": 2016,
    "rating": 8.7,
    "duration": "51 min/ep",
    "posterUrl":
        "https://images.unsplash.com/photo-1489599735734-79b4169c4388?fm=jpg&q=60&w=3000&ixlib=rb-4.0.3",
    "genres": ["Ficção Científica", "Drama", "Terror", "Mistério", "Thriller"],
    "synopsis":
        """Quando um garoto desaparece, uma pequena cidade descobre um mistério envolvendo experimentos secretos, forças sobrenaturais aterrorizantes e uma garota muito estranha. Ambientada na década de 1980 em Hawkins, Indiana, a série acompanha um grupo de amigos que se veem no centro de eventos sobrenaturais que ameaçam não apenas suas vidas, mas o destino do mundo. Com elementos nostálgicos dos anos 80, a série combina terror, ficção científica e drama adolescente de forma única e envolvente.""",
    "cast": [
      {
        "name": "Millie Bobby Brown",
        "character": "Eleven",
        "photoUrl":
            "https://images.unsplash.com/photo-1494790108755-2616b612b786?fm=jpg&q=60&w=3000&ixlib=rb-4.0.3"
      },
      {
        "name": "Finn Wolfhard",
        "character": "Mike Wheeler",
        "photoUrl":
            "https://images.unsplash.com/photo-1507003211169-0a1dd7228f2d?fm=jpg&q=60&w=3000&ixlib=rb-4.0.3"
      },
      {
        "name": "Gaten Matarazzo",
        "character": "Dustin Henderson",
        "photoUrl":
            "https://images.unsplash.com/photo-1472099645785-5658abf4ff4e?fm=jpg&q=60&w=3000&ixlib=rb-4.0.3"
      },
      {
        "name": "Caleb McLaughlin",
        "character": "Lucas Sinclair",
        "photoUrl":
            "https://images.unsplash.com/photo-1500648767791-00dcc994a43e?fm=jpg&q=60&w=3000&ixlib=rb-4.0.3"
      },
      {
        "name": "Noah Schnapp",
        "character": "Will Byers",
        "photoUrl":
            "https://images.unsplash.com/photo-1463453091185-61582044d556?fm=jpg&q=60&w=3000&ixlib=rb-4.0.3"
      }
    ],
    "streamingPlatforms": [
      {
        "name": "Netflix",
        "type": "Streaming",
        "logoUrl":
            "https://images.unsplash.com/photo-1611162617474-5b21e879e113?fm=jpg&q=60&w=3000&ixlib=rb-4.0.3",
        "deepLink": "netflix://title/80057281"
      },
      {
        "name": "Amazon Prime",
        "type": "Aluguel",
        "logoUrl":
            "https://images.unsplash.com/photo-1560472354-b33ff0c44a43?fm=jpg&q=60&w=3000&ixlib=rb-4.0.3",
        "deepLink": "primevideo://detail/0GZQT3YWHGWCKV"
      }
    ],
    "userRatings": {
      "averageRating": 8.7,
      "totalReviews": 2847,
      "breakdown": [
        {"stars": 5, "percentage": 65.2},
        {"stars": 4, "percentage": 22.8},
        {"stars": 3, "percentage": 8.5},
        {"stars": 2, "percentage": 2.1},
        {"stars": 1, "percentage": 1.4}
      ]
    }
  };

  @override
  void initState() {
    super.initState();
    _loadContentData();
  }

  Future<void> _loadContentData() async {
    // Simulate API call
    await Future.delayed(const Duration(milliseconds: 1500));

    if (mounted) {
      setState(() {
        _contentData = _mockContentData;
        _isLoading = false;
      });
    }
  }

  Future<void> _refreshContent() async {
    setState(() {
      _isLoading = true;
    });
    await _loadContentData();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppTheme.primaryDark,
      body: _isLoading ? _buildLoadingState() : _buildContentState(),
    );
  }

  Widget _buildLoadingState() {
    return CustomScrollView(
      slivers: [
        // Loading app bar
        SliverAppBar(
          backgroundColor: AppTheme.primaryDark,
          elevation: 0,
          pinned: true,
          leading: IconButton(
            icon: CustomIconWidget(
              iconName: 'arrow_back_ios',
              color: AppTheme.contentWhite,
              size: 24,
            ),
            onPressed: () => Navigator.pop(context),
          ),
          actions: [
            IconButton(
              icon: CustomIconWidget(
                iconName: 'favorite_border',
                color: AppTheme.contentWhite,
                size: 24,
              ),
              onPressed: () {},
            ),
            IconButton(
              icon: CustomIconWidget(
                iconName: 'share',
                color: AppTheme.contentWhite,
                size: 24,
              ),
              onPressed: () {},
            ),
            SizedBox(width: 2.w),
          ],
        ),

        // Loading content
        SliverToBoxAdapter(
          child: Column(
            children: [
              // Hero section shimmer
              Container(
                width: double.infinity,
                height: 50.h,
                color: AppTheme.secondaryDark.withValues(alpha: 0.3),
                child: Center(
                  child: CircularProgressIndicator(
                    color: AppTheme.accentColor,
                  ),
                ),
              ),

              SizedBox(height: 4.h),

              // Loading text
              Text(
                'Carregando detalhes...',
                style: AppTheme.darkTheme.textTheme.bodyLarge?.copyWith(
                  color: AppTheme.mutedText,
                ),
              ),

              SizedBox(height: 20.h),
            ],
          ),
        ),
      ],
    );
  }

  Widget _buildContentState() {
    if (_contentData == null) {
      return _buildErrorState();
    }

    return CustomScrollView(
      slivers: [
        // App bar with blur effect
        SliverAppBar(
          backgroundColor: AppTheme.primaryDark.withValues(alpha: 0.95),
          elevation: 0,
          pinned: true,
          expandedHeight: 0,
          leading: IconButton(
            icon: CustomIconWidget(
              iconName: 'arrow_back_ios',
              color: AppTheme.contentWhite,
              size: 24,
            ),
            onPressed: () => Navigator.pop(context),
          ),
          title: Text(
            _contentData!['title'] ?? 'Detalhes',
            style: AppTheme.darkTheme.textTheme.titleMedium?.copyWith(
              color: AppTheme.contentWhite,
              fontWeight: FontWeight.w600,
            ),
          ),
          actions: [
            IconButton(
              icon: CustomIconWidget(
                iconName: 'search',
                color: AppTheme.contentWhite,
                size: 24,
              ),
              onPressed: () =>
                  Navigator.pushNamed(context, '/content-browse-screen'),
            ),
            IconButton(
              icon: CustomIconWidget(
                iconName: 'filter_list',
                color: AppTheme.contentWhite,
                size: 24,
              ),
              onPressed: () =>
                  Navigator.pushNamed(context, '/genre-filter-screen'),
            ),
            SizedBox(width: 2.w),
          ],
        ),

        // Main content
        SliverToBoxAdapter(
          child: RefreshIndicator(
            onRefresh: _refreshContent,
            color: AppTheme.accentColor,
            backgroundColor: AppTheme.secondaryDark,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                // Hero section
                HeroSectionWidget(
                  contentData: _contentData!,
                ),

                // Genre chips
                GenreChipsWidget(
                  genres:
                      (_contentData!['genres'] as List?)?.cast<String>() ?? [],
                  selectedGenre: _selectedGenre,
                  onGenreSelected: (genre) {
                    setState(() {
                      _selectedGenre = genre;
                    });
                  },
                ),

                // Synopsis section
                SynopsisSectionWidget(
                  synopsis:
                      _contentData!['synopsis'] ?? 'Sinopse não disponível.',
                ),

                SizedBox(height: 2.h),

                // Cast section
                CastSectionWidget(
                  castMembers: (_contentData!['cast'] as List?)
                          ?.cast<Map<String, dynamic>>() ??
                      [],
                ),

                SizedBox(height: 2.h),

                // Streaming platforms
                StreamingPlatformsWidget(
                  platforms: (_contentData!['streamingPlatforms'] as List?)
                          ?.cast<Map<String, dynamic>>() ??
                      [],
                ),

                SizedBox(height: 2.h),

                // User ratings
                UserRatingsWidget(
                  ratingsData: _contentData!['userRatings'] ?? {},
                ),

                SizedBox(height: 2.h),

                // Action buttons
                ActionButtonsWidget(
                  isInWatchlist: false,
                  onWatchlistToggle: () {
                    // Handle watchlist toggle
                  },
                  onShare: () {
                    // Handle share
                  },
                ),

                SizedBox(height: 4.h),
              ],
            ),
          ),
        ),
      ],
    );
  }

  Widget _buildErrorState() {
    return Center(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          CustomIconWidget(
            iconName: 'error_outline',
            color: AppTheme.mutedText,
            size: 48,
          ),
          SizedBox(height: 2.h),
          Text(
            'Erro ao carregar conteúdo',
            style: AppTheme.darkTheme.textTheme.titleMedium?.copyWith(
              color: AppTheme.contentWhite,
            ),
          ),
          SizedBox(height: 1.h),
          Text(
            'Verifique sua conexão e tente novamente',
            style: AppTheme.darkTheme.textTheme.bodyMedium?.copyWith(
              color: AppTheme.mutedText,
            ),
            textAlign: TextAlign.center,
          ),
          SizedBox(height: 3.h),
          ElevatedButton(
            onPressed: _refreshContent,
            style: ElevatedButton.styleFrom(
              backgroundColor: AppTheme.accentColor,
              foregroundColor: AppTheme.contentWhite,
            ),
            child: Text('Tentar Novamente'),
          ),
        ],
      ),
    );
  }
}
