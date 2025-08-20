import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

enum CustomAppBarVariant {
  primary,
  transparent,
  search,
  detail,
}

class CustomAppBar extends StatelessWidget implements PreferredSizeWidget {
  final String? title;
  final CustomAppBarVariant variant;
  final List<Widget>? actions;
  final Widget? leading;
  final bool automaticallyImplyLeading;
  final VoidCallback? onSearchTap;
  final String? searchHint;
  final bool showBackButton;
  final Color? backgroundColor;
  final Color? foregroundColor;
  final double elevation;

  const CustomAppBar({
    super.key,
    this.title,
    this.variant = CustomAppBarVariant.primary,
    this.actions,
    this.leading,
    this.automaticallyImplyLeading = true,
    this.onSearchTap,
    this.searchHint,
    this.showBackButton = false,
    this.backgroundColor,
    this.foregroundColor,
    this.elevation = 0,
  });

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final colorScheme = theme.colorScheme;

    return AppBar(
      title: _buildTitle(context),
      backgroundColor: _getBackgroundColor(colorScheme),
      foregroundColor: _getForegroundColor(colorScheme),
      elevation: elevation,
      centerTitle: false,
      automaticallyImplyLeading: automaticallyImplyLeading,
      leading: _buildLeading(context),
      actions: _buildActions(context),
      titleTextStyle: _getTitleTextStyle(context),
      iconTheme: IconThemeData(
        color: _getForegroundColor(colorScheme),
        size: 24,
      ),
      actionsIconTheme: IconThemeData(
        color: _getForegroundColor(colorScheme),
        size: 24,
      ),
    );
  }

  Widget? _buildTitle(BuildContext context) {
    switch (variant) {
      case CustomAppBarVariant.search:
        return GestureDetector(
          onTap: onSearchTap ??
              () => Navigator.pushNamed(context, '/content-browse-screen'),
          child: Container(
            height: 40,
            decoration: BoxDecoration(
              color:
                  Theme.of(context).colorScheme.surface.withValues(alpha: 0.1),
              borderRadius: BorderRadius.circular(20),
              border: Border.all(
                color: const Color(0xFF2D3748).withValues(alpha: 0.3),
              ),
            ),
            child: Row(
              children: [
                const SizedBox(width: 16),
                Icon(
                  Icons.search,
                  color: const Color(0xFF8892B0),
                  size: 20,
                ),
                const SizedBox(width: 12),
                Expanded(
                  child: Text(
                    searchHint ?? 'Search movies, shows...',
                    style: GoogleFonts.inter(
                      fontSize: 14,
                      color: const Color(0xFF8892B0),
                      fontWeight: FontWeight.w400,
                    ),
                  ),
                ),
              ],
            ),
          ),
        );
      case CustomAppBarVariant.transparent:
        return null;
      default:
        return title != null ? Text(title!) : null;
    }
  }

  Widget? _buildLeading(BuildContext context) {
    if (leading != null) return leading;

    if (showBackButton ||
        (automaticallyImplyLeading && Navigator.canPop(context))) {
      return IconButton(
        icon: const Icon(Icons.arrow_back_ios),
        onPressed: () => Navigator.pop(context),
        tooltip: 'Back',
      );
    }

    return null;
  }

  List<Widget>? _buildActions(BuildContext context) {
    if (actions != null) return actions;

    switch (variant) {
      case CustomAppBarVariant.primary:
        return [
          IconButton(
            icon: const Icon(Icons.search),
            onPressed: () =>
                Navigator.pushNamed(context, '/content-browse-screen'),
            tooltip: 'Search',
          ),
          IconButton(
            icon: const Icon(Icons.filter_list),
            onPressed: () =>
                Navigator.pushNamed(context, '/genre-filter-screen'),
            tooltip: 'Filter',
          ),
          const SizedBox(width: 8),
        ];
      case CustomAppBarVariant.detail:
        return [
          IconButton(
            icon: const Icon(Icons.favorite_border),
            onPressed: () {
              // Add to favorites functionality
              ScaffoldMessenger.of(context).showSnackBar(
                const SnackBar(content: Text('Added to favorites')),
              );
            },
            tooltip: 'Add to favorites',
          ),
          IconButton(
            icon: const Icon(Icons.share),
            onPressed: () {
              // Share functionality
              ScaffoldMessenger.of(context).showSnackBar(
                const SnackBar(content: Text('Share functionality')),
              );
            },
            tooltip: 'Share',
          ),
          const SizedBox(width: 8),
        ];
      default:
        return null;
    }
  }

  Color _getBackgroundColor(ColorScheme colorScheme) {
    if (backgroundColor != null) return backgroundColor!;

    switch (variant) {
      case CustomAppBarVariant.transparent:
        return Colors.transparent;
      case CustomAppBarVariant.detail:
        return const Color(0xFF1A1A2E).withValues(alpha: 0.95);
      default:
        return const Color(0xFF1A1A2E);
    }
  }

  Color _getForegroundColor(ColorScheme colorScheme) {
    if (foregroundColor != null) return foregroundColor!;
    return const Color(0xFFFFFFFF);
  }

  TextStyle _getTitleTextStyle(BuildContext context) {
    switch (variant) {
      case CustomAppBarVariant.detail:
        return GoogleFonts.poppins(
          fontSize: 18,
          fontWeight: FontWeight.w600,
          color: _getForegroundColor(Theme.of(context).colorScheme),
        );
      default:
        return GoogleFonts.poppins(
          fontSize: 20,
          fontWeight: FontWeight.w600,
          color: _getForegroundColor(Theme.of(context).colorScheme),
        );
    }
  }

  @override
  Size get preferredSize => const Size.fromHeight(kToolbarHeight);
}
