import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:sizer/sizer.dart';

import '../../core/app_export.dart';
import '../../core/model/medium.dart';
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
  late int _totalItems;

  List<Medium> _allContent = [];
  List<Medium> _filteredContent = [];

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
    'Histórico',
    'Música',
    'Família',
    'Western',
    'Biografia',
    'Suspense',
    'Cyberpunk',
    'Sobrevivência',
    'Jovem Adulto'
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
    if (_scrollController.position.pixels >= _scrollController.position.maxScrollExtent - 200 &&
        !_isLoadingMore &&
        !_hasError &&
        _filteredContent.length < _totalItems) {
      _loadMoreContent();
    }
  }

  Future<void> _loadInitialContent() async {
    setState(() {
      _isLoading = true;
      _hasError = false;
    });

    try {
      final contentPage = await getMediaPage();
      final content = contentPage.data;
      if (!mounted) return;

      setState(() {
        _allContent = content;
        _filteredContent = _filterContentByGenre(content, _selectedGenre);
        _isLoading = false;
        _currentPage = contentPage.pagination.currentPage;
        _totalItems = contentPage.pagination.totalItems;
      });
    } catch (e) {
      Fluttertoast.showToast(
        msg: 'Erro ao carregar mídias: $e',
        toastLength: Toast.LENGTH_SHORT,
        gravity: ToastGravity.BOTTOM,
        backgroundColor: AppTheme.darkTheme.colorScheme.surface,
        textColor: AppTheme.contentWhite,
      );
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
      final newContentPage = await getMediaPage(
        page: _currentPage + 1,
        genre: _selectedGenre == 'Todos' ? null : _selectedGenre,
      );
      final newContent = newContentPage.data;

      if (!mounted) return;
      setState(() {
        _allContent.addAll(newContent);
        _filteredContent = _filterContentByGenre(_allContent, _selectedGenre);
        _isLoadingMore = false;
        _currentPage++;
        _totalItems = newContentPage.pagination.totalItems;
      });
    } catch (e) {
      Fluttertoast.showToast(
        msg: 'Erro ao carregar mais mídias: $e',
        toastLength: Toast.LENGTH_SHORT,
        gravity: ToastGravity.BOTTOM,
        backgroundColor: AppTheme.darkTheme.colorScheme.surface,
        textColor: AppTheme.contentWhite,
      );
      setState(() {
        _isLoadingMore = false;
      });
    }
  }

  Future<void> _refreshContent() async {
    await _loadInitialContent();
  }

  List<Medium> _filterContentByGenre(List<Medium> content, String genre) {
    if (genre == 'Todos') return content;

    return content.where((item) {
      final itemGenres = item.genres.map((g) => g.toLowerCase()).toList();
      return itemGenres.contains(genre.toLowerCase());
    }).toList();
  }

  Future<void> _onGenreSelected(String genre) async {
    setState(() {
      _currentPage = 1;
      _isLoading = true;
      _hasError = false;
    });
    try {
      final contentPage = await getMediaPage(genre: genre == 'Todos' ? null : genre);
      final content = contentPage.data;

      if (!mounted) return;
      setState(() {
        _selectedGenre = genre;
        _allContent = content;
        _totalItems = contentPage.pagination.totalItems;
        _filteredContent = _filterContentByGenre(content, genre);
      });

      Fluttertoast.showToast(
        msg: genre == 'Todos' ? 'Mostrando todo o conteúdo' : 'Filtrado por: $genre',
        toastLength: Toast.LENGTH_SHORT,
        gravity: ToastGravity.BOTTOM,
        backgroundColor: AppTheme.darkTheme.colorScheme.surface,
        textColor: AppTheme.contentWhite,
      );
    } catch (e) {
      Fluttertoast.showToast(
        msg: 'Erro ao filtrar por gênero: $e',
        toastLength: Toast.LENGTH_SHORT,
        gravity: ToastGravity.BOTTOM,
        backgroundColor: AppTheme.darkTheme.colorScheme.surface,
        textColor: AppTheme.contentWhite,
      );
      setState(() {
        _hasError = true;
      });
    } finally {
      if (mounted) {
        setState(() {
          _isLoading = false;
        });
      }
    }
  }

  void _onContentTap(Medium content) {
    Navigator.pushNamed(
      context,
      '/content-detail-screen',
      arguments: content,
    );
  }

  void _onFavorite(Medium content) {
    Fluttertoast.showToast(
      msg: '${content.title} adicionado aos favoritos',
      toastLength: Toast.LENGTH_SHORT,
      gravity: ToastGravity.BOTTOM,
      backgroundColor: AppTheme.accentColor,
      textColor: AppTheme.contentWhite,
    );
  }

  void _onShare(Medium content) {
    Fluttertoast.showToast(
      msg: 'Compartilhando: ${content.title}',
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
}
