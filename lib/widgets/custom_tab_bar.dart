import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

enum CustomTabBarVariant {
  primary,
  pills,
  underline,
  segmented,
}

class CustomTabBar extends StatefulWidget {
  final List<String> tabs;
  final CustomTabBarVariant variant;
  final int initialIndex;
  final ValueChanged<int>? onTap;
  final Color? selectedColor;
  final Color? unselectedColor;
  final Color? backgroundColor;
  final Color? indicatorColor;
  final EdgeInsetsGeometry? padding;
  final bool isScrollable;

  const CustomTabBar({
    super.key,
    required this.tabs,
    this.variant = CustomTabBarVariant.primary,
    this.initialIndex = 0,
    this.onTap,
    this.selectedColor,
    this.unselectedColor,
    this.backgroundColor,
    this.indicatorColor,
    this.padding,
    this.isScrollable = true,
  });

  @override
  State<CustomTabBar> createState() => _CustomTabBarState();
}

class _CustomTabBarState extends State<CustomTabBar>
    with TickerProviderStateMixin {
  late TabController _tabController;
  late AnimationController _animationController;

  @override
  void initState() {
    super.initState();
    _tabController = TabController(
      length: widget.tabs.length,
      vsync: this,
      initialIndex: widget.initialIndex,
    );
    _animationController = AnimationController(
      duration: const Duration(milliseconds: 300),
      vsync: this,
    );

    _tabController.addListener(() {
      if (_tabController.indexIsChanging) {
        widget.onTap?.call(_tabController.index);
        _handleTabNavigation(_tabController.index);
      }
    });
  }

  void _handleTabNavigation(int index) {
    // Navigate based on tab selection
    switch (index) {
      case 0:
        Navigator.pushNamed(context, '/content-browse-screen');
        break;
      case 1:
        Navigator.pushNamed(context, '/content-detail-screen');
        break;
      case 2:
        Navigator.pushNamed(context, '/genre-filter-screen');
        break;
    }
  }

  @override
  void dispose() {
    _tabController.dispose();
    _animationController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    switch (widget.variant) {
      case CustomTabBarVariant.pills:
        return _buildPillsTabBar(context);
      case CustomTabBarVariant.underline:
        return _buildUnderlineTabBar(context);
      case CustomTabBarVariant.segmented:
        return _buildSegmentedTabBar(context);
      default:
        return _buildPrimaryTabBar(context);
    }
  }

  Widget _buildPrimaryTabBar(BuildContext context) {
    final selectedColor = widget.selectedColor ?? const Color(0xFFE94560);
    final unselectedColor = widget.unselectedColor ?? const Color(0xFF8892B0);

    return Container(
      padding: widget.padding ?? const EdgeInsets.symmetric(horizontal: 16),
      color: widget.backgroundColor ?? Colors.transparent,
      child: TabBar(
        controller: _tabController,
        isScrollable: widget.isScrollable,
        labelColor: selectedColor,
        unselectedLabelColor: unselectedColor,
        indicatorColor: widget.indicatorColor ?? selectedColor,
        indicatorSize: TabBarIndicatorSize.label,
        indicatorWeight: 2,
        labelStyle: GoogleFonts.poppins(
          fontSize: 14,
          fontWeight: FontWeight.w600,
        ),
        unselectedLabelStyle: GoogleFonts.poppins(
          fontSize: 14,
          fontWeight: FontWeight.w400,
        ),
        tabs: widget.tabs.map((tab) => Tab(text: tab)).toList(),
      ),
    );
  }

  Widget _buildPillsTabBar(BuildContext context) {
    final selectedColor = widget.selectedColor ?? const Color(0xFFE94560);
    final unselectedColor = widget.unselectedColor ?? const Color(0xFF8892B0);

    return Container(
      padding: widget.padding ?? const EdgeInsets.all(16),
      child: SingleChildScrollView(
        scrollDirection: Axis.horizontal,
        child: Row(
          children: widget.tabs.asMap().entries.map((entry) {
            final index = entry.key;
            final tab = entry.value;
            final isSelected = index == _tabController.index;

            return Padding(
              padding: const EdgeInsets.only(right: 12),
              child: GestureDetector(
                onTap: () {
                  _tabController.animateTo(index);
                },
                child: AnimatedContainer(
                  duration: const Duration(milliseconds: 200),
                  padding:
                      const EdgeInsets.symmetric(horizontal: 20, vertical: 10),
                  decoration: BoxDecoration(
                    color: isSelected
                        ? selectedColor.withValues(alpha: 0.1)
                        : Colors.transparent,
                    borderRadius: BorderRadius.circular(20),
                    border: Border.all(
                      color:
                          isSelected ? selectedColor : const Color(0xFF2D3748),
                      width: 1,
                    ),
                  ),
                  child: Text(
                    tab,
                    style: GoogleFonts.inter(
                      fontSize: 14,
                      fontWeight:
                          isSelected ? FontWeight.w500 : FontWeight.w400,
                      color: isSelected ? selectedColor : unselectedColor,
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

  Widget _buildUnderlineTabBar(BuildContext context) {
    final selectedColor = widget.selectedColor ?? const Color(0xFFE94560);
    final unselectedColor = widget.unselectedColor ?? const Color(0xFF8892B0);

    return Container(
      padding: widget.padding ?? const EdgeInsets.symmetric(horizontal: 16),
      decoration: BoxDecoration(
        color: widget.backgroundColor ?? Colors.transparent,
        border: Border(
          bottom: BorderSide(
            color: const Color(0xFF2D3748).withValues(alpha: 0.3),
            width: 1,
          ),
        ),
      ),
      child: TabBar(
        controller: _tabController,
        isScrollable: widget.isScrollable,
        labelColor: selectedColor,
        unselectedLabelColor: unselectedColor,
        indicatorColor: selectedColor,
        indicatorSize: TabBarIndicatorSize.tab,
        indicatorWeight: 3,
        dividerColor: Colors.transparent,
        labelStyle: GoogleFonts.poppins(
          fontSize: 16,
          fontWeight: FontWeight.w600,
        ),
        unselectedLabelStyle: GoogleFonts.poppins(
          fontSize: 16,
          fontWeight: FontWeight.w400,
        ),
        tabs: widget.tabs
            .map(
              (tab) => Tab(
                child: Padding(
                  padding: const EdgeInsets.symmetric(vertical: 12),
                  child: Text(tab),
                ),
              ),
            )
            .toList(),
      ),
    );
  }

  Widget _buildSegmentedTabBar(BuildContext context) {
    final selectedColor = widget.selectedColor ?? const Color(0xFFE94560);
    final unselectedColor = widget.unselectedColor ?? const Color(0xFF8892B0);

    return Container(
      margin: widget.padding ?? const EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: const Color(0xFF16213E),
        borderRadius: BorderRadius.circular(12),
        border: Border.all(
          color: const Color(0xFF2D3748).withValues(alpha: 0.3),
        ),
      ),
      child: Row(
        children: widget.tabs.asMap().entries.map((entry) {
          final index = entry.key;
          final tab = entry.value;
          final isSelected = index == _tabController.index;
          final isFirst = index == 0;
          final isLast = index == widget.tabs.length - 1;

          return Expanded(
            child: GestureDetector(
              onTap: () {
                _tabController.animateTo(index);
              },
              child: AnimatedContainer(
                duration: const Duration(milliseconds: 200),
                padding: const EdgeInsets.symmetric(vertical: 12),
                decoration: BoxDecoration(
                  color: isSelected ? selectedColor : Colors.transparent,
                  borderRadius: BorderRadius.horizontal(
                    left: isFirst ? const Radius.circular(12) : Radius.zero,
                    right: isLast ? const Radius.circular(12) : Radius.zero,
                  ),
                ),
                child: Text(
                  tab,
                  textAlign: TextAlign.center,
                  style: GoogleFonts.inter(
                    fontSize: 14,
                    fontWeight: FontWeight.w500,
                    color:
                        isSelected ? const Color(0xFFFFFFFF) : unselectedColor,
                  ),
                ),
              ),
            ),
          );
        }).toList(),
      ),
    );
  }
}
