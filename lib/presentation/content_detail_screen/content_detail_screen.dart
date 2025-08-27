import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:sizer/sizer.dart';

import '../../core/model/actor.dart';
import '../../core/model/medium.dart';
import '../../core/app_export.dart';
import './widgets/action_buttons_widget.dart';
import './widgets/cast_section_widget.dart';
import './widgets/genre_chips_widget.dart';
import './widgets/hero_section_widget.dart';
import './widgets/streaming_platforms_widget.dart';
import './widgets/synopsis_section_widget.dart';
import './widgets/user_ratings_widget.dart';

class ContentDetailScreen extends StatefulWidget {
  final Medium medium;
  const ContentDetailScreen({super.key, required this.medium});

  @override
  State<ContentDetailScreen> createState() => _ContentDetailScreenState();
}

class _ContentDetailScreenState extends State<ContentDetailScreen> {
  bool _isLoading = true;
  List<Actor>? _cast;
  Map<String, dynamic>? _userRatings;
  List<Map<String, dynamic>>? _streamingPlatforms;

  @override
  void initState() {
    super.initState();
    _loadContentData();
  }

  Future<void> _loadContentData() async {
    final cast = await _loadCast();
    final ratings = await _loadRatings();

    if (!mounted) return;

    setState(() {
      _cast = cast;
      _userRatings = ratings;
      _streamingPlatforms = [
        {
          "name": "Netflix",
          "type": "Streaming",
          "logoUrl": "https://images.unsplash.com/photo-1611162617474-5b21e879e113?fm=jpg&q=60&w=3000&ixlib=rb-4.0.3",
          "deepLink": "netflix://title/80057281"
        },
        {
          "name": "Amazon Prime",
          "type": "Aluguel",
          "logoUrl": "https://images.unsplash.com/photo-1560472354-b33ff0c44a43?fm=jpg&q=60&w=3000&ixlib=rb-4.0.3",
          "deepLink": "primevideo://detail/0GZQT3YWHGWCKV"
        }
      ];
      _isLoading = false;
    });
  }

  Future<List<Actor>?> _loadCast() async {
    try {
      return await getMediumCast(widget.medium.id);
    } catch (e) {
      if (mounted) {
        Fluttertoast.showToast(
          msg: 'Erro ao carregar elenco: $e',
          toastLength: Toast.LENGTH_SHORT,
          gravity: ToastGravity.BOTTOM,
          backgroundColor: AppTheme.darkTheme.colorScheme.surface,
          textColor: AppTheme.contentWhite,
        );
      }
      return null;
    }
  }

  Future<Map<String, dynamic>?> _loadRatings() async {
    try {
      return await getMediumRatings(widget.medium.id);
    } catch (e) {
      if (mounted) {
        Fluttertoast.showToast(
          msg: 'Erro ao carregar avaliações: $e',
          toastLength: Toast.LENGTH_SHORT,
          gravity: ToastGravity.BOTTOM,
          backgroundColor: AppTheme.darkTheme.colorScheme.surface,
          textColor: AppTheme.contentWhite,
        );
      }
      return null;
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
        SliverToBoxAdapter(
          child: Column(
            children: [
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
    return CustomScrollView(
      slivers: [
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
            widget.medium.title,
            style: AppTheme.darkTheme.textTheme.titleMedium?.copyWith(
              color: AppTheme.contentWhite,
              fontWeight: FontWeight.w600,
            ),
          ),
          actions: [
            IconButton(
                icon: CustomIconWidget(
                  iconName: 'favorite_border',
                  color: AppTheme.contentWhite,
                  size: 24,
                ),
                onPressed: () {
                  // Tratar favoritar
                }),
            IconButton(
                icon: CustomIconWidget(
                  iconName: 'share',
                  color: AppTheme.contentWhite,
                  size: 24,
                ),
                onPressed: () {
                  // indicar que atividade está em construção
                }),
            SizedBox(width: 2.w),
          ],
        ),
        SliverToBoxAdapter(
          child: RefreshIndicator(
            onRefresh: _refreshContent,
            color: AppTheme.accentColor,
            backgroundColor: AppTheme.secondaryDark,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                HeroSectionWidget(
                  contentData: widget.medium,
                ),
                GenreChipsWidget(
                  genres: widget.medium.genres,
                ),
                SynopsisSectionWidget(
                  synopsis: widget.medium.synopsis,
                ),
                SizedBox(height: 2.h),
                CastSectionWidget(
                  castMembers: _cast ?? [],
                ),
                SizedBox(height: 2.h),
                StreamingPlatformsWidget(
                  platforms: _streamingPlatforms ?? [],
                ),
                SizedBox(height: 2.h),
                UserRatingsWidget(
                  ratingsData: _userRatings ?? {},
                ),
                SizedBox(height: 2.h),
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
}
