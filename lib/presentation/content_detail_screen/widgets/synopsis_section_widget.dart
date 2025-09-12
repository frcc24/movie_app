import 'package:flutter/material.dart';
import 'package:sizer/sizer.dart';

import '../../../core/app_export.dart';
import '../../../theme/app_theme.dart';

class SynopsisSectionWidget extends StatefulWidget {
  final String synopsis;

  const SynopsisSectionWidget({
    super.key,
    required this.synopsis,
  });

  @override
  State<SynopsisSectionWidget> createState() => _SynopsisSectionWidgetState();
}

class _SynopsisSectionWidgetState extends State<SynopsisSectionWidget> {
  bool _isExpanded = false;
  static const int _maxLines = 3;

  @override
  Widget build(BuildContext context) {
    return Container(
      width: double.infinity,
      padding: EdgeInsets.symmetric(horizontal: 4.w, vertical: 2.h),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          
          Text(
            'Sinopse',
            style: AppTheme.darkTheme.textTheme.titleLarge?.copyWith(
              color: AppTheme.contentWhite,
              fontWeight: FontWeight.w600,
            ),
          ),

          SizedBox(height: 1.5.h),

          
          AnimatedCrossFade(
            firstChild: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  widget.synopsis,
                  style: AppTheme.darkTheme.textTheme.bodyLarge?.copyWith(
                    color: AppTheme.mutedText,
                    height: 1.5,
                  ),
                  maxLines: _maxLines,
                  overflow: TextOverflow.ellipsis,
                ),
                SizedBox(height: 1.h),
                GestureDetector(
                  onTap: () {
                    setState(() {
                      _isExpanded = true;
                    });
                  },
                  child: Text(
                    'Ver mais',
                    style: AppTheme.darkTheme.textTheme.bodyMedium?.copyWith(
                      color: AppTheme.accentColor,
                      fontWeight: FontWeight.w600,
                    ),
                  ),
                ),
              ],
            ),
            secondChild: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  widget.synopsis,
                  style: AppTheme.darkTheme.textTheme.bodyLarge?.copyWith(
                    color: AppTheme.mutedText,
                    height: 1.5,
                  ),
                ),
                SizedBox(height: 1.h),
                GestureDetector(
                  onTap: () {
                    setState(() {
                      _isExpanded = false;
                    });
                  },
                  child: Text(
                    'Ver menos',
                    style: AppTheme.darkTheme.textTheme.bodyMedium?.copyWith(
                      color: AppTheme.accentColor,
                      fontWeight: FontWeight.w600,
                    ),
                  ),
                ),
              ],
            ),
            crossFadeState: _isExpanded
                ? CrossFadeState.showSecond
                : CrossFadeState.showFirst,
            duration: const Duration(milliseconds: 300),
          ),
        ],
      ),
    );
  }
}
