import 'package:flutter/material.dart';
import 'package:sizer/sizer.dart';

import '../../../core/app_export.dart';

class ActionButtonsWidget extends StatefulWidget {
  final bool isInWatchlist;
  final VoidCallback? onWatchlistToggle;
  final VoidCallback? onShare;

  const ActionButtonsWidget({
    super.key,
    this.isInWatchlist = false,
    this.onWatchlistToggle,
    this.onShare,
  });

  @override
  State<ActionButtonsWidget> createState() => _ActionButtonsWidgetState();
}

class _ActionButtonsWidgetState extends State<ActionButtonsWidget> with TickerProviderStateMixin {
  late AnimationController _heartAnimationController;
  late Animation<double> _heartScaleAnimation;
  bool _isInWatchlist = false;

  @override
  void initState() {
    super.initState();
    _isInWatchlist = widget.isInWatchlist;

    _heartAnimationController = AnimationController(
      duration: const Duration(milliseconds: 300),
      vsync: this,
    );

    _heartScaleAnimation = Tween<double>(
      begin: 1.0,
      end: 1.3,
    ).animate(CurvedAnimation(
      parent: _heartAnimationController,
      curve: Curves.elasticOut,
    ));
  }

  @override
  void dispose() {
    _heartAnimationController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      width: double.infinity,
      padding: EdgeInsets.symmetric(horizontal: 4.w, vertical: 3.h),
      child: Row(
        children: [
          
          Expanded(
            flex: 3,
            child: GestureDetector(
              onTap: _handleWatchlistToggle,
              child: Container(
                height: 6.h,
                decoration: BoxDecoration(
                  color: _isInWatchlist ? AppTheme.accentColor : AppTheme.accentColor.withValues(alpha: 0.1),
                  borderRadius: BorderRadius.circular(12),
                  border: Border.all(
                    color: AppTheme.accentColor,
                    width: _isInWatchlist ? 0 : 1,
                  ),
                ),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    AnimatedBuilder(
                      animation: _heartScaleAnimation,
                      builder: (context, child) {
                        return Transform.scale(
                          scale: _heartScaleAnimation.value,
                          child: Icon(
                            _isInWatchlist ? Icons.favorite : Icons.favorite_border,
                            color: _isInWatchlist ? AppTheme.contentWhite : AppTheme.accentColor,
                            size: 20,
                          ),
                        );
                      },
                    ),
                    SizedBox(width: 2.w),
                    Text(
                      _isInWatchlist ? 'Na Lista' : 'Adicionar à Lista',
                      style: AppTheme.darkTheme.textTheme.bodyMedium?.copyWith(
                        color: _isInWatchlist ? AppTheme.contentWhite : AppTheme.accentColor,
                        fontWeight: FontWeight.w600,
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ),

          SizedBox(width: 3.w),

          
          GestureDetector(
            onTap: _handleShare,
            child: Container(
              width: 6.h,
              height: 6.h,
              decoration: BoxDecoration(
                color: AppTheme.secondaryDark,
                borderRadius: BorderRadius.circular(12),
                border: Border.all(
                  color: AppTheme.borderColor.withValues(alpha: 0.3),
                ),
              ),
              child: Center(
                child: Icon(
                  Icons.share,
                  color: AppTheme.contentWhite,
                  size: 20,
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }

  void _handleWatchlistToggle() {
    setState(() {
      _isInWatchlist = !_isInWatchlist;
    });

    
    _heartAnimationController.forward().then((_) {
      _heartAnimationController.reverse();
    });

    
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        content: Text(
          _isInWatchlist ? 'Adicionado à sua lista de favoritos!' : 'Removido da sua lista de favoritos',
        ),
        backgroundColor: _isInWatchlist ? AppTheme.successColor : AppTheme.mutedText,
        behavior: SnackBarBehavior.floating,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(8),
        ),
      ),
    );

    widget.onWatchlistToggle?.call();
  }

  void _handleShare() {
    
    showModalBottomSheet(
      context: context,
      backgroundColor: AppTheme.surfaceDark,
      shape: const RoundedRectangleBorder(
        borderRadius: BorderRadius.vertical(
          top: Radius.circular(20),
        ),
      ),
      builder: (context) => Container(
        padding: EdgeInsets.all(4.w),
        child: Column(
          mainAxisSize: MainAxisSize.min,
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
              'Compartilhar',
              style: AppTheme.darkTheme.textTheme.titleMedium?.copyWith(
                color: AppTheme.contentWhite,
                fontWeight: FontWeight.w600,
              ),
            ),

            SizedBox(height: 3.h),

            
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: [
                _buildShareOption('WhatsApp', Icons.message, () {
                  Navigator.pop(context);
                  _showShareFeedback('WhatsApp');
                }),
                _buildShareOption('Copiar Link', Icons.link, () {
                  Navigator.pop(context);
                  _showShareFeedback('Link copiado');
                }),
                _buildShareOption('Mais', Icons.more_horiz, () {
                  Navigator.pop(context);
                  _showShareFeedback('Opções de compartilhamento');
                }),
              ],
            ),

            SizedBox(height: 4.h),
          ],
        ),
      ),
    );

    widget.onShare?.call();
  }

  Widget _buildShareOption(String label, IconData iconData, VoidCallback onTap) {
    return GestureDetector(
      onTap: onTap,
      child: Column(
        children: [
          Container(
            width: 15.w,
            height: 7.h,
            decoration: BoxDecoration(
              color: AppTheme.secondaryDark,
              borderRadius: BorderRadius.circular(12),
              border: Border.all(
                color: AppTheme.borderColor.withValues(alpha: 0.3),
              ),
            ),
            child: Center(
              child: Icon(
                iconData,
                color: AppTheme.contentWhite,
                size: 24,
              ),
            ),
          ),
          SizedBox(height: 1.h),
          Text(
            label,
            style: AppTheme.darkTheme.textTheme.bodySmall?.copyWith(
              color: AppTheme.mutedText,
            ),
          ),
        ],
      ),
    );
  }

  void _showShareFeedback(String message) {
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        content: Text(message),
        backgroundColor: AppTheme.successColor,
        behavior: SnackBarBehavior.floating,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(8),
        ),
      ),
    );
  }
}
