import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:movies__series_app/core/enums/media_type.dart';
import 'package:sizer/sizer.dart';

import '../../core/app_export.dart';
import '../../core/model/medium.dart';
import '../../theme/app_theme.dart';
import '../../widgets/custom_app_bar.dart';
import '../../widgets/custom_bottom_bar.dart';
import './widgets/content_card_widget.dart';
import './widgets/content_skeleton_widget.dart';
import './widgets/empty_state_widget.dart';
import './widgets/error_retry_widget.dart';
import './widgets/genre_filter_widget.dart';

class ContentBrowseScreen extends StatefulWidget {
  const ContentBrowseScreen({super.key});

  @override
  State<ContentBrowseScreen> createState() => _ContentBrowseScreenState();
}

class _ContentBrowseScreenState extends State<ContentBrowseScreen> with TickerProviderStateMixin {
  late TabController _tabController;
  late ScrollController _scrollController;

  bool _isLoading = false;
  bool _hasError = false;
  bool _isLoadingMore = false;
  String _selectedGenre = 'Todos';
  int _currentPage = 1;
  final int _itemsPerPage = 10;

  List<Map<String, dynamic>> _allContent = [];
  List<Map<String, dynamic>> _filteredContent = [];

  final List<String> _genres = [
    'Todos',
    'Ação',
    'Aventura',
    'Comédia',
    'Drama',
    'Ficção Científica',
    'Terror',
    'Romance',
    'Thriller',
    'Documentário',
    'Animação',
    'Crime',
    'Fantasia',
    'Mistério',
    'Guerra',
    'História',
    'Música',
    'Família',
    'Western',
    'Biografia'
  ];

  @override
  void initState() {
    super.initState();
    _scrollController = ScrollController();
    _scrollController.addListener(_onScroll);
    _loadInitialContent();
  }

  @override
  void dispose() {
    _tabController.dispose();
    _scrollController.dispose();
    super.dispose();
  }

  void _onScroll() {
    if (_scrollController.position.pixels >= _scrollController.position.maxScrollExtent - 200) {
      _loadMoreContent();
    }
  }

  Future<void> _loadInitialContent() async {
    setState(() {
      _isLoading = true;
      _hasError = false;
    });

    try {
      await Future.delayed(const Duration(milliseconds: 1500));

      final mockContent = _generateMockContent();
      setState(() {
        _allContent = mockContent;
        _filteredContent = _filterContentByGenre(mockContent, _selectedGenre);
        _isLoading = false;
        _currentPage = 1;
      });
    } catch (e) {
      setState(() {
        _isLoading = false;
        _hasError = true;
      });
    }
  }

  Future<void> _loadMoreContent() async {
    if (_isLoadingMore || _hasError) return;

    setState(() {
      _isLoadingMore = true;
    });

    try {
      await Future.delayed(const Duration(milliseconds: 800));

      final newContent = _generateMockContent(page: _currentPage + 1);
      setState(() {
        _allContent.addAll(newContent);
        _filteredContent = _filterContentByGenre(_allContent, _selectedGenre);
        _isLoadingMore = false;
        _currentPage++;
      });
    } catch (e) {
      setState(() {
        _isLoadingMore = false;
      });
    }
  }

  Future<void> _refreshContent() async {
    await _loadInitialContent();
  }

  List<Map<String, dynamic>> _generateMockContent({int page = 1}) {
    final baseIndex = (page - 1) * _itemsPerPage;

    return List.generate(_itemsPerPage, (index) {
      final contentIndex = baseIndex + index;
      final isMovie = contentIndex % 2 == 0;

      return {
        "id": contentIndex + 1,
        "title": isMovie ? _movieTitles[contentIndex % _movieTitles.length] : _serieTitles[contentIndex % _serieTitles.length],
        "type": isMovie ? "Filme" : "Série",
        "genres": _getRandomGenres(),
        "rating": (6.0 + (contentIndex % 4) * 0.8).clamp(6.0, 9.6),
        "platform": _platforms[contentIndex % _platforms.length],
        "poster": _posterUrls[contentIndex % _posterUrls.length],
        "synopsis": isMovie ? _movieSynopsis[contentIndex % _movieSynopsis.length] : _serieSynopsis[contentIndex % _serieSynopsis.length],
        "year": 2020 + (contentIndex % 4),
        "duration": isMovie ? "${90 + (contentIndex % 60)} min" : "${1 + (contentIndex % 5)} temporadas",
      };
    });
  }

  List<String> _getRandomGenres() {
    final availableGenres = _genres.where((g) => g != 'Todos').toList();
    availableGenres.shuffle();
    return availableGenres.take(2 + (DateTime.now().millisecond % 2)).toList();
  }

  List<Map<String, dynamic>> _filterContentByGenre(List<Map<String, dynamic>> content, String genre) {
    if (genre == 'Todos') return content;

    return content.where((item) {
      final itemGenres = (item['genres'] as List).cast<String>();
      return itemGenres.contains(genre);
    }).toList();
  }

  void _onGenreSelected(String genre) {
    setState(() {
      _selectedGenre = genre;
      _filteredContent = _filterContentByGenre(_allContent, genre);
    });

    Fluttertoast.showToast(
      msg: genre == 'Todos' ? 'Mostrando todo o conteúdo' : 'Filtrado por: $genre',
      toastLength: Toast.LENGTH_SHORT,
      gravity: ToastGravity.BOTTOM,
      backgroundColor: AppTheme.darkTheme.colorScheme.surface,
      textColor: AppTheme.contentWhite,
    );
  }

  void _onContentTap(Map<String, dynamic> content) {
    Navigator.pushNamed(
      context,
      '/content-detail-screen',
      arguments: Medium(
        id: 1,
        type: MediaType.movie,
        title: 'Vingadores: Ultimato',
        genres: ['ação', 'aventura'],
        synopsis:
            'Após os eventos devastadores de "Vingadores: Guerra Infinita", o universo está em ruínas. Com a ajuda dos aliados restantes, os Vingadores se reúnem mais uma vez para desfazer as ações de Thanos e restaurar a ordem no universo.',
        rating: 8,
        streamingPlatform: ['Netflix'],
        year: 2020,
        duration: '120 min',
      ),
    );
  }

  void _onFavorite(Map<String, dynamic> content) {
    Fluttertoast.showToast(
      msg: '${content['title']} adicionado aos favoritos',
      toastLength: Toast.LENGTH_SHORT,
      gravity: ToastGravity.BOTTOM,
      backgroundColor: AppTheme.accentColor,
      textColor: AppTheme.contentWhite,
    );
  }

  void _onShare(Map<String, dynamic> content) {
    Fluttertoast.showToast(
      msg: 'Compartilhando: ${content['title']}',
      toastLength: Toast.LENGTH_SHORT,
      gravity: ToastGravity.BOTTOM,
      backgroundColor: AppTheme.successColor,
      textColor: AppTheme.primaryDark,
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppTheme.darkTheme.scaffoldBackgroundColor,
      appBar: const CustomAppBar(
        title: 'CineList',
      ),
      body: Column(
        children: [
          GenreFilterWidget(
            selectedGenre: _selectedGenre,
            genres: _genres,
            onGenreSelected: _onGenreSelected,
          ),
          Expanded(
            child: _buildContent(),
          ),
        ],
      ),
      bottomNavigationBar: const CustomBottomBar(
        variant: CustomBottomBarVariant.primary,
        currentIndex: 0,
      ),
    );
  }

  Widget _buildContent() {
    if (_isLoading) {
      return _buildLoadingState();
    }

    if (_hasError) {
      return _buildErrorState();
    }

    if (_filteredContent.isEmpty) {
      return _buildEmptyState();
    }

    return _buildContentList();
  }

  Widget _buildLoadingState() {
    return ListView.builder(
      padding: EdgeInsets.symmetric(vertical: 2.h),
      itemCount: 6,
      itemBuilder: (context, index) => const ContentSkeletonWidget(),
    );
  }

  Widget _buildErrorState() {
    return Center(
      child: ErrorRetryWidget(
        message: 'Não foi possível carregar o conteúdo. Verifique sua conexão com a internet.',
        onRetry: _loadInitialContent,
      ),
    );
  }

  Widget _buildEmptyState() {
    return EmptyStateWidget(
      message: _selectedGenre == 'Todos' ? 'Não há conteúdo disponível no momento.' : 'Não encontramos conteúdo para o gênero "$_selectedGenre".',
      actionText: 'Limpar Filtro',
      onAction: _selectedGenre != 'Todos' ? () => _onGenreSelected('Todos') : null,
    );
  }

  Widget _buildContentList() {
    return RefreshIndicator(
      onRefresh: _refreshContent,
      color: AppTheme.accentColor,
      backgroundColor: AppTheme.darkTheme.colorScheme.surface,
      child: ListView.builder(
        controller: _scrollController,
        padding: EdgeInsets.symmetric(vertical: 2.h),
        itemCount: _filteredContent.length + (_isLoadingMore ? 1 : 0),
        itemBuilder: (context, index) {
          if (index == _filteredContent.length) {
            return _buildLoadingMoreIndicator();
          }

          final content = _filteredContent[index];
          return ContentCardWidget(
            content: content,
            onTap: () => _onContentTap(content),
            onFavorite: () => _onFavorite(content),
            onShare: () => _onShare(content),
          );
        },
      ),
    );
  }

  Widget _buildLoadingMoreIndicator() {
    return Container(
      padding: EdgeInsets.all(4.w),
      child: Center(
        child: CircularProgressIndicator(
          color: AppTheme.accentColor,
          strokeWidth: 2,
        ),
      ),
    );
  }

  // Mock data arrays
  final List<String> _movieTitles = [
    'Vingadores: Ultimato',
    'Parasita',
    'Coringa',
    'Pantera Negra',
    'Interestelar',
    'A Origem',
    'Pulp Fiction',
    'O Poderoso Chefão',
    'Cidade de Deus',
    'Central do Brasil',
    'Tropa de Elite',
    'Carandiru',
    'O Auto da Compadecida',
    'Que Horas Ela Volta?',
    'Aquarius',
    'Bacurau',
    'O Som ao Redor',
    'Kleber Mendonça Filho',
    'Dona Flor e Seus Dois Maridos',
    'Gabriela'
  ];

  final List<String> _serieTitles = [
    'Stranger Things',
    'The Crown',
    'Breaking Bad',
    'Game of Thrones',
    'The Office',
    'Friends',
    'Narcos',
    '3%',
    'La Casa de Papel',
    'Elite',
    'Dark',
    'Mindhunter',
    'Orange Is the New Black',
    'House of Cards',
    'Black Mirror',
    'The Witcher',
    'Ozark',
    'Better Call Saul',
    'The Mandalorian',
    'Bridgerton'
  ];

  final List<String> _platforms = ['Netflix', 'Amazon Prime', 'Disney+', 'HBO Max', 'Apple TV+', 'Paramount+', 'Globoplay', 'Pluto TV'];

  final List<String> _posterUrls = [
    'https://images.unsplash.com/photo-1489599904472-af35ff2c7c3f?w=400&h=600&fit=crop',
    'https://images.unsplash.com/photo-1518676590629-3dcbd9c5a5c9?w=400&h=600&fit=crop',
    'https://images.unsplash.com/photo-1440404653325-ab127d49abc1?w=400&h=600&fit=crop',
    'https://images.unsplash.com/photo-1485846234645-a62644f84728?w=400&h=600&fit=crop',
    'https://images.unsplash.com/photo-1509347528160-9329d33b2588?w=400&h=600&fit=crop',
    'https://images.unsplash.com/photo-1536440136628-849c177e76a1?w=400&h=600&fit=crop',
    'https://images.unsplash.com/photo-1594909122845-11baa439b7bf?w=400&h=600&fit=crop',
    'https://images.unsplash.com/photo-1478720568477-b0ac8e3b7b5b?w=400&h=600&fit=crop',
    'https://images.unsplash.com/photo-1517604931442-7e0c8ed2963c?w=400&h=600&fit=crop',
    'https://images.unsplash.com/photo-1515634928627-2a4e0dae3ddf?w=400&h=600&fit=crop'
  ];

  final List<String> _movieSynopsis = [
    'Uma jornada épica que reúne os maiores heróis da Terra em uma batalha decisiva.',
    'Um thriller psicológico que explora as complexidades da sociedade moderna.',
    'Uma história de origem sombria que redefine o conceito de vilão.',
    'Uma aventura espacial que desafia nossa compreensão do tempo e espaço.',
    'Um drama familiar que retrata a realidade brasileira com sensibilidade.',
  ];

  final List<String> _serieSynopsis = [
    'Uma série de mistério sobrenatural ambientada nos anos 80.',
    'Um drama histórico que retrata a família real britânica.',
    'A transformação de um professor de química em um criminoso.',
    'Uma saga épica de poder, traição e dragões em um mundo fantástico.',
    'Uma comédia sobre o cotidiano de um escritório americano.',
  ];
}
